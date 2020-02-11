import AppKit
import Foundation

// MARK: - NumberInput

public class NumberInput: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(numberValue: CGFloat, disabled: Bool) {
    self.init(Parameters(numberValue: numberValue, disabled: disabled))
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

  public var numberValue: CGFloat {
    get { return parameters.numberValue }
    set {
      if parameters.numberValue != newValue {
        parameters.numberValue = newValue
      }
    }
  }

  public var onChangeNumberValue: NumberHandler {
    get { return parameters.onChangeNumberValue }
    set { parameters.onChangeNumberValue = newValue }
  }

  public var disabled: Bool {
    get { return parameters.disabled }
    set {
      if parameters.disabled != newValue {
        parameters.disabled = newValue
      }
    }
  }

  public var parameters: Parameters {
    didSet {
      if parameters != oldValue {
        update()
      }
    }
  }

  // MARK: Private

  private var textView = LNATextField(labelWithString: "")

  private var textViewTextStyle = TextStyles.regular

  private func setUpViews() {
    boxType = .custom
    borderType = .lineBorder
    contentViewMargins = .zero
    textView.lineBreakMode = .byWordWrapping

    addSubview(textView)

    fillColor = Colors.white
    borderColor = Colors.grey400
    borderWidth = 1
    textView.attributedStringValue = textViewTextStyle.apply(to: "Input text")
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    textView.translatesAutoresizingMaskIntoConstraints = false

    let textViewTopAnchorConstraint = textView.topAnchor.constraint(equalTo: topAnchor, constant: 3)
    let textViewLeadingAnchorConstraint = textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3)
    let textViewTrailingAnchorConstraint = textView
      .trailingAnchor
      .constraint(lessThanOrEqualTo: trailingAnchor, constant: -3)

    NSLayoutConstraint.activate([
      textViewTopAnchorConstraint,
      textViewLeadingAnchorConstraint,
      textViewTrailingAnchorConstraint
    ])
  }

  private func update() {}

  private func handleOnChangeNumberValue(_ arg0: CGFloat) {
    onChangeNumberValue?(arg0)
  }
}

// MARK: - Parameters

extension NumberInput {
  public struct Parameters: Equatable {
    public var numberValue: CGFloat
    public var disabled: Bool
    public var onChangeNumberValue: NumberHandler

    public init(numberValue: CGFloat, disabled: Bool, onChangeNumberValue: NumberHandler = nil) {
      self.numberValue = numberValue
      self.disabled = disabled
      self.onChangeNumberValue = onChangeNumberValue
    }

    public init() {
      self.init(numberValue: 0, disabled: false)
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.numberValue == rhs.numberValue && lhs.disabled == rhs.disabled
    }
  }
}

// MARK: - Model

extension NumberInput {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "NumberInput"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(numberValue: CGFloat, disabled: Bool, onChangeNumberValue: NumberHandler = nil) {
      self.init(Parameters(numberValue: numberValue, disabled: disabled, onChangeNumberValue: onChangeNumberValue))
    }

    public init() {
      self.init(numberValue: 0, disabled: false)
    }
  }
}
