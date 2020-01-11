import AppKit
import Foundation

// MARK: - Optionals

public class Optionals: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(boolParam: Bool?, stringParam: String?) {
    self.init(Parameters(boolParam: boolParam, stringParam: stringParam))
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

  public var boolParam: Bool? {
    get { return parameters.boolParam }
    set {
      if parameters.boolParam != newValue {
        parameters.boolParam = newValue
      }
    }
  }

  public var stringParam: String? {
    get { return parameters.stringParam }
    set {
      if parameters.stringParam != newValue {
        parameters.stringParam = newValue
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

  private var labelView = LNATextField(labelWithString: "")
  private var stringParamView = LNATextField(labelWithString: "")

  private var labelViewTextStyle = TextStyles.body1
  private var stringParamViewTextStyle = TextStyles.body1

  private func setUpViews() {
    boxType = .custom
    borderType = .noBorder
    contentViewMargins = .zero
    labelView.lineBreakMode = .byWordWrapping
    stringParamView.lineBreakMode = .byWordWrapping

    addSubview(labelView)
    addSubview(stringParamView)
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    labelView.translatesAutoresizingMaskIntoConstraints = false
    stringParamView.translatesAutoresizingMaskIntoConstraints = false

    let labelViewTopAnchorConstraint = labelView.topAnchor.constraint(equalTo: topAnchor)
    let labelViewLeadingAnchorConstraint = labelView.leadingAnchor.constraint(equalTo: leadingAnchor)
    let labelViewTrailingAnchorConstraint = labelView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor)
    let stringParamViewBottomAnchorConstraint = stringParamView.bottomAnchor.constraint(equalTo: bottomAnchor)
    let stringParamViewTopAnchorConstraint = stringParamView.topAnchor.constraint(equalTo: labelView.bottomAnchor)
    let stringParamViewLeadingAnchorConstraint = stringParamView.leadingAnchor.constraint(equalTo: leadingAnchor)
    let stringParamViewTrailingAnchorConstraint = stringParamView
      .trailingAnchor
      .constraint(lessThanOrEqualTo: trailingAnchor)

    NSLayoutConstraint.activate([
      labelViewTopAnchorConstraint,
      labelViewLeadingAnchorConstraint,
      labelViewTrailingAnchorConstraint,
      stringParamViewBottomAnchorConstraint,
      stringParamViewTopAnchorConstraint,
      stringParamViewLeadingAnchorConstraint,
      stringParamViewTrailingAnchorConstraint
    ])
  }

  private func update() {
    labelView.attributedStringValue = labelViewTextStyle.apply(to: "")
    stringParamView.attributedStringValue = stringParamViewTextStyle.apply(to: "No string param")
    fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    if boolParam == true {
      labelView.attributedStringValue = labelViewTextStyle.apply(to: "boolParam is true")
      fillColor = Colors.green200
    }
    if boolParam == false {
      labelView.attributedStringValue = labelViewTextStyle.apply(to: "boolParam is false")
      fillColor = Colors.red200
    }
    if boolParam == nil {
      labelView.attributedStringValue = labelViewTextStyle.apply(to: "boolParam is null")
    }
    if let unwrapped = stringParam {
      stringParamView.attributedStringValue = stringParamViewTextStyle.apply(to: unwrapped)
    }
  }
}

// MARK: - Parameters

extension Optionals {
  public struct Parameters: Equatable {
    public var boolParam: Bool?
    public var stringParam: String?

    public init(boolParam: Bool? = nil, stringParam: String? = nil) {
      self.boolParam = boolParam
      self.stringParam = stringParam
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.boolParam == rhs.boolParam && lhs.stringParam == rhs.stringParam
    }
  }
}

// MARK: - Model

extension Optionals {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "Optionals"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(boolParam: Bool? = nil, stringParam: String? = nil) {
      self.init(Parameters(boolParam: boolParam, stringParam: stringParam))
    }
  }
}
