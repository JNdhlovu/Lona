import AppKit
import Foundation

// MARK: - AddColorSheet

public class AddColorSheet: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(
    nameText: String,
    idText: String,
    valueText: String,
    descriptionText: String,
    colorValue: ColorPickerColor)
  {
    self
      .init(
        Parameters(
          nameText: nameText,
          idText: idText,
          valueText: valueText,
          descriptionText: descriptionText,
          colorValue: colorValue))
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

  public var nameText: String {
    get { return parameters.nameText }
    set {
      if parameters.nameText != newValue {
        parameters.nameText = newValue
      }
    }
  }

  public var idText: String {
    get { return parameters.idText }
    set {
      if parameters.idText != newValue {
        parameters.idText = newValue
      }
    }
  }

  public var valueText: String {
    get { return parameters.valueText }
    set {
      if parameters.valueText != newValue {
        parameters.valueText = newValue
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

  public var colorValue: ColorPickerColor {
    get { return parameters.colorValue }
    set {
      if parameters.colorValue != newValue {
        parameters.colorValue = newValue
      }
    }
  }

  public var onChangeNameText: StringHandler {
    get { return parameters.onChangeNameText }
    set { parameters.onChangeNameText = newValue }
  }

  public var onChangeIdText: StringHandler {
    get { return parameters.onChangeIdText }
    set { parameters.onChangeIdText = newValue }
  }

  public var onChangeValueText: StringHandler {
    get { return parameters.onChangeValueText }
    set { parameters.onChangeValueText = newValue }
  }

  public var onChangeDescriptionText: StringHandler {
    get { return parameters.onChangeDescriptionText }
    set { parameters.onChangeDescriptionText = newValue }
  }

  public var onChangeColorValue: ColorPickerHandler {
    get { return parameters.onChangeColorValue }
    set { parameters.onChangeColorValue = newValue }
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
  private var colorInspectorView = ColorInspector()
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
    addSubview(colorInspectorView)
    addSubview(footerView)
    footerView.addSubview(cancelButtonView)
    footerView.addSubview(footerSpacerView)
    footerView.addSubview(doneButtonView)

    titleView.attributedStringValue = titleViewTextStyle.apply(to: "New Color")
    titleViewTextStyle = TextStyles.large
    titleView.attributedStringValue = titleViewTextStyle.apply(to: titleView.attributedStringValue)
    cancelButtonView.titleText = "Cancel"
    footerSpacerView.fillColor = #colorLiteral(red: 0.847058823529, green: 0.847058823529, blue: 0.847058823529, alpha: 1)
    doneButtonView.titleText = "Add Color"
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    titleView.translatesAutoresizingMaskIntoConstraints = false
    colorInspectorView.translatesAutoresizingMaskIntoConstraints = false
    footerView.translatesAutoresizingMaskIntoConstraints = false
    cancelButtonView.translatesAutoresizingMaskIntoConstraints = false
    footerSpacerView.translatesAutoresizingMaskIntoConstraints = false
    doneButtonView.translatesAutoresizingMaskIntoConstraints = false

    let widthAnchorConstraint = widthAnchor.constraint(equalToConstant: 480)
    let titleViewTopAnchorConstraint = titleView.topAnchor.constraint(equalTo: topAnchor, constant: 20)
    let titleViewLeadingAnchorConstraint = titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
    let titleViewTrailingAnchorConstraint = titleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
    let colorInspectorViewTopAnchorConstraint = colorInspectorView.topAnchor.constraint(equalTo: titleView.bottomAnchor)
    let colorInspectorViewLeadingAnchorConstraint = colorInspectorView
      .leadingAnchor
      .constraint(equalTo: leadingAnchor, constant: 20)
    let colorInspectorViewTrailingAnchorConstraint = colorInspectorView
      .trailingAnchor
      .constraint(equalTo: trailingAnchor, constant: -20)
    let footerViewBottomAnchorConstraint = footerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
    let footerViewTopAnchorConstraint = footerView
      .topAnchor
      .constraint(equalTo: colorInspectorView.bottomAnchor, constant: 40)
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
      colorInspectorViewTopAnchorConstraint,
      colorInspectorViewLeadingAnchorConstraint,
      colorInspectorViewTrailingAnchorConstraint,
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
    colorInspectorView.idText = idText
    colorInspectorView.nameText = nameText
    colorInspectorView.valueText = valueText
    colorInspectorView.descriptionText = descriptionText
    colorInspectorView.colorValue = colorValue
    colorInspectorView.onChangeIdText = handleOnChangeIdText
    colorInspectorView.onChangeNameText = handleOnChangeNameText
    colorInspectorView.onChangeValueText = handleOnChangeValueText
    colorInspectorView.onChangeDescriptionText = handleOnChangeDescriptionText
    colorInspectorView.onChangeColorValue = handleOnChangeColorValue
  }

  private func handleOnSubmit() {
    onSubmit?()
  }

  private func handleOnCancel() {
    onCancel?()
  }

  private func handleOnChangeNameText(_ arg0: String) {
    onChangeNameText?(arg0)
  }

  private func handleOnChangeIdText(_ arg0: String) {
    onChangeIdText?(arg0)
  }

  private func handleOnChangeValueText(_ arg0: String) {
    onChangeValueText?(arg0)
  }

  private func handleOnChangeDescriptionText(_ arg0: String) {
    onChangeDescriptionText?(arg0)
  }

  private func handleOnChangeColorValue(_ arg0: SwiftColor) {
    onChangeColorValue?(arg0)
  }
}

// MARK: - Parameters

extension AddColorSheet {
  public struct Parameters: Equatable {
    public var nameText: String
    public var idText: String
    public var valueText: String
    public var descriptionText: String
    public var colorValue: ColorPickerColor
    public var onSubmit: (() -> Void)?
    public var onCancel: (() -> Void)?
    public var onChangeNameText: StringHandler
    public var onChangeIdText: StringHandler
    public var onChangeValueText: StringHandler
    public var onChangeDescriptionText: StringHandler
    public var onChangeColorValue: ColorPickerHandler

    public init(
      nameText: String,
      idText: String,
      valueText: String,
      descriptionText: String,
      colorValue: ColorPickerColor,
      onSubmit: (() -> Void)? = nil,
      onCancel: (() -> Void)? = nil,
      onChangeNameText: StringHandler = nil,
      onChangeIdText: StringHandler = nil,
      onChangeValueText: StringHandler = nil,
      onChangeDescriptionText: StringHandler = nil,
      onChangeColorValue: ColorPickerHandler = nil)
    {
      self.nameText = nameText
      self.idText = idText
      self.valueText = valueText
      self.descriptionText = descriptionText
      self.colorValue = colorValue
      self.onSubmit = onSubmit
      self.onCancel = onCancel
      self.onChangeNameText = onChangeNameText
      self.onChangeIdText = onChangeIdText
      self.onChangeValueText = onChangeValueText
      self.onChangeDescriptionText = onChangeDescriptionText
      self.onChangeColorValue = onChangeColorValue
    }

    public init() {
      self.init(nameText: "", idText: "", valueText: "", descriptionText: "", colorValue: nil)
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.nameText == rhs.nameText &&
        lhs.idText == rhs.idText &&
          lhs.valueText == rhs.valueText &&
            lhs.descriptionText == rhs.descriptionText && lhs.colorValue == rhs.colorValue
    }
  }
}

// MARK: - Model

extension AddColorSheet {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "AddColorSheet"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(
      nameText: String,
      idText: String,
      valueText: String,
      descriptionText: String,
      colorValue: ColorPickerColor,
      onSubmit: (() -> Void)? = nil,
      onCancel: (() -> Void)? = nil,
      onChangeNameText: StringHandler = nil,
      onChangeIdText: StringHandler = nil,
      onChangeValueText: StringHandler = nil,
      onChangeDescriptionText: StringHandler = nil,
      onChangeColorValue: ColorPickerHandler = nil)
    {
      self
        .init(
          Parameters(
            nameText: nameText,
            idText: idText,
            valueText: valueText,
            descriptionText: descriptionText,
            colorValue: colorValue,
            onSubmit: onSubmit,
            onCancel: onCancel,
            onChangeNameText: onChangeNameText,
            onChangeIdText: onChangeIdText,
            onChangeValueText: onChangeValueText,
            onChangeDescriptionText: onChangeDescriptionText,
            onChangeColorValue: onChangeColorValue))
    }

    public init() {
      self.init(nameText: "", idText: "", valueText: "", descriptionText: "", colorValue: nil)
    }
  }
}
