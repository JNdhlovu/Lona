import AppKit
import Foundation

// MARK: - ImageWithBackgroundColor

private class ImageWithBackgroundColor: LNAImageView {
  var fillColor = NSColor.clear

  override func draw(_ dirtyRect: NSRect) {
    fillColor.set()
    bounds.fill()
    super.draw(dirtyRect)
  }
}


// MARK: - PrimaryAxisFillSiblings

public class PrimaryAxisFillSiblings: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
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

  public var parameters: Parameters {
    didSet {
      if parameters != oldValue {
        update()
      }
    }
  }

  // MARK: Private

  private var horizontalView = NSBox()
  private var leftCardView = NSBox()
  private var imageView = ImageWithBackgroundColor()
  private var titleView = LNATextField(labelWithString: "")
  private var subtitleView = LNATextField(labelWithString: "")
  private var spacerView = NSBox()
  private var rightCardView = NSBox()
  private var image1View = ImageWithBackgroundColor()
  private var title1View = LNATextField(labelWithString: "")
  private var subtitle1View = LNATextField(labelWithString: "")

  private var titleViewTextStyle = TextStyles.body2
  private var subtitleViewTextStyle = TextStyles.body1
  private var title1ViewTextStyle = TextStyles.body2
  private var subtitle1ViewTextStyle = TextStyles.body1

  private func setUpViews() {
    boxType = .custom
    borderType = .noBorder
    contentViewMargins = .zero
    horizontalView.boxType = .custom
    horizontalView.borderType = .noBorder
    horizontalView.contentViewMargins = .zero
    leftCardView.boxType = .custom
    leftCardView.borderType = .noBorder
    leftCardView.contentViewMargins = .zero
    spacerView.boxType = .custom
    spacerView.borderType = .noBorder
    spacerView.contentViewMargins = .zero
    rightCardView.boxType = .custom
    rightCardView.borderType = .noBorder
    rightCardView.contentViewMargins = .zero
    titleView.lineBreakMode = .byWordWrapping
    subtitleView.lineBreakMode = .byWordWrapping
    title1View.lineBreakMode = .byWordWrapping
    subtitle1View.lineBreakMode = .byWordWrapping

    addSubview(horizontalView)
    horizontalView.addSubview(leftCardView)
    horizontalView.addSubview(spacerView)
    horizontalView.addSubview(rightCardView)
    leftCardView.addSubview(imageView)
    leftCardView.addSubview(titleView)
    leftCardView.addSubview(subtitleView)
    rightCardView.addSubview(image1View)
    rightCardView.addSubview(title1View)
    rightCardView.addSubview(subtitle1View)

    fillColor = Colors.teal50
    horizontalView.fillColor = Colors.teal100
    imageView.image = #imageLiteral(resourceName: "icon_128x128")
    imageView.fillColor = Colors.teal200
    titleView.attributedStringValue = titleViewTextStyle.apply(to: "Title")
    titleViewTextStyle = TextStyles.body2
    titleView.attributedStringValue = titleViewTextStyle.apply(to: titleView.attributedStringValue)
    subtitleView.attributedStringValue = subtitleViewTextStyle.apply(to: "Subtitle")
    subtitleViewTextStyle = TextStyles.body1
    subtitleView.attributedStringValue = subtitleViewTextStyle.apply(to: subtitleView.attributedStringValue)
    spacerView.fillColor = #colorLiteral(red: 0.847058823529, green: 0.847058823529, blue: 0.847058823529, alpha: 1)
    image1View.image = #imageLiteral(resourceName: "icon_128x128")
    image1View.fillColor = Colors.teal200
    title1View.attributedStringValue = title1ViewTextStyle.apply(to: "Title")
    title1ViewTextStyle = TextStyles.body2
    title1View.attributedStringValue = title1ViewTextStyle.apply(to: title1View.attributedStringValue)
    subtitle1View.attributedStringValue = subtitle1ViewTextStyle.apply(to: "Subtitle")
    subtitle1ViewTextStyle = TextStyles.body1
    subtitle1View.attributedStringValue = subtitle1ViewTextStyle.apply(to: subtitle1View.attributedStringValue)
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    horizontalView.translatesAutoresizingMaskIntoConstraints = false
    leftCardView.translatesAutoresizingMaskIntoConstraints = false
    spacerView.translatesAutoresizingMaskIntoConstraints = false
    rightCardView.translatesAutoresizingMaskIntoConstraints = false
    imageView.translatesAutoresizingMaskIntoConstraints = false
    titleView.translatesAutoresizingMaskIntoConstraints = false
    subtitleView.translatesAutoresizingMaskIntoConstraints = false
    image1View.translatesAutoresizingMaskIntoConstraints = false
    title1View.translatesAutoresizingMaskIntoConstraints = false
    subtitle1View.translatesAutoresizingMaskIntoConstraints = false

    let horizontalViewTopAnchorConstraint = horizontalView.topAnchor.constraint(equalTo: topAnchor, constant: 10)
    let horizontalViewBottomAnchorConstraint = horizontalView
      .bottomAnchor
      .constraint(equalTo: bottomAnchor, constant: -10)
    let horizontalViewLeadingAnchorConstraint = horizontalView
      .leadingAnchor
      .constraint(equalTo: leadingAnchor, constant: 10)
    let horizontalViewTrailingAnchorConstraint = horizontalView
      .trailingAnchor
      .constraint(equalTo: trailingAnchor, constant: -10)
    let leftCardViewRightCardViewWidthAnchorSiblingConstraint = leftCardView
      .widthAnchor
      .constraint(equalTo: rightCardView.widthAnchor)
    let leftCardViewHeightAnchorParentConstraint = leftCardView
      .heightAnchor
      .constraint(lessThanOrEqualTo: horizontalView.heightAnchor)
    let spacerViewHeightAnchorParentConstraint = spacerView
      .heightAnchor
      .constraint(lessThanOrEqualTo: horizontalView.heightAnchor)
    let rightCardViewHeightAnchorParentConstraint = rightCardView
      .heightAnchor
      .constraint(lessThanOrEqualTo: horizontalView.heightAnchor)
    let leftCardViewLeadingAnchorConstraint = leftCardView
      .leadingAnchor
      .constraint(equalTo: horizontalView.leadingAnchor)
    let leftCardViewTopAnchorConstraint = leftCardView.topAnchor.constraint(equalTo: horizontalView.topAnchor)
    let leftCardViewBottomAnchorConstraint = leftCardView.bottomAnchor.constraint(equalTo: horizontalView.bottomAnchor)
    let spacerViewLeadingAnchorConstraint = spacerView.leadingAnchor.constraint(equalTo: leftCardView.trailingAnchor)
    let spacerViewTopAnchorConstraint = spacerView.topAnchor.constraint(equalTo: horizontalView.topAnchor)
    let rightCardViewTrailingAnchorConstraint = rightCardView
      .trailingAnchor
      .constraint(equalTo: horizontalView.trailingAnchor)
    let rightCardViewLeadingAnchorConstraint = rightCardView
      .leadingAnchor
      .constraint(equalTo: spacerView.trailingAnchor)
    let rightCardViewTopAnchorConstraint = rightCardView.topAnchor.constraint(equalTo: horizontalView.topAnchor)
    let rightCardViewBottomAnchorConstraint = rightCardView
      .bottomAnchor
      .constraint(equalTo: horizontalView.bottomAnchor)
    let imageViewTopAnchorConstraint = imageView.topAnchor.constraint(equalTo: leftCardView.topAnchor)
    let imageViewLeadingAnchorConstraint = imageView.leadingAnchor.constraint(equalTo: leftCardView.leadingAnchor)
    let imageViewTrailingAnchorConstraint = imageView.trailingAnchor.constraint(equalTo: leftCardView.trailingAnchor)
    let titleViewTopAnchorConstraint = titleView.topAnchor.constraint(equalTo: imageView.bottomAnchor)
    let titleViewLeadingAnchorConstraint = titleView.leadingAnchor.constraint(equalTo: leftCardView.leadingAnchor)
    let titleViewTrailingAnchorConstraint = titleView.trailingAnchor.constraint(equalTo: leftCardView.trailingAnchor)
    let subtitleViewBottomAnchorConstraint = subtitleView.bottomAnchor.constraint(equalTo: leftCardView.bottomAnchor)
    let subtitleViewTopAnchorConstraint = subtitleView.topAnchor.constraint(equalTo: titleView.bottomAnchor)
    let subtitleViewLeadingAnchorConstraint = subtitleView.leadingAnchor.constraint(equalTo: leftCardView.leadingAnchor)
    let subtitleViewTrailingAnchorConstraint = subtitleView
      .trailingAnchor
      .constraint(equalTo: leftCardView.trailingAnchor)
    let spacerViewHeightAnchorConstraint = spacerView.heightAnchor.constraint(equalToConstant: 0)
    let spacerViewWidthAnchorConstraint = spacerView.widthAnchor.constraint(equalToConstant: 8)
    let image1ViewTopAnchorConstraint = image1View.topAnchor.constraint(equalTo: rightCardView.topAnchor)
    let image1ViewLeadingAnchorConstraint = image1View.leadingAnchor.constraint(equalTo: rightCardView.leadingAnchor)
    let image1ViewTrailingAnchorConstraint = image1View.trailingAnchor.constraint(equalTo: rightCardView.trailingAnchor)
    let title1ViewTopAnchorConstraint = title1View.topAnchor.constraint(equalTo: image1View.bottomAnchor)
    let title1ViewLeadingAnchorConstraint = title1View.leadingAnchor.constraint(equalTo: rightCardView.leadingAnchor)
    let title1ViewTrailingAnchorConstraint = title1View.trailingAnchor.constraint(equalTo: rightCardView.trailingAnchor)
    let subtitle1ViewBottomAnchorConstraint = subtitle1View.bottomAnchor.constraint(equalTo: rightCardView.bottomAnchor)
    let subtitle1ViewTopAnchorConstraint = subtitle1View.topAnchor.constraint(equalTo: title1View.bottomAnchor)
    let subtitle1ViewLeadingAnchorConstraint = subtitle1View
      .leadingAnchor
      .constraint(equalTo: rightCardView.leadingAnchor)
    let subtitle1ViewTrailingAnchorConstraint = subtitle1View
      .trailingAnchor
      .constraint(equalTo: rightCardView.trailingAnchor)
    let imageViewHeightAnchorConstraint = imageView.heightAnchor.constraint(equalToConstant: 100)
    let image1ViewHeightAnchorConstraint = image1View.heightAnchor.constraint(equalToConstant: 100)

    leftCardViewHeightAnchorParentConstraint.priority = NSLayoutConstraint.Priority.defaultLow
    spacerViewHeightAnchorParentConstraint.priority = NSLayoutConstraint.Priority.defaultLow
    rightCardViewHeightAnchorParentConstraint.priority = NSLayoutConstraint.Priority.defaultLow

    NSLayoutConstraint.activate([
      horizontalViewTopAnchorConstraint,
      horizontalViewBottomAnchorConstraint,
      horizontalViewLeadingAnchorConstraint,
      horizontalViewTrailingAnchorConstraint,
      leftCardViewRightCardViewWidthAnchorSiblingConstraint,
      leftCardViewHeightAnchorParentConstraint,
      spacerViewHeightAnchorParentConstraint,
      rightCardViewHeightAnchorParentConstraint,
      leftCardViewLeadingAnchorConstraint,
      leftCardViewTopAnchorConstraint,
      leftCardViewBottomAnchorConstraint,
      spacerViewLeadingAnchorConstraint,
      spacerViewTopAnchorConstraint,
      rightCardViewTrailingAnchorConstraint,
      rightCardViewLeadingAnchorConstraint,
      rightCardViewTopAnchorConstraint,
      rightCardViewBottomAnchorConstraint,
      imageViewTopAnchorConstraint,
      imageViewLeadingAnchorConstraint,
      imageViewTrailingAnchorConstraint,
      titleViewTopAnchorConstraint,
      titleViewLeadingAnchorConstraint,
      titleViewTrailingAnchorConstraint,
      subtitleViewBottomAnchorConstraint,
      subtitleViewTopAnchorConstraint,
      subtitleViewLeadingAnchorConstraint,
      subtitleViewTrailingAnchorConstraint,
      spacerViewHeightAnchorConstraint,
      spacerViewWidthAnchorConstraint,
      image1ViewTopAnchorConstraint,
      image1ViewLeadingAnchorConstraint,
      image1ViewTrailingAnchorConstraint,
      title1ViewTopAnchorConstraint,
      title1ViewLeadingAnchorConstraint,
      title1ViewTrailingAnchorConstraint,
      subtitle1ViewBottomAnchorConstraint,
      subtitle1ViewTopAnchorConstraint,
      subtitle1ViewLeadingAnchorConstraint,
      subtitle1ViewTrailingAnchorConstraint,
      imageViewHeightAnchorConstraint,
      image1ViewHeightAnchorConstraint
    ])
  }

  private func update() {}
}

// MARK: - Parameters

extension PrimaryAxisFillSiblings {
  public struct Parameters: Equatable {
    public init() {}
  }
}

// MARK: - Model

extension PrimaryAxisFillSiblings {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "PrimaryAxisFillSiblings"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init() {
      self.init(Parameters())
    }
  }
}
