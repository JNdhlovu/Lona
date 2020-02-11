import AppKit
import Foundation

// MARK: - ColorBrowser

public class ColorBrowser: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(colors: ColorList) {
    self.init(Parameters(colors: colors))
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

  public var onSelectColor: ColorHandler {
    get { return parameters.onSelectColor }
    set { parameters.onSelectColor = newValue }
  }

  public var onDeleteColor: ColorHandler {
    get { return parameters.onDeleteColor }
    set { parameters.onDeleteColor = newValue }
  }

  public var colors: ColorList {
    get { return parameters.colors }
    set {
      if parameters.colors != newValue {
        parameters.colors = newValue
      }
    }
  }

  public var onClickAddColor: (() -> Void)? {
    get { return parameters.onClickAddColor }
    set { parameters.onClickAddColor = newValue }
  }

  public var onMoveColor: ItemMoveHandler {
    get { return parameters.onMoveColor }
    set { parameters.onMoveColor = newValue }
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
  private var spacerView = NSBox()
  private var fixedHeightFixButtonContainerView = NSBox()
  private var addColorButtonView = Button()
  private var colorPreviewCollectionView = ColorPreviewCollection()

  private var titleViewTextStyle = TextStyles.title

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
    titleView.lineBreakMode = .byWordWrapping
    spacerView.boxType = .custom
    spacerView.borderType = .noBorder
    spacerView.contentViewMargins = .zero
    fixedHeightFixButtonContainerView.boxType = .custom
    fixedHeightFixButtonContainerView.borderType = .noBorder
    fixedHeightFixButtonContainerView.contentViewMargins = .zero

    addSubview(innerView)
    innerView.addSubview(headerView)
    innerView.addSubview(colorPreviewCollectionView)
    headerView.addSubview(titleView)
    headerView.addSubview(spacerView)
    headerView.addSubview(fixedHeightFixButtonContainerView)
    fixedHeightFixButtonContainerView.addSubview(addColorButtonView)

    fillColor = Colors.contentBackground
    titleView.attributedStringValue = titleViewTextStyle.apply(to: "Colors")
    titleViewTextStyle = TextStyles.title
    titleView.attributedStringValue = titleViewTextStyle.apply(to: titleView.attributedStringValue)
    addColorButtonView.titleText = "Add Color"
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    innerView.translatesAutoresizingMaskIntoConstraints = false
    headerView.translatesAutoresizingMaskIntoConstraints = false
    colorPreviewCollectionView.translatesAutoresizingMaskIntoConstraints = false
    titleView.translatesAutoresizingMaskIntoConstraints = false
    spacerView.translatesAutoresizingMaskIntoConstraints = false
    fixedHeightFixButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
    addColorButtonView.translatesAutoresizingMaskIntoConstraints = false

    let innerViewTopAnchorConstraint = innerView.topAnchor.constraint(equalTo: topAnchor, constant: 48)
    let innerViewBottomAnchorConstraint = innerView.bottomAnchor.constraint(equalTo: bottomAnchor)
    let innerViewLeadingAnchorConstraint = innerView.leadingAnchor.constraint(equalTo: leadingAnchor)
    let innerViewCenterXAnchorConstraint = innerView.centerXAnchor.constraint(equalTo: centerXAnchor)
    let innerViewTrailingAnchorConstraint = innerView.trailingAnchor.constraint(equalTo: trailingAnchor)
    let headerViewTopAnchorConstraint = headerView.topAnchor.constraint(equalTo: innerView.topAnchor)
    let headerViewLeadingAnchorConstraint = headerView.leadingAnchor.constraint(equalTo: innerView.leadingAnchor)
    let headerViewTrailingAnchorConstraint = headerView.trailingAnchor.constraint(equalTo: innerView.trailingAnchor)
    let colorPreviewCollectionViewBottomAnchorConstraint = colorPreviewCollectionView
      .bottomAnchor
      .constraint(equalTo: innerView.bottomAnchor)
    let colorPreviewCollectionViewTopAnchorConstraint = colorPreviewCollectionView
      .topAnchor
      .constraint(equalTo: headerView.bottomAnchor)
    let colorPreviewCollectionViewLeadingAnchorConstraint = colorPreviewCollectionView
      .leadingAnchor
      .constraint(equalTo: innerView.leadingAnchor)
    let colorPreviewCollectionViewTrailingAnchorConstraint = colorPreviewCollectionView
      .trailingAnchor
      .constraint(equalTo: innerView.trailingAnchor)
    let headerViewHeightAnchorConstraint = headerView.heightAnchor.constraint(equalToConstant: 38)
    let titleViewLeadingAnchorConstraint = titleView
      .leadingAnchor
      .constraint(equalTo: headerView.leadingAnchor, constant: 64)
    let titleViewTopAnchorConstraint = titleView.topAnchor.constraint(equalTo: headerView.topAnchor)
    let titleViewCenterYAnchorConstraint = titleView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
    let titleViewBottomAnchorConstraint = titleView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
    let spacerViewLeadingAnchorConstraint = spacerView.leadingAnchor.constraint(equalTo: titleView.trailingAnchor)
    let spacerViewCenterYAnchorConstraint = spacerView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
    let fixedHeightFixButtonContainerViewTrailingAnchorConstraint = fixedHeightFixButtonContainerView
      .trailingAnchor
      .constraint(equalTo: headerView.trailingAnchor, constant: -64)
    let fixedHeightFixButtonContainerViewLeadingAnchorConstraint = fixedHeightFixButtonContainerView
      .leadingAnchor
      .constraint(equalTo: spacerView.trailingAnchor)
    let fixedHeightFixButtonContainerViewTopAnchorConstraint = fixedHeightFixButtonContainerView
      .topAnchor
      .constraint(equalTo: headerView.topAnchor)
    let fixedHeightFixButtonContainerViewCenterYAnchorConstraint = fixedHeightFixButtonContainerView
      .centerYAnchor
      .constraint(equalTo: headerView.centerYAnchor)
    let fixedHeightFixButtonContainerViewBottomAnchorConstraint = fixedHeightFixButtonContainerView
      .bottomAnchor
      .constraint(equalTo: headerView.bottomAnchor)
    let spacerViewHeightAnchorConstraint = spacerView.heightAnchor.constraint(equalToConstant: 0)
    let addColorButtonViewWidthAnchorParentConstraint = addColorButtonView
      .widthAnchor
      .constraint(lessThanOrEqualTo: fixedHeightFixButtonContainerView.widthAnchor)
    let addColorButtonViewTopAnchorConstraint = addColorButtonView
      .topAnchor
      .constraint(equalTo: fixedHeightFixButtonContainerView.topAnchor)
    let addColorButtonViewBottomAnchorConstraint = addColorButtonView
      .bottomAnchor
      .constraint(equalTo: fixedHeightFixButtonContainerView.bottomAnchor)
    let addColorButtonViewLeadingAnchorConstraint = addColorButtonView
      .leadingAnchor
      .constraint(equalTo: fixedHeightFixButtonContainerView.leadingAnchor)
    let addColorButtonViewTrailingAnchorConstraint = addColorButtonView
      .trailingAnchor
      .constraint(equalTo: fixedHeightFixButtonContainerView.trailingAnchor)

    addColorButtonViewWidthAnchorParentConstraint.priority = NSLayoutConstraint.Priority.defaultLow

    NSLayoutConstraint.activate([
      innerViewTopAnchorConstraint,
      innerViewBottomAnchorConstraint,
      innerViewLeadingAnchorConstraint,
      innerViewCenterXAnchorConstraint,
      innerViewTrailingAnchorConstraint,
      headerViewTopAnchorConstraint,
      headerViewLeadingAnchorConstraint,
      headerViewTrailingAnchorConstraint,
      colorPreviewCollectionViewBottomAnchorConstraint,
      colorPreviewCollectionViewTopAnchorConstraint,
      colorPreviewCollectionViewLeadingAnchorConstraint,
      colorPreviewCollectionViewTrailingAnchorConstraint,
      headerViewHeightAnchorConstraint,
      titleViewLeadingAnchorConstraint,
      titleViewTopAnchorConstraint,
      titleViewCenterYAnchorConstraint,
      titleViewBottomAnchorConstraint,
      spacerViewLeadingAnchorConstraint,
      spacerViewCenterYAnchorConstraint,
      fixedHeightFixButtonContainerViewTrailingAnchorConstraint,
      fixedHeightFixButtonContainerViewLeadingAnchorConstraint,
      fixedHeightFixButtonContainerViewTopAnchorConstraint,
      fixedHeightFixButtonContainerViewCenterYAnchorConstraint,
      fixedHeightFixButtonContainerViewBottomAnchorConstraint,
      spacerViewHeightAnchorConstraint,
      addColorButtonViewWidthAnchorParentConstraint,
      addColorButtonViewTopAnchorConstraint,
      addColorButtonViewBottomAnchorConstraint,
      addColorButtonViewLeadingAnchorConstraint,
      addColorButtonViewTrailingAnchorConstraint
    ])
  }

