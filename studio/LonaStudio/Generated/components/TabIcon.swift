import AppKit
import Foundation

// MARK: - TabIcon

public class TabIcon: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()

    addTrackingArea(trackingArea)
  }

  public convenience init(icon: NSImage, selected: Bool) {
    self.init(Parameters(icon: icon, selected: selected))
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

  public var icon: NSImage {
    get { return parameters.icon }
    set {
      if parameters.icon != newValue {
        parameters.icon = newValue
      }
    }
  }

  public var onClick: (() -> Void)? {
    get { return parameters.onClick }
    set { parameters.onClick = newValue }
  }

  public var selected: Bool {
    get { return parameters.selected }
    set {
      if parameters.selected != newValue {
        parameters.selected = newValue
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

  private lazy var trackingArea = NSTrackingArea(
    rect: self.frame,
    options: [.mouseEnteredAndExited, .activeAlways, .mouseMoved, .inVisibleRect],
    owner: self)

  private var imageView = LNAImageView()

  private var hovered = false
  private var pressed = false
  private var onPress: (() -> Void)?

  private func setUpViews() {
    boxType = .custom
    borderType = .noBorder
    contentViewMargins = .zero

    addSubview(imageView)
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    imageView.translatesAutoresizingMaskIntoConstraints = false

    let heightAnchorConstraint = heightAnchor.constraint(equalToConstant: 60)
    let widthAnchorConstraint = widthAnchor.constraint(equalToConstant: 60)
    let imageViewTopAnchorConstraint = imageView.topAnchor.constraint(equalTo: topAnchor, constant: 17)
    let imageViewCenterXAnchorConstraint = imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
    let imageViewHeightAnchorConstraint = imageView.heightAnchor.constraint(equalToConstant: 26)
    let imageViewWidthAnchorConstraint = imageView.widthAnchor.constraint(equalToConstant: 26)

    NSLayoutConstraint.activate([
      heightAnchorConstraint,
      widthAnchorConstraint,
      imageViewTopAnchorConstraint,
      imageViewCenterXAnchorConstraint,
      imageViewHeightAnchorConstraint,
      imageViewWidthAnchorConstraint
    ])
  }

  private func update() {
    fillColor = Colors.transparent
    imageView.image = icon
    onPress = handleOnClick
    if selected {
      fillColor = Colors.grey300
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

extension TabIcon {
  public struct Parameters: Equatable {
    public var icon: NSImage
    public var selected: Bool
    public var onClick: (() -> Void)?

    public init(icon: NSImage, selected: Bool, onClick: (() -> Void)? = nil) {
      self.icon = icon
      self.selected = selected
      self.onClick = onClick
    }

    public init() {
      self.init(icon: NSImage(), selected: false)
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.icon == rhs.icon && lhs.selected == rhs.selected
    }
  }
}

// MARK: - Model

extension TabIcon {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "TabIcon"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(icon: NSImage, selected: Bool, onClick: (() -> Void)? = nil) {
      self.init(Parameters(icon: icon, selected: selected, onClick: onClick))
    }

    public init() {
      self.init(icon: NSImage(), selected: false)
    }
  }
}
