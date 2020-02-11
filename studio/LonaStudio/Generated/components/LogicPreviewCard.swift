import AppKit
import Foundation

// MARK: - LogicPreviewCard

public class LogicPreviewCard: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(titleText: String, image: NSImage, selected: Bool) {
    self.init(Parameters(titleText: titleText, image: image, selected: selected))
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

  public var image: NSImage {
    get { return parameters.image }
    set {
      if parameters.image != newValue {
        parameters.image = newValue
      }
    }
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

  private var previewView = NSBox()
  private var imageView = LNAImageView()
  private var detailsView = NSBox()
  private var previewNameView = LNATextField(labelWithString: "")

  private var previewNameViewTextStyle = TextStyles.regular

  private func setUpViews() {
    boxType = .custom
    borderType = .lineBorder
    contentViewMargins = .zero
    previewView.boxType = .custom
    previewView.borderType = .noBorder
    previewView.contentViewMargins = .zero
    detailsView.boxType = .custom
    detailsView.borderType = .noBorder
    detailsView.contentViewMargins = .zero
    previewNameView.lineBreakMode = .byWordWrapping

    addSubview(previewView)
    addSubview(detailsView)
    previewView.addSubview(imageView)
    detailsView.addSubview(previewNameView)

    cornerRadius = 4
    borderWidth = 1
    previewView.fillColor = Colors.dividerSubtle
    previewView.cornerRadius = 3
    previewNameViewTextStyle = TextStyles.regular
    previewNameView.attributedStringValue = previewNameViewTextStyle.apply(to: previewNameView.attributedStringValue)
    previewNameView.maximumNumberOfLines = 2
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    previewView.translatesAutoresizingMaskIntoConstraints = false
    detailsView.translatesAutoresizingMaskIntoConstraints = false
    imageView.translatesAutoresizingMaskIntoConstraints = false
    previewNameView.translatesAutoresizingMaskIntoConstraints = false

    let previewViewTopAnchorConstraint = previewView.topAnchor.constraint(equalTo: topAnchor, constant: 5)
    let previewViewLeadingAnchorConstraint = previewView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5)
    let previewViewTrailingAnchorConstraint = previewView
      .trailingAnchor
      .constraint(equalTo: trailingAnchor, constant: -5)
    let detailsViewBottomAnchorConstraint = detailsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
    let detailsViewTopAnchorConstraint = detailsView
      .topAnchor
      .constraint(equalTo: previewView.bottomAnchor, constant: 5)
    let detailsViewLeadingAnchorConstraint = detailsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5)
    let detailsViewTrailingAnchorConstraint = detailsView
      .trailingAnchor
      .constraint(equalTo: trailingAnchor, constant: -5)
    let imageViewTopAnchorConstraint = imageView.topAnchor.constraint(equalTo: previewView.topAnchor)
    let imageViewBottomAnchorConstraint = imageView.bottomAnchor.constraint(equalTo: previewView.bottomAnchor)
    let imageViewLeadingAnchorConstraint = imageView.leadingAnchor.constraint(equalTo: previewView.leadingAnchor)
    let imageViewTrailingAnchorConstraint = imageView.trailingAnchor.constraint(equalTo: previewView.trailingAnchor)
    let previewNameViewTopAnchorConstraint = previewNameView.topAnchor.constraint(equalTo: detailsView.topAnchor)
    let previewNameViewBottomAnchorConstraint = previewNameView
      .bottomAnchor
      .constraint(equalTo: detailsView.bottomAnchor)
    let previewNameViewLeadingAnchorConstraint = previewNameView
      .leadingAnchor
      .constraint(equalTo: detailsView.leadingAnchor)
    let previewNameViewTrailingAnchorConstraint = previewNameView
      .trailingAnchor
      .constraint(equalTo: detailsView.trailingAnchor)

    NSLayoutConstraint.activate([
      previewViewTopAnchorConstraint,
      previewViewLeadingAnchorConstraint,
      previewViewTrailingAnchorConstraint,
      detailsViewBottomAnchorConstraint,
      detailsViewTopAnchorConstraint,
      detailsViewLeadingAnchorConstraint,
      detailsViewTrailingAnchorConstraint,
      imageViewTopAnchorConstraint,
      imageViewBottomAnchorConstraint,
      imageViewLeadingAnchorConstraint,
      imageViewTrailingAnchorConstraint,
      previewNameViewTopAnchorConstraint,
      previewNameViewBottomAnchorConstraint,
      previewNameViewLeadingAnchorConstraint,
      previewNameViewTrailingAnchorConstraint
    ])
  }

  private func update() {
    borderColor = Colors.transparent
    previewNameView.attributedStringValue = previewNameViewTextStyle.apply(to: titleText)
    imageView.image = image
    if selected {
      borderColor = Colors.lightblue600
    }
  }
}

// MARK: - Parameters

extension LogicPreviewCard {
  public struct Parameters: Equatable {
    public var titleText: String
    public var image: NSImage
    public var selected: Bool

    public init(titleText: String, image: NSImage, selected: Bool) {
      self.titleText = titleText
      self.image = image
      self.selected = selected
    }

    public init() {
      self.init(titleText: "", image: NSImage(), selected: false)
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.titleText == rhs.titleText && lhs.image == rhs.image && lhs.selected == rhs.selected
    }
  }
}

// MARK: - Model

extension LogicPreviewCard {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "LogicPreviewCard"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(titleText: String, image: NSImage, selected: Bool) {
      self.init(Parameters(titleText: titleText, image: image, selected: selected))
    }

    public init() {
      self.init(titleText: "", image: NSImage(), selected: false)
    }
  }
}
