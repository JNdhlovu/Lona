import AppKit
import Foundation

// MARK: - ImageViewer

public class ImageViewer: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(image: NSImage?, dimensions: String) {
    self.init(Parameters(image: image, dimensions: dimensions))
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

  public var image: NSImage? {
    get { return parameters.image }
    set {
      if parameters.image != newValue {
        parameters.image = newValue
      }
    }
  }

  public var dimensions: String {
    get { return parameters.dimensions }
    set {
      if parameters.dimensions != newValue {
        parameters.dimensions = newValue
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

  private var innerView = NSBox()
  private var headerView = NSBox()
  private var titleView = LNATextField(labelWithString: "")
  private var imageView = ImagePreview()
  private var dimensionsView = LNATextField(labelWithString: "")

  private var titleViewTextStyle = TextStyles.title
  private var dimensionsViewTextStyle = TextStyles.smallMuted.with(alignment: .center)

  private func setUpViews() {
    boxType = .custom
    borderType = .noBorder
    contentViewMargins = .zero
    innerView.boxType = .custom
    innerView.borderType = .noBorder
    innerView.contentViewMargins = .zero
    headerView.boxType = .custom
    headerView.borderType = .noBorder
    headerView.contentViewMargins = .zero
    dimensionsView.lineBreakMode = .byWordWrapping
    titleView.lineBreakMode = .byWordWrapping

    addSubview(innerView)
    innerView.addSubview(headerView)
    innerView.addSubview(imageView)
    innerView.addSubview(dimensionsView)
    headerView.addSubview(titleView)

    fillColor = Colors.contentBackground
    titleView.attributedStringValue = titleViewTextStyle.apply(to: "Image")
    titleViewTextStyle = TextStyles.title
    titleView.attributedStringValue = titleViewTextStyle.apply(to: titleView.attributedStringValue)
    imageView.resizingMode = .scaleAspectFit
    dimensionsViewTextStyle = TextStyles.smallMuted.with(alignment: .center)
    dimensionsView.attributedStringValue = dimensionsViewTextStyle.apply(to: dimensionsView.attributedStringValue)
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    innerView.translatesAutoresizingMaskIntoConstraints = false
    headerView.translatesAutoresizingMaskIntoConstraints = false
    imageView.translatesAutoresizingMaskIntoConstraints = false
    dimensionsView.translatesAutoresizingMaskIntoConstraints = false
    titleView.translatesAutoresizingMaskIntoConstraints = false

    let innerViewTopAnchorConstraint = innerView.topAnchor.constraint(equalTo: topAnchor, constant: 48)
    let innerViewBottomAnchorConstraint = innerView.bottomAnchor.constraint(equalTo: bottomAnchor)
    let innerViewLeadingAnchorConstraint = innerView.leadingAnchor.constraint(equalTo: leadingAnchor)
    let innerViewCenterXAnchorConstraint = innerView.centerXAnchor.constraint(equalTo: centerXAnchor)
    let innerViewTrailingAnchorConstraint = innerView.trailingAnchor.constraint(equalTo: trailingAnchor)
    let headerViewTopAnchorConstraint = headerView.topAnchor.constraint(equalTo: innerView.topAnchor)
    let headerViewLeadingAnchorConstraint = headerView.leadingAnchor.constraint(equalTo: innerView.leadingAnchor)
    let headerViewTrailingAnchorConstraint = headerView.trailingAnchor.constraint(equalTo: innerView.trailingAnchor)
    let imageViewTopAnchorConstraint = imageView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20)
    let imageViewLeadingAnchorConstraint = imageView
      .leadingAnchor
      .constraint(equalTo: innerView.leadingAnchor, constant: 20)
    let imageViewTrailingAnchorConstraint = imageView
      .trailingAnchor
      .constraint(equalTo: innerView.trailingAnchor, constant: -20)
    let dimensionsViewBottomAnchorConstraint = dimensionsView
      .bottomAnchor
      .constraint(equalTo: innerView.bottomAnchor, constant: -10)
    let dimensionsViewTopAnchorConstraint = dimensionsView
      .topAnchor
      .constraint(equalTo: imageView.bottomAnchor, constant: 27)
    let dimensionsViewLeadingAnchorConstraint = dimensionsView
      .leadingAnchor
      .constraint(equalTo: innerView.leadingAnchor)
    let dimensionsViewTrailingAnchorConstraint = dimensionsView
      .trailingAnchor
      .constraint(equalTo: innerView.trailingAnchor)
    let headerViewHeightAnchorConstraint = headerView.heightAnchor.constraint(equalToConstant: 38)
    let titleViewLeadingAnchorConstraint = titleView
      .leadingAnchor
      .constraint(equalTo: headerView.leadingAnchor, constant: 64)
    let titleViewTopAnchorConstraint = titleView.topAnchor.constraint(equalTo: headerView.topAnchor)
    let titleViewCenterYAnchorConstraint = titleView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
    let titleViewBottomAnchorConstraint = titleView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)

    NSLayoutConstraint.activate([
      innerViewTopAnchorConstraint,
      innerViewBottomAnchorConstraint,
      innerViewLeadingAnchorConstraint,
      innerViewCenterXAnchorConstraint,
      innerViewTrailingAnchorConstraint,
      headerViewTopAnchorConstraint,
      headerViewLeadingAnchorConstraint,
      headerViewTrailingAnchorConstraint,
      imageViewTopAnchorConstraint,
      imageViewLeadingAnchorConstraint,
      imageViewTrailingAnchorConstraint,
      dimensionsViewBottomAnchorConstraint,
      dimensionsViewTopAnchorConstraint,
      dimensionsViewLeadingAnchorConstraint,
      dimensionsViewTrailingAnchorConstraint,
      headerViewHeightAnchorConstraint,
      titleViewLeadingAnchorConstraint,
      titleViewTopAnchorConstraint,
      titleViewCenterYAnchorConstraint,
      titleViewBottomAnchorConstraint
    ])
  }

  private func update() {
    imageView.image = image
    dimensionsView.attributedStringValue = dimensionsViewTextStyle.apply(to: dimensions)
  }
}

// MARK: - Parameters

extension ImageViewer {
  public struct Parameters: Equatable {
    public var image: NSImage?
    public var dimensions: String

    public init(image: NSImage? = nil, dimensions: String) {
      self.image = image
      self.dimensions = dimensions
    }

    public init() {
      self.init(image: nil, dimensions: "")
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.image == rhs.image && lhs.dimensions == rhs.dimensions
    }
  }
}

// MARK: - Model

extension ImageViewer {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "ImageViewer"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(image: NSImage? = nil, dimensions: String) {
      self.init(Parameters(image: image, dimensions: dimensions))
    }

    public init() {
      self.init(image: nil, dimensions: "")
    }
  }
}
