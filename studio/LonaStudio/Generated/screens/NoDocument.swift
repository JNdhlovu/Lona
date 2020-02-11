import AppKit
import Foundation

// MARK: - NoDocument

public class NoDocument: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(titleText: String, buttonTitleText: String) {
    self.init(Parameters(titleText: titleText, buttonTitleText: buttonTitleText))
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

  public var onClick: (() -> Void)? {
    get { return parameters.onClick }
    set { parameters.onClick = newValue }
  }

  public var titleText: String {
    get { return parameters.titleText }
    set {
      if parameters.titleText != newValue {
        parameters.titleText = newValue
      }
    }
  }

  public var buttonTitleText: String {
    get { return parameters.buttonTitleText }
    set {
      if parameters.buttonTitleText != newValue {
        parameters.buttonTitleText = newValue
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

  private var spacer1View = NSBox()
  private var vContainerView = NSBox()
  private var titleView = LNATextField(labelWithString: "")
  private var buttonView = Button()
  private var spacer2View = NSBox()

  private var titleViewTextStyle = TextStyles.regular.with(alignment: .center)

  private func setUpViews() {
    boxType = .custom
    borderType = .noBorder
    contentViewMargins = .zero
    spacer1View.boxType = .custom
    spacer1View.borderType = .noBorder
    spacer1View.contentViewMargins = .zero
    vContainerView.boxType = .custom
    vContainerView.borderType = .lineBorder
    vContainerView.contentViewMargins = .zero
    spacer2View.boxType = .custom
    spacer2View.borderType = .noBorder
    spacer2View.contentViewMargins = .zero
    titleView.lineBreakMode = .byWordWrapping

    addSubview(spacer1View)
    addSubview(vContainerView)
    addSubview(spacer2View)
    vContainerView.addSubview(titleView)
    vContainerView.addSubview(buttonView)

    fillColor = Colors.contentBackground
    spacer1View.fillColor = #colorLiteral(red: 0.847058823529, green: 0.847058823529, blue: 0.847058823529, alpha: 1)
    vContainerView.fillColor = Colors.contentBackground
    vContainerView.borderColor = Colors.dividerSubtle
    vContainerView.cornerRadius = 4
    vContainerView.borderWidth = 1
    spacer2View.fillColor = #colorLiteral(red: 0.847058823529, green: 0.847058823529, blue: 0.847058823529, alpha: 1)
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    spacer1View.translatesAutoresizingMaskIntoConstraints = false
    vContainerView.translatesAutoresizingMaskIntoConstraints = false
    spacer2View.translatesAutoresizingMaskIntoConstraints = false
    titleView.translatesAutoresizingMaskIntoConstraints = false
    buttonView.translatesAutoresizingMaskIntoConstraints = false

    let spacer1ViewSpacer2ViewWidthAnchorSiblingConstraint = spacer1View
      .widthAnchor
      .constraint(equalTo: spacer2View.widthAnchor)
    let spacer1ViewLeadingAnchorConstraint = spacer1View.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60)
    let spacer1ViewTopAnchorConstraint = spacer1View.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 60)
    let spacer1ViewCenterYAnchorConstraint = spacer1View.centerYAnchor.constraint(equalTo: centerYAnchor)
    let spacer1ViewBottomAnchorConstraint = spacer1View
      .bottomAnchor
      .constraint(lessThanOrEqualTo: bottomAnchor, constant: -60)
    let vContainerViewLeadingAnchorConstraint = vContainerView
      .leadingAnchor
      .constraint(equalTo: spacer1View.trailingAnchor)
    let vContainerViewTopAnchorConstraint = vContainerView
      .topAnchor
      .constraint(greaterThanOrEqualTo: topAnchor, constant: 60)
    let vContainerViewCenterYAnchorConstraint = vContainerView.centerYAnchor.constraint(equalTo: centerYAnchor)
    let vContainerViewBottomAnchorConstraint = vContainerView
      .bottomAnchor
      .constraint(lessThanOrEqualTo: bottomAnchor, constant: -60)
    let spacer2ViewTrailingAnchorConstraint = spacer2View
      .trailingAnchor
      .constraint(equalTo: trailingAnchor, constant: -60)
    let spacer2ViewLeadingAnchorConstraint = spacer2View
      .leadingAnchor
      .constraint(equalTo: vContainerView.trailingAnchor)
    let spacer2ViewTopAnchorConstraint = spacer2View.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 60)
    let spacer2ViewCenterYAnchorConstraint = spacer2View.centerYAnchor.constraint(equalTo: centerYAnchor)
    let spacer2ViewBottomAnchorConstraint = spacer2View
      .bottomAnchor
      .constraint(lessThanOrEqualTo: bottomAnchor, constant: -60)
    let titleViewWidthAnchorParentConstraint = titleView
      .widthAnchor
      .constraint(lessThanOrEqualTo: vContainerView.widthAnchor, constant: -26)
    let buttonViewWidthAnchorParentConstraint = buttonView
      .widthAnchor
      .constraint(lessThanOrEqualTo: vContainerView.widthAnchor, constant: -26)
    let titleViewTopAnchorConstraint = titleView.topAnchor.constraint(equalTo: vContainerView.topAnchor, constant: 13)
    let titleViewLeadingAnchorConstraint = titleView
      .leadingAnchor
      .constraint(equalTo: vContainerView.leadingAnchor, constant: 13)
    let titleViewCenterXAnchorConstraint = titleView.centerXAnchor.constraint(equalTo: vContainerView.centerXAnchor)
    let titleViewTrailingAnchorConstraint = titleView
      .trailingAnchor
      .constraint(equalTo: vContainerView.trailingAnchor, constant: -13)
    let buttonViewBottomAnchorConstraint = buttonView
      .bottomAnchor
      .constraint(equalTo: vContainerView.bottomAnchor, constant: -13)
    let buttonViewTopAnchorConstraint = buttonView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 12)
    let buttonViewLeadingAnchorConstraint = buttonView
      .leadingAnchor
      .constraint(equalTo: vContainerView.leadingAnchor, constant: 13)
    let buttonViewCenterXAnchorConstraint = buttonView.centerXAnchor.constraint(equalTo: vContainerView.centerXAnchor)
    let buttonViewTrailingAnchorConstraint = buttonView
      .trailingAnchor
      .constraint(equalTo: vContainerView.trailingAnchor, constant: -13)

