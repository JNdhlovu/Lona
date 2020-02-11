import AppKit
import Foundation

// MARK: - InspectorSectionHeader

public class InspectorSectionHeader: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()

    addTrackingArea(trackingArea)
  }

  public convenience init(titleText: String, isExpanded: Bool) {
    self.init(Parameters(titleText: titleText, isExpanded: isExpanded))
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

    addTrackingArea(trackingArea)
  }

  deinit {
    removeTrackingArea(trackingArea)
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

  public var isExpanded: Bool {
    get { return parameters.isExpanded }
    set {
      if parameters.isExpanded != newValue {
        parameters.isExpanded = newValue
      }
    }
  }

  public var onClick: (() -> Void)? {
    get { return parameters.onClick }
    set { parameters.onClick = newValue }
  }

  public var parameters: Parameters {
    didSet {
      if parameters != oldValue {
        update()
      }
    }
  }

  // MARK: Private

  private lazy var trackingArea = NSTrackingArea(
    rect: self.frame,
    options: [.mouseEnteredAndExited, .activeAlways, .mouseMoved, .inVisibleRect],
    owner: self)

  private var disclosureArrowView = LNATextField(labelWithString: "")
  private var layoutWrapperView = NSBox()
  private var headerView = LNATextField(labelWithString: "")

  private var disclosureArrowViewTextStyle = TextStyles.sectionTitle
  private var headerViewTextStyle = TextStyles.sectionTitle

  private var hovered = false
  private var pressed = false
  private var onPress: (() -> Void)?

  private func setUpViews() {
    boxType = .custom
    borderType = .noBorder
    contentViewMargins = .zero
    disclosureArrowView.lineBreakMode = .byWordWrapping
    layoutWrapperView.boxType = .custom
    layoutWrapperView.borderType = .noBorder
    layoutWrapperView.contentViewMargins = .zero
    headerView.lineBreakMode = .byWordWrapping

    addSubview(disclosureArrowView)
    addSubview(layoutWrapperView)
    layoutWrapperView.addSubview(headerView)

    disclosureArrowViewTextStyle = TextStyles.sectionTitle
    disclosureArrowView.attributedStringValue =
      disclosureArrowViewTextStyle.apply(to: disclosureArrowView.attributedStringValue)
    disclosureArrowView.alphaValue = 0.7
    headerViewTextStyle = TextStyles.sectionTitle
    headerView.attributedStringValue = headerViewTextStyle.apply(to: headerView.attributedStringValue)
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    disclosureArrowView.translatesAutoresizingMaskIntoConstraints = false
    layoutWrapperView.translatesAutoresizingMaskIntoConstraints = false
    headerView.translatesAutoresizingMaskIntoConstraints = false

    let disclosureArrowViewHeightAnchorParentConstraint = disclosureArrowView
      .heightAnchor
      .constraint(lessThanOrEqualTo: heightAnchor, constant: -32)
    let layoutWrapperViewHeightAnchorParentConstraint = layoutWrapperView
      .heightAnchor
      .constraint(lessThanOrEqualTo: heightAnchor, constant: -32)
    let disclosureArrowViewLeadingAnchorConstraint = disclosureArrowView
      .leadingAnchor
      .constraint(equalTo: leadingAnchor)
    let disclosureArrowViewTopAnchorConstraint = disclosureArrowView
      .topAnchor
      .constraint(equalTo: topAnchor, constant: 16)
    let disclosureArrowViewBottomAnchorConstraint = disclosureArrowView
      .bottomAnchor
      .constraint(equalTo: bottomAnchor, constant: -16)
    let layoutWrapperViewTrailingAnchorConstraint = layoutWrapperView.trailingAnchor.constraint(equalTo: trailingAnchor)
    let layoutWrapperViewLeadingAnchorConstraint = layoutWrapperView
      .leadingAnchor
      .constraint(equalTo: disclosureArrowView.trailingAnchor, constant: 10)
    let layoutWrapperViewTopAnchorConstraint = layoutWrapperView.topAnchor.constraint(equalTo: topAnchor, constant: 16)
    let layoutWrapperViewBottomAnchorConstraint = layoutWrapperView
      .bottomAnchor
      .constraint(equalTo: bottomAnchor, constant: -16)
    let headerViewTopAnchorConstraint = headerView.topAnchor.constraint(equalTo: layoutWrapperView.topAnchor)
    let headerViewBottomAnchorConstraint = headerView.bottomAnchor.constraint(equalTo: layoutWrapperView.bottomAnchor)
    let headerViewLeadingAnchorConstraint = headerView
      .leadingAnchor
      .constraint(equalTo: layoutWrapperView.leadingAnchor)
    let headerViewTrailingAnchorConstraint = headerView
      .trailingAnchor
      .constraint(equalTo: layoutWrapperView.trailingAnchor)

    disclosureArrowViewHeightAnchorParentConstraint.priority = NSLayoutConstraint.Priority.defaultLow
    layoutWrapperViewHeightAnchorParentConstraint.priority = NSLayoutConstraint.Priority.defaultLow

    NSLayoutConstraint.activate([
      disclosureArrowViewHeightAnchorParentConstraint,
      layoutWrapperViewHeightAnchorParentConstraint,
      disclosureArrowViewLeadingAnchorConstraint,
      disclosureArrowViewTopAnchorConstraint,
      disclosureArrowViewBottomAnchorConstraint,
      layoutWrapperViewTrailingAnchorConstraint,
      layoutWrapperViewLeadingAnchorConstraint,
      layoutWrapperViewTopAnchorConstraint,
      layoutWrapperViewBottomAnchorConstraint,
      headerViewTopAnchorConstraint,
      headerViewBottomAnchorConstraint,
      headerViewLeadingAnchorConstraint,
      headerViewTrailingAnchorConstraint
    ])
  }

  private func update() {
    disclosureArrowView.attributedStringValue = disclosureArrowViewTextStyle.apply(to: "▶")
    onPress = handleOnClick
    headerView.attributedStringValue = headerViewTextStyle.apply(to: titleText)
    if isExpanded {
      disclosureArrowView.attributedStringValue = disclosureArrowViewTextStyle.apply(to: "▼")
    }
  }

  private func handleOnClick() {
    onClick?()
  }

  private func updateHoverState(with event: NSEvent) {
    let hovered = bounds.contains(convert(event.locationInWindow, from: nil))
    if hovered != self.hovered {
      self.hovered = hovered

      update()
    }
  }

  public override func mouseEntered(with event: NSEvent) {
    updateHoverState(with: event)
  }

  public override func mouseMoved(with event: NSEvent) {
    updateHoverState(with: event)
  }

  public override func mouseDragged(with event: NSEvent) {
    updateHoverState(with: event)
  }

  public override func mouseExited(with event: NSEvent) {
    updateHoverState(with: event)
  }

  public override func mouseDown(with event: NSEvent) {
    let pressed = bounds.contains(convert(event.locationInWindow, from: nil))
    if pressed != self.pressed {
      self.pressed = pressed

      update()
    }
  }

  public override func mouseUp(with event: NSEvent) {
    let clicked = pressed && bounds.contains(convert(event.locationInWindow, from: nil))

    if pressed {
      pressed = false

      update()
    }

    if clicked {
      onPress?()
    }
  }
}

// MARK: - Parameters

extension InspectorSectionHeader {
  public struct Parameters: Equatable {
    public var titleText: String
    public var isExpanded: Bool
    public var onClick: (() -> Void)?

    public init(titleText: String, isExpanded: Bool, onClick: (() -> Void)? = nil) {
      self.titleText = titleText
      self.isExpanded = isExpanded
      self.onClick = onClick
    }

    public init() {
      self.init(titleText: "", isExpanded: false)
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.titleText == rhs.titleText && lhs.isExpanded == rhs.isExpanded
    }
  }
}

// MARK: - Model

extension InspectorSectionHeader {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "InspectorSectionHeader"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(titleText: String, isExpanded: Bool, onClick: (() -> Void)? = nil) {
      self.init(Parameters(titleText: titleText, isExpanded: isExpanded, onClick: onClick))
    }

    public init() {
      self.init(titleText: "", isExpanded: false)
    }
  }
}
