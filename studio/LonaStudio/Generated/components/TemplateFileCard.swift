import AppKit
import Foundation

// MARK: - TemplateFileCard

public class TemplateFileCard: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(titleText: String, subtitleText: String) {
    self.init(Parameters(titleText: titleText, subtitleText: subtitleText))
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

  public var titleText: String {
    get { return parameters.titleText }
    set {
      if parameters.titleText != newValue {
        parameters.titleText = newValue
      }
    }
  }

  public var subtitleText: String {
    get { return parameters.subtitleText }
    set {
      if parameters.subtitleText != newValue {
        parameters.subtitleText = newValue
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

  private var titleView = LNATextField(labelWithString: "")
  private var subtitleView = LNATextField(labelWithString: "")

  private var titleViewTextStyle = TextStyles.regular
  private var subtitleViewTextStyle = TextStyles.regularMuted

  private func setUpViews() {
    boxType = .custom
    borderType = .lineBorder
    contentViewMargins = .zero
    titleView.lineBreakMode = .byWordWrapping
    subtitleView.lineBreakMode = .byWordWrapping

    addSubview(titleView)
    addSubview(subtitleView)

    fillColor = Colors.windowBackground
    borderColor = Colors.dividerSubtle
    cornerRadius = 4
    borderWidth = 1
    subtitleViewTextStyle = TextStyles.regularMuted
    subtitleView.attributedStringValue = subtitleViewTextStyle.apply(to: subtitleView.attributedStringValue)
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    titleView.translatesAutoresizingMaskIntoConstraints = false
    subtitleView.translatesAutoresizingMaskIntoConstraints = false

    let titleViewTopAnchorConstraint = titleView.topAnchor.constraint(equalTo: topAnchor, constant: 15)
    let titleViewLeadingAnchorConstraint = titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
    let titleViewTrailingAnchorConstraint = titleView
      .trailingAnchor
      .constraint(lessThanOrEqualTo: trailingAnchor, constant: -15)
    let subtitleViewBottomAnchorConstraint = subtitleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
    let subtitleViewTopAnchorConstraint = subtitleView
      .topAnchor
      .constraint(equalTo: titleView.bottomAnchor, constant: 4)
    let subtitleViewLeadingAnchorConstraint = subtitleView
      .leadingAnchor
      .constraint(equalTo: leadingAnchor, constant: 15)
    let subtitleViewTrailingAnchorConstraint = subtitleView
      .trailingAnchor
      .constraint(lessThanOrEqualTo: trailingAnchor, constant: -15)

    NSLayoutConstraint.activate([
      titleViewTopAnchorConstraint,
      titleViewLeadingAnchorConstraint,
      titleViewTrailingAnchorConstraint,
      subtitleViewBottomAnchorConstraint,
      subtitleViewTopAnchorConstraint,
      subtitleViewLeadingAnchorConstraint,
      subtitleViewTrailingAnchorConstraint
    ])
  }

  private func update() {
    titleView.attributedStringValue = titleViewTextStyle.apply(to: titleText)
    subtitleView.attributedStringValue = subtitleViewTextStyle.apply(to: subtitleText)
  }
}

// MARK: - Parameters

extension TemplateFileCard {
  public struct Parameters: Equatable {
    public var titleText: String
    public var subtitleText: String

    public init(titleText: String, subtitleText: String) {
      self.titleText = titleText
      self.subtitleText = subtitleText
    }

    public init() {
      self.init(titleText: "", subtitleText: "")
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.titleText == rhs.titleText && lhs.subtitleText == rhs.subtitleText
    }
  }
}

// MARK: - Model

extension TemplateFileCard {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "TemplateFileCard"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(titleText: String, subtitleText: String) {
      self.init(Parameters(titleText: titleText, subtitleText: subtitleText))
    }

    public init() {
      self.init(titleText: "", subtitleText: "")
    }
  }
}