  private func update() {
    colorPreviewCollectionView.onSelectColor = handleOnSelectColor
    colorPreviewCollectionView.onDeleteColor = handleOnDeleteColor
    colorPreviewCollectionView.colors = colors
    addColorButtonView.onClick = handleOnClickAddColor
    colorPreviewCollectionView.onMoveColor = handleOnMoveColor
  }

  private func handleOnSelectColor(_ arg0: CSColor?) {
    onSelectColor?(arg0)
  }

  private func handleOnDeleteColor(_ arg0: CSColor?) {
    onDeleteColor?(arg0)
  }

  private func handleOnClickAddColor() {
    onClickAddColor?()
  }

  private func handleOnMoveColor(_ arg0: Int, _ arg1: Int) {
    onMoveColor?(arg0, arg1)
  }
}

// MARK: - Parameters

extension ColorBrowser {
  public struct Parameters: Equatable {
    public var colors: ColorList
    public var onSelectColor: ColorHandler
    public var onDeleteColor: ColorHandler
    public var onClickAddColor: (() -> Void)?
    public var onMoveColor: ItemMoveHandler

    public init(
      colors: ColorList,
      onSelectColor: ColorHandler = nil,
      onDeleteColor: ColorHandler = nil,
      onClickAddColor: (() -> Void)? = nil,
      onMoveColor: ItemMoveHandler = nil)
    {
      self.colors = colors
      self.onSelectColor = onSelectColor
      self.onDeleteColor = onDeleteColor
      self.onClickAddColor = onClickAddColor
      self.onMoveColor = onMoveColor
    }

    public init() {
      self.init(colors: [])
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.colors == rhs.colors
    }
  }
}

// MARK: - Model

extension ColorBrowser {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "ColorBrowser"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(
      colors: ColorList,
      onSelectColor: ColorHandler = nil,
      onDeleteColor: ColorHandler = nil,
      onClickAddColor: (() -> Void)? = nil,
      onMoveColor: ItemMoveHandler = nil)
    {
      self
        .init(
          Parameters(
            colors: colors,
            onSelectColor: onSelectColor,
            onDeleteColor: onDeleteColor,
            onClickAddColor: onClickAddColor,
            onMoveColor: onMoveColor))
    }

    public init() {
      self.init(colors: [])
    }
  }
}