    titleViewWidthAnchorParentConstraint.priority = NSLayoutConstraint.Priority.defaultLow
    buttonViewWidthAnchorParentConstraint.priority = NSLayoutConstraint.Priority.defaultLow

    NSLayoutConstraint.activate([
      spacer1ViewSpacer2ViewWidthAnchorSiblingConstraint,
      spacer1ViewLeadingAnchorConstraint,
      spacer1ViewTopAnchorConstraint,
      spacer1ViewCenterYAnchorConstraint,
      spacer1ViewBottomAnchorConstraint,
      vContainerViewLeadingAnchorConstraint,
      vContainerViewTopAnchorConstraint,
      vContainerViewCenterYAnchorConstraint,
      vContainerViewBottomAnchorConstraint,
      spacer2ViewTrailingAnchorConstraint,
      spacer2ViewLeadingAnchorConstraint,
      spacer2ViewTopAnchorConstraint,
      spacer2ViewCenterYAnchorConstraint,
      spacer2ViewBottomAnchorConstraint,
      titleViewWidthAnchorParentConstraint,
      buttonViewWidthAnchorParentConstraint,
      titleViewTopAnchorConstraint,
      titleViewLeadingAnchorConstraint,
      titleViewCenterXAnchorConstraint,
      titleViewTrailingAnchorConstraint,
      buttonViewBottomAnchorConstraint,
      buttonViewTopAnchorConstraint,
      buttonViewLeadingAnchorConstraint,
      buttonViewCenterXAnchorConstraint,
      buttonViewTrailingAnchorConstraint
    ])
  }

  private func update() {
    buttonView.onClick = handleOnClick
    titleView.attributedStringValue = titleViewTextStyle.apply(to: titleText)
    buttonView.titleText = buttonTitleText
  }

  private func handleOnClick() {
    onClick?()
  }
}

// MARK: - Parameters

extension NoDocument {
  public struct Parameters: Equatable {
    public var titleText: String
    public var buttonTitleText: String
    public var onClick: (() -> Void)?

    public init(titleText: String, buttonTitleText: String, onClick: (() -> Void)? = nil) {
      self.titleText = titleText
      self.buttonTitleText = buttonTitleText
      self.onClick = onClick
    }

    public init() {
      self.init(titleText: "", buttonTitleText: "")
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.titleText == rhs.titleText && lhs.buttonTitleText == rhs.buttonTitleText
    }
  }
}

// MARK: - Model

extension NoDocument {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "NoDocument"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(titleText: String, buttonTitleText: String, onClick: (() -> Void)? = nil) {
      self.init(Parameters(titleText: titleText, buttonTitleText: buttonTitleText, onClick: onClick))
    }

    public init() {
      self.init(titleText: "", buttonTitleText: "")
    }
  }
}
