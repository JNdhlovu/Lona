import AppKit
import Foundation

// MARK: - CoreTextInput

public class CoreTextInput: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(textValue: String) {
    self.init(Parameters(textValue: textValue))
  }

  public convenience init() {
    self.init(Parameters())
  }

  public required init?(coder aDecoder: NSCoder) {
    self.parameters = Parameters()

    super.init(coder: aDecoder)

    setUpViews()
    setUpConstraints()

    update()
  }

  // MARK: Public

  public var textValue: String {
    get { return parameters.textValue }
    set {
      if parameters.textValue != newValue {
        parameters.textValue = newValue
      }
    }
  }

  public var onChangeTextValue: StringHandler {
    get { return parameters.onChangeTextValue }
    set { parameters.onChangeTextValue = newValue }
  }

  public var parameters: Parameters {
    didSet {
      if parameters != oldValue {
        update()
      }
    }
  }

  // MARK: Private

  private var textInputView = TextInput()

  private func setUpViews() {
    boxType = .custom
    borderType = .noBorder
    contentViewMargins = .zero

    addSubview(textInputView)
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    textInputView.translatesAutoresizingMaskIntoConstraints = false

    let heightAnchorConstraint = heightAnchor.constraint(equalToConstant: 21)
    let textInputViewTopAnchorConstraint = textInputView.topAnchor.constraint(equalTo: topAnchor)
    let textInputViewLeadingAnchorConstraint = textInputView.leadingAnchor.constraint(equalTo: leadingAnchor)
    let textInputViewTrailingAnchorConstraint = textInputView.trailingAnchor.constraint(equalTo: trailingAnchor)

    NSLayoutConstraint.activate([
      heightAnchorConstraint,
      textInputViewTopAnchorConstraint,
      textInputViewLeadingAnchorConstraint,
      textInputViewTrailingAnchorConstraint
    ])
  }

  private func update() {
    textInputView.textValue = textValue
    textInputView.onChangeTextValue = handleOnChangeTextValue
  }

  private func handleOnChangeTextValue(_ arg0: String) {
    onChangeTextValue?(arg0)
  }
}

// MARK: - Parameters

extension CoreTextInput {
  public struct Parameters: Equatable {
    public var textValue: String
    public var onChangeTextValue: StringHandler

    public init(textValue: String, onChangeTextValue: StringHandler = nil) {
      self.textValue = textValue
      self.onChangeTextValue = onChangeTextValue
    }

    public init() {
      self.init(textValue: "")
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.textValue == rhs.textValue
    }
  }
}

// MARK: - Model

extension CoreTextInput {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "CoreTextInput"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(textValue: String, onChangeTextValue: StringHandler = nil) {
      self.init(Parameters(textValue: textValue, onChangeTextValue: onChangeTextValue))
    }

    public init() {
      self.init(textValue: "")
    }
  }
}
