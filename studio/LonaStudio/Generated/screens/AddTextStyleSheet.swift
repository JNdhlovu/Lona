import AppKit
import Foundation

// MARK: - AddTextStyleSheet

public class AddTextStyleSheet: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(
    idText: String,
    nameText: String,
    fontNameText: String,
    fontFamilyText: String,
    fontWeightText: String,
    fontSizeNumber: CGFloat,
    lineHeightNumber: CGFloat,
    letterSpacingNumber: CGFloat,
    colorValue: String,
    descriptionText: String)
  {
    self
      .init(
        Parameters(
          idText: idText,
          nameText: nameText,
          fontNameText: fontNameText,
          fontFamilyText: fontFamilyText,
          fontWeightText: fontWeightText,
          fontSizeNumber: fontSizeNumber,
          lineHeightNumber: lineHeightNumber,
          letterSpacingNumber: letterSpacingNumber,
          colorValue: colorValue,
          descriptionText: descriptionText))
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

  public var onSubmit: (() -> Void)? {
    get { return parameters.onSubmit }
    set { parameters.onSubmit = newValue }
  }

  public var onCancel: (() -> Void)? {
    get { return parameters.onCancel }
    set { parameters.onCancel = newValue }
  }

  public var idText: String {
    get { return parameters.idText }
    set {
      if parameters.idText != newValue {
        parameters.idText = newValue
      }
    }
  }

  public var nameText: String {
    get { return parameters.nameText }
    set {
      if parameters.nameText != newValue {
        parameters.nameText = newValue
      }
    }
  }

  public var fontNameText: String {
    get { return parameters.fontNameText }
    set {
      if parameters.fontNameText != newValue {
        parameters.fontNameText = newValue
      }
    }
  }

  public var fontFamilyText: String {
    get { return parameters.fontFamilyText }
    set {
      if parameters.fontFamilyText != newValue {
        parameters.fontFamilyText = newValue
      }
    }
  }

  public var fontWeightText: String {
    get { return parameters.fontWeightText }
    set {
      if parameters.fontWeightText != newValue {
        parameters.fontWeightText = newValue
      }
    }
  }

  public var fontSizeNumber: CGFloat {
    get { return parameters.fontSizeNumber }
    set {
      if parameters.fontSizeNumber != newValue {
        parameters.fontSizeNumber = newValue
      }
    }
  }

  public var lineHeightNumber: CGFloat {
    get { return parameters.lineHeightNumber }
    set {
      if parameters.lineHeightNumber != newValue {
        parameters.lineHeightNumber = newValue
      }
    }
  }

  public var letterSpacingNumber: CGFloat {
    get { return parameters.letterSpacingNumber }
    set {
      if parameters.letterSpacingNumber != newValue {
        parameters.letterSpacingNumber = newValue
      }
    }
  }

  public var colorValue: String {
    get { return parameters.colorValue }
    set {
      if parameters.colorValue != newValue {
        parameters.colorValue = newValue
      }
    }
  }

  public var descriptionText: String {
    get { return parameters.descriptionText }
    set {
      if parameters.descriptionText != newValue {
        parameters.descriptionText = newValue
      }
    }
  }

  public var onChangeIdText: StringHandler {
    get { return parameters.onChangeIdText }
    set { parameters.onChangeIdText = newValue }
  }

  public var onChangeNameText: StringHandler {
    get { return parameters.onChangeNameText }
    set { parameters.onChangeNameText = newValue }
  }

  public var onChangeFontNameText: StringHandler {
    get { return parameters.onChangeFontNameText }
    set { parameters.onChangeFontNameText = newValue }
  }

  public var onChangeFontFamilyText: StringHandler {
    get { return parameters.onChangeFontFamilyText }
    set { parameters.onChangeFontFamilyText = newValue }
  }

  public var onChangeFontWeightText: StringHandler {
    get { return parameters.onChangeFontWeightText }
    set { parameters.onChangeFontWeightText = newValue }
  }

  public var onChangeFontSizeNumber: NumberHandler {
    get { return parameters.onChangeFontSizeNumber }
    set { parameters.onChangeFontSizeNumber = newValue }
  }

  public var onChangeLineHeightNumber: NumberHandler {
    get { return parameters.onChangeLineHeightNumber }
    set { parameters.onChangeLineHeightNumber = newValue }
  }

  public var onChangeLetterSpacingNumber: NumberHandler {
    get { return parameters.onChangeLetterSpacingNumber }
    set { parameters.onChangeLetterSpacingNumber = newValue }
  }

  public var onChangeColorValue: StringHandler {
    get { return parameters.onChangeColorValue }
    set { parameters.onChangeColorValue = newValue }
  }

  public var onChangeDescriptionText: StringHandler {
    get { return parameters.onChangeDescriptionText }
    set { parameters.onChangeDescriptionText = newValue }
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
  private var textStyleInspectorView = TextStyleInspector()
  private var footerView = NSBox()
  private var cancelButtonView = Button()
  private var footerSpacerView = NSBox()
  private var doneButtonView = Button()

  private var titleViewTextStyle = TextStyles.large

  private func setUpViews() {
    boxType = .custom
    borderType = .noBorder
    contentViewMargins = .zero
    titleView.lineBreakMode = .byWordWrapping
    footerView.boxType = .custom
    footerView.borderType = .noBorder
    footerView.contentViewMargins = .zero
    footerSpacerView.boxType = .custom
    footerSpacerView.borderType = .noBorder
    footerSpacerView.contentViewMargins = .zero

    addSubview(titleView)
    addSubview(textStyleInspectorView)
    addSubview(footerView)
    footerView.addSubview(cancelButtonView)
    footerView.addSubview(footerSpacerView)
    footerView.addSubview(doneButtonView)

    titleView.attributedStringValue = titleViewTextStyle.apply(to: "New Text Style")
    titleViewTextStyle = TextStyles.large
    titleView.attributedStringValue = titleViewTextStyle.apply(to: titleView.attributedStringValue)
    cancelButtonView.titleText = "Cancel"
    footerSpacerView.fillColor = #colorLiteral(red: 0.847058823529, green: 0.847058823529, blue: 0.847058823529, alpha: 1)
    doneButtonView.titleText = "Add Text Style"
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    titleView.translatesAutoresizingMaskIntoConstraints = false
    textStyleInspectorView.translatesAutoresizingMaskIntoConstraints = false
    footerView.translatesAutoresizingMaskIntoConstraints = false
    cancelButtonView.translatesAutoresizingMaskIntoConstraints = false
    footerSpacerView.translatesAutoresizingMaskIntoConstraints = false
    doneButtonView.translatesAutoresizingMaskIntoConstraints = false

    let widthAnchorConstraint = widthAnchor.constraint(equalToConstant: 480)
    let titleViewTopAnchorConstraint = titleView.topAnchor.constraint(equalTo: topAnchor, constant: 20)
    let titleViewLeadingAnchorConstraint = titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
    let titleViewTrailingAnchorConstraint = titleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
    let textStyleInspectorViewTopAnchorConstraint = textStyleInspectorView
      .topAnchor
      .constraint(equalTo: titleView.bottomAnchor)
    let textStyleInspectorViewLeadingAnchorConstraint = textStyleInspectorView
      .leadingAnchor
      .constraint(equalTo: leadingAnchor, constant: 20)
    let textStyleInspectorViewTrailingAnchorConstraint = textStyleInspectorView
      .trailingAnchor
      .constraint(equalTo: trailingAnchor, constant: -20)
    let footerViewBottomAnchorConstraint = footerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
    let footerViewTopAnchorConstraint = footerView
      .topAnchor
      .constraint(equalTo: textStyleInspectorView.bottomAnchor, constant: 40)
    let footerViewLeadingAnchorConstraint = footerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
    let footerViewTrailingAnchorConstraint = footerView
      .trailingAnchor
      .constraint(equalTo: trailingAnchor, constant: -20)
    let cancelButtonViewHeightAnchorParentConstraint = cancelButtonView
      .heightAnchor
      .constraint(lessThanOrEqualTo: footerView.heightAnchor)
    let footerSpacerViewHeightAnchorParentConstraint = footerSpacerView
      .heightAnchor
      .constraint(lessThanOrEqualTo: footerView.heightAnchor)
    let doneButtonViewHeightAnchorParentConstraint = doneButtonView
      .heightAnchor
      .constraint(lessThanOrEqualTo: footerView.heightAnchor)
    let cancelButtonViewLeadingAnchorConstraint = cancelButtonView
      .leadingAnchor
      .constraint(equalTo: footerView.leadingAnchor)
    let cancelButtonViewTopAnchorConstraint = cancelButtonView.topAnchor.constraint(equalTo: footerView.topAnchor)
    let cancelButtonViewBottomAnchorConstraint = cancelButtonView
      .bottomAnchor
      .constraint(equalTo: footerView.bottomAnchor)
    let footerSpacerViewLeadingAnchorConstraint = footerSpacerView
      .leadingAnchor
      .constraint(equalTo: cancelButtonView.trailingAnchor)
    let footerSpacerViewBottomAnchorConstraint = footerSpacerView
      .bottomAnchor
      .constraint(equalTo: footerView.bottomAnchor)
    let doneButtonViewTrailingAnchorConstraint = doneButtonView
      .trailingAnchor
      .constraint(equalTo: footerView.trailingAnchor)
    let doneButtonViewLeadingAnchorConstraint = doneButtonView
      .leadingAnchor
      .constraint(equalTo: footerSpacerView.trailingAnchor)
    let doneButtonViewTopAnchorConstraint = doneButtonView.topAnchor.constraint(equalTo: footerView.topAnchor)
    let doneButtonViewBottomAnchorConstraint = doneButtonView.bottomAnchor.constraint(equalTo: footerView.bottomAnchor)
    let footerSpacerViewHeightAnchorConstraint = footerSpacerView.heightAnchor.constraint(equalToConstant: 0)

    cancelButtonViewHeightAnchorParentConstraint.priority = NSLayoutConstraint.Priority.defaultLow
    footerSpacerViewHeightAnchorParentConstraint.priority = NSLayoutConstraint.Priority.defaultLow
    doneButtonViewHeightAnchorParentConstraint.priority = NSLayoutConstraint.Priority.defaultLow

    NSLayoutConstraint.activate([
      widthAnchorConstraint,
      titleViewTopAnchorConstraint,
      titleViewLeadingAnchorConstraint,
      titleViewTrailingAnchorConstraint,
      textStyleInspectorViewTopAnchorConstraint,
      textStyleInspectorViewLeadingAnchorConstraint,
      textStyleInspectorViewTrailingAnchorConstraint,
      footerViewBottomAnchorConstraint,
      footerViewTopAnchorConstraint,
      footerViewLeadingAnchorConstraint,
      footerViewTrailingAnchorConstraint,
      cancelButtonViewHeightAnchorParentConstraint,
      footerSpacerViewHeightAnchorParentConstraint,
      doneButtonViewHeightAnchorParentConstraint,
      cancelButtonViewLeadingAnchorConstraint,
      cancelButtonViewTopAnchorConstraint,
      cancelButtonViewBottomAnchorConstraint,
      footerSpacerViewLeadingAnchorConstraint,
      footerSpacerViewBottomAnchorConstraint,
      doneButtonViewTrailingAnchorConstraint,
      doneButtonViewLeadingAnchorConstraint,
      doneButtonViewTopAnchorConstraint,
      doneButtonViewBottomAnchorConstraint,
      footerSpacerViewHeightAnchorConstraint
    ])
  }

  private func update() {
    doneButtonView.onClick = handleOnSubmit
    cancelButtonView.onClick = handleOnCancel
    textStyleInspectorView.idText = idText
    textStyleInspectorView.nameText = nameText
    textStyleInspectorView.fontNameText = fontNameText
    textStyleInspectorView.fontFamilyText = fontFamilyText
    textStyleInspectorView.fontWeightText = fontWeightText
    textStyleInspectorView.fontSizeNumber = fontSizeNumber
    textStyleInspectorView.lineHeightNumber = lineHeightNumber
    textStyleInspectorView.letterSpacingNumber = letterSpacingNumber
    textStyleInspectorView.colorValue = colorValue
    textStyleInspectorView.descriptionText = descriptionText
    textStyleInspectorView.onChangeIdText = handleOnChangeIdText
    textStyleInspectorView.onChangeNameText = handleOnChangeNameText
    textStyleInspectorView.onChangeFontNameText = handleOnChangeFontNameText
    textStyleInspectorView.onChangeFontFamilyText = handleOnChangeFontFamilyText
    textStyleInspectorView.onChangeFontWeightText = handleOnChangeFontWeightText
    textStyleInspectorView.onChangeFontSizeNumber = handleOnChangeFontSizeNumber
    textStyleInspectorView.onChangeLineHeightNumber = handleOnChangeLineHeightNumber
    textStyleInspectorView.onChangeLetterSpacingNumber = handleOnChangeLetterSpacingNumber
    textStyleInspectorView.onChangeColorValue = handleOnChangeColorValue
    textStyleInspectorView.onChangeDescriptionText = handleOnChangeDescriptionText
  }

  private func handleOnSubmit() {
    onSubmit?()
  }

  private func handleOnCancel() {
    onCancel?()
  }

  private func handleOnChangeIdText(_ arg0: String) {
    onChangeIdText?(arg0)
  }

  private func handleOnChangeNameText(_ arg0: String) {
    onChangeNameText?(arg0)
  }

  private func handleOnChangeFontNameText(_ arg0: String) {
    onChangeFontNameText?(arg0)
  }

  private func handleOnChangeFontFamilyText(_ arg0: String) {
    onChangeFontFamilyText?(arg0)
  }

  private func handleOnChangeFontWeightText(_ arg0: String) {
    onChangeFontWeightText?(arg0)
  }

  private func handleOnChangeFontSizeNumber(_ arg0: CGFloat) {
    onChangeFontSizeNumber?(arg0)
  }

  private func handleOnChangeLineHeightNumber(_ arg0: CGFloat) {
    onChangeLineHeightNumber?(arg0)
  }

  private func handleOnChangeLetterSpacingNumber(_ arg0: CGFloat) {
    onChangeLetterSpacingNumber?(arg0)
  }

  private func handleOnChangeColorValue(_ arg0: String) {
    onChangeColorValue?(arg0)
  }

  private func handleOnChangeDescriptionText(_ arg0: String) {
    onChangeDescriptionText?(arg0)
  }
}

// MARK: - Parameters

extension AddTextStyleSheet {
  public struct Parameters: Equatable {
    public var idText: String
    public var nameText: String
    public var fontNameText: String
    public var fontFamilyText: String
    public var fontWeightText: String
    public var fontSizeNumber: CGFloat
    public var lineHeightNumber: CGFloat
    public var letterSpacingNumber: CGFloat
    public var colorValue: String
    public var descriptionText: String
    public var onSubmit: (() -> Void)?
    public var onCancel: (() -> Void)?
    public var onChangeIdText: StringHandler
    public var onChangeNameText: StringHandler
    public var onChangeFontNameText: StringHandler
    public var onChangeFontFamilyText: StringHandler
    public var onChangeFontWeightText: StringHandler
    public var onChangeFontSizeNumber: NumberHandler
    public var onChangeLineHeightNumber: NumberHandler
    public var onChangeLetterSpacingNumber: NumberHandler
    public var onChangeColorValue: StringHandler
    public var onChangeDescriptionText: StringHandler

    public init(
      idText: String,
      nameText: String,
      fontNameText: String,
      fontFamilyText: String,
      fontWeightText: String,
      fontSizeNumber: CGFloat,
      lineHeightNumber: CGFloat,
      letterSpacingNumber: CGFloat,
      colorValue: String,
      descriptionText: String,
      onSubmit: (() -> Void)? = nil,
      onCancel: (() -> Void)? = nil,
      onChangeIdText: StringHandler = nil,
      onChangeNameText: StringHandler = nil,
      onChangeFontNameText: StringHandler = nil,
      onChangeFontFamilyText: StringHandler = nil,
      onChangeFontWeightText: StringHandler = nil,
      onChangeFontSizeNumber: NumberHandler = nil,
      onChangeLineHeightNumber: NumberHandler = nil,
      onChangeLetterSpacingNumber: NumberHandler = nil,
      onChangeColorValue: StringHandler = nil,
      onChangeDescriptionText: StringHandler = nil)
    {
      self.idText = idText
      self.nameText = nameText
      self.fontNameText = fontNameText
      self.fontFamilyText = fontFamilyText
      self.fontWeightText = fontWeightText
      self.fontSizeNumber = fontSizeNumber
      self.lineHeightNumber = lineHeightNumber
      self.letterSpacingNumber = letterSpacingNumber
      self.colorValue = colorValue
      self.descriptionText = descriptionText
      self.onSubmit = onSubmit
      self.onCancel = onCancel
      self.onChangeIdText = onChangeIdText
      self.onChangeNameText = onChangeNameText
      self.onChangeFontNameText = onChangeFontNameText
      self.onChangeFontFamilyText = onChangeFontFamilyText
      self.onChangeFontWeightText = onChangeFontWeightText
      self.onChangeFontSizeNumber = onChangeFontSizeNumber
      self.onChangeLineHeightNumber = onChangeLineHeightNumber
      self.onChangeLetterSpacingNumber = onChangeLetterSpacingNumber
      self.onChangeColorValue = onChangeColorValue
      self.onChangeDescriptionText = onChangeDescriptionText
    }

    public init() {
      self
        .init(
          idText: "",
          nameText: "",
          fontNameText: "",
          fontFamilyText: "",
          fontWeightText: "",
          fontSizeNumber: 0,
          lineHeightNumber: 0,
          letterSpacingNumber: 0,
          colorValue: "",
          descriptionText: "")
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.idText == rhs.idText &&
        lhs.nameText == rhs.nameText &&
          lhs.fontNameText == rhs.fontNameText &&
            lhs.fontFamilyText == rhs.fontFamilyText &&
              lhs.fontWeightText == rhs.fontWeightText &&
                lhs.fontSizeNumber == rhs.fontSizeNumber &&
                  lhs.lineHeightNumber == rhs.lineHeightNumber &&
                    lhs.letterSpacingNumber == rhs.letterSpacingNumber &&
                      lhs.colorValue == rhs.colorValue && lhs.descriptionText == rhs.descriptionText
    }
  }
}

// MARK: - Model

extension AddTextStyleSheet {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "AddTextStyleSheet"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(
      idText: String,
      nameText: String,
      fontNameText: String,
      fontFamilyText: String,
      fontWeightText: String,
      fontSizeNumber: CGFloat,
      lineHeightNumber: CGFloat,
      letterSpacingNumber: CGFloat,
      colorValue: String,
      descriptionText: String,
      onSubmit: (() -> Void)? = nil,
      onCancel: (() -> Void)? = nil,
      onChangeIdText: StringHandler = nil,
      onChangeNameText: StringHandler = nil,
      onChangeFontNameText: StringHandler = nil,
      onChangeFontFamilyText: StringHandler = nil,
      onChangeFontWeightText: StringHandler = nil,
      onChangeFontSizeNumber: NumberHandler = nil,
      onChangeLineHeightNumber: NumberHandler = nil,
      onChangeLetterSpacingNumber: NumberHandler = nil,
      onChangeColorValue: StringHandler = nil,
      onChangeDescriptionText: StringHandler = nil)
    {
      self
        .init(
          Parameters(
            idText: idText,
            nameText: nameText,
            fontNameText: fontNameText,
            fontFamilyText: fontFamilyText,
            fontWeightText: fontWeightText,
            fontSizeNumber: fontSizeNumber,
            lineHeightNumber: lineHeightNumber,
            letterSpacingNumber: letterSpacingNumber,
            colorValue: colorValue,
            descriptionText: descriptionText,
            onSubmit: onSubmit,
            onCancel: onCancel,
            onChangeIdText: onChangeIdText,
            onChangeNameText: onChangeNameText,
            onChangeFontNameText: onChangeFontNameText,
            onChangeFontFamilyText: onChangeFontFamilyText,
            onChangeFontWeightText: onChangeFontWeightText,
            onChangeFontSizeNumber: onChangeFontSizeNumber,
            onChangeLineHeightNumber: onChangeLineHeightNumber,
            onChangeLetterSpacingNumber: onChangeLetterSpacingNumber,
            onChangeColorValue: onChangeColorValue,
            onChangeDescriptionText: onChangeDescriptionText))
    }

    public init() {
      self
        .init(
          idText: "",
          nameText: "",
          fontNameText: "",
          fontFamilyText: "",
          fontWeightText: "",
          fontSizeNumber: 0,
          lineHeightNumber: 0,
          letterSpacingNumber: 0,
          colorValue: "",
          descriptionText: "")
    }
  }
}
