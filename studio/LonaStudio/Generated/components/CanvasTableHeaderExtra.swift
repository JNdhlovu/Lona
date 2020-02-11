import AppKit
import Foundation

// MARK: - CanvasTableHeaderExtra

public class CanvasTableHeaderExtra: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()

    addTrackingArea(trackingArea)
  }

  public convenience init(dividerColor: NSColor) {
    self.init(Parameters(dividerColor: dividerColor))
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

  public var dividerColor: NSColor {
    get { return parameters.dividerColor }
    set {
      if parameters.dividerColor != newValue {
        parameters.dividerColor = newValue
      }
    }
  }

  public var onClickPlus: (() -> Void)? {
    get { return parameters.onClickPlus }
    set { parameters.onClickPlus = newValue }
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

  private var buttonView = NSBox()
  private var titleView = LNATextField(labelWithString: "")
  private var hDividerView = NSBox()

  private var titleViewTextStyle = TextStyles.large.with(alignment: .center)

  private var buttonViewHovered = false
  private var buttonViewPressed = false
  private var buttonViewOnPress: (() -> Void)?

  private func setUpViews() {
    boxType = .custom
    borderType = .noBorder
    contentViewMargins = .zero
    buttonView.boxType = .custom
    buttonView.borderType = .noBorder
    buttonView.contentViewMargins = .zero
    hDividerView.boxType = .custom
    hDividerView.borderType = .noBorder
    hDividerView.contentViewMargins = .zero
    titleView.lineBreakMode = .byWordWrapping

    addSubview(buttonView)
    addSubview(hDividerView)
    buttonView.addSubview(titleView)

    fillColor = Colors.contentHeaderBackground
    buttonView.cornerRadius = 11
    titleView.attributedStringValue = titleViewTextStyle.apply(to: "+")
    titleViewTextStyle = TextStyles.large.with(alignment: .center)
    titleView.attributedStringValue = titleViewTextStyle.apply(to: titleView.attributedStringValue)
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    buttonView.translatesAutoresizingMaskIntoConstraints = false
    hDividerView.translatesAutoresizingMaskIntoConstraints = false
    titleView.translatesAutoresizingMaskIntoConstraints = false

    let heightAnchorConstraint = heightAnchor.constraint(equalToConstant: 38)
    let buttonViewTopAnchorConstraint = buttonView.topAnchor.constraint(equalTo: topAnchor, constant: 7)
    let buttonViewLeadingAnchorConstraint = buttonView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
    let hDividerViewTopAnchorConstraint = hDividerView
      .topAnchor
      .constraint(equalTo: buttonView.bottomAnchor, constant: 8)
    let hDividerViewLeadingAnchorConstraint = hDividerView.leadingAnchor.constraint(equalTo: leadingAnchor)
    let hDividerViewTrailingAnchorConstraint = hDividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
    let buttonViewHeightAnchorConstraint = buttonView.heightAnchor.constraint(equalToConstant: 22)
    let buttonViewWidthAnchorConstraint = buttonView.widthAnchor.constraint(equalToConstant: 22)
    let titleViewTopAnchorConstraint = titleView.topAnchor.constraint(equalTo: buttonView.topAnchor)
    let titleViewLeadingAnchorConstraint = titleView.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor)
    let titleViewCenterXAnchorConstraint = titleView.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor)
    let titleViewTrailingAnchorConstraint = titleView.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor)
    let hDividerViewHeightAnchorConstraint = hDividerView.heightAnchor.constraint(equalToConstant: 1)

    NSLayoutConstraint.activate([
      heightAnchorConstraint,
      buttonViewTopAnchorConstraint,
      buttonViewLeadingAnchorConstraint,
      hDividerViewTopAnchorConstraint,
      hDividerViewLeadingAnchorConstraint,
      hDividerViewTrailingAnchorConstraint,
      buttonViewHeightAnchorConstraint,
      buttonViewWidthAnchorConstraint,
      titleViewTopAnchorConstraint,
      titleViewLeadingAnchorConstraint,
      titleViewCenterXAnchorConstraint,
      titleViewTrailingAnchorConstraint,
      hDividerViewHeightAnchorConstraint
    ])
  }

  private func update() {
    buttonView.fillColor = Colors.headerBackground
    hDividerView.fillColor = dividerColor
    buttonViewOnPress = handleOnClickPlus
    if buttonViewPressed {
      buttonView.fillColor = Colors.headerBackground
    }
  }

  private func handleOnClickPlus() {
    onClickPlus?()
  }

  private func updateHoverState(with event: NSEvent) {
    let buttonViewHovered = buttonView.bounds.contains(buttonView.convert(event.locationInWindow, from: nil))
    if buttonViewHovered != self.buttonViewHovered {
      self.buttonViewHovered = buttonViewHovered

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
    let buttonViewPressed = buttonView.bounds.contains(buttonView.convert(event.locationInWindow, from: nil))
    if buttonViewPressed != self.buttonViewPressed {
      self.buttonViewPressed = buttonViewPressed

      update()
    }
  }

  public override func mouseUp(with event: NSEvent) {
    let buttonViewClicked = buttonViewPressed &&
      buttonView.bounds.contains(buttonView.convert(event.locationInWindow, from: nil))

    if buttonViewPressed {
      buttonViewPressed = false

      update()
    }

    if buttonViewClicked {
      buttonViewOnPress?()
    }
  }
}

// MARK: - Parameters

extension CanvasTableHeaderExtra {
  public struct Parameters: Equatable {
    public var dividerColor: NSColor
    public var onClickPlus: (() -> Void)?

    public init(dividerColor: NSColor, onClickPlus: (() -> Void)? = nil) {
      self.dividerColor = dividerColor
      self.onClickPlus = onClickPlus
    }

    public init() {
      self.init(dividerColor: NSColor.clear)
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.dividerColor == rhs.dividerColor
    }
  }
}

// MARK: - Model

extension CanvasTableHeaderExtra {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "CanvasTableHeaderExtra"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(dividerColor: NSColor, onClickPlus: (() -> Void)? = nil) {
      self.init(Parameters(dividerColor: dividerColor, onClickPlus: onClickPlus))
    }

    public init() {
      self.init(dividerColor: NSColor.clear)
    }
  }
}
