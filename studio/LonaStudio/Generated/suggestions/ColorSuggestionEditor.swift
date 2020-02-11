import AppKit
import Foundation

// MARK: - ColorSuggestionEditor

public class ColorSuggestionEditor: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(colorValue: ColorPickerColor) {
    self.init(Parameters(colorValue: colorValue))
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

  public var colorValue: ColorPickerColor {
    get { return parameters.colorValue }
    set {
      if parameters.colorValue != newValue {
        parameters.colorValue = newValue
      }
    }
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

  private var pickerContainerView = NSBox()
  private var colorPickerView = CoreColorPicker()
  private var footerView = NSBox()
  private var spacerView = NSBox()
  private var submitButtonView = Button()

  private func setUpViews() {
    boxType = .custom
    borderType = .noBorder
    contentViewMargins = .zero
    pickerContainerView.boxType = .custom
    pickerContainerView.borderType = .noBorder
    pickerContainerView.contentViewMargins = .zero
    footerView.boxType = .custom
    footerView.borderType = .noBorder
    footerView.contentViewMargins = .zero
    spacerView.boxType = .custom
    spacerView.borderType = .noBorder
    spacerView.contentViewMargins = .zero

    addSubview(pickerContainerView)
    addSubview(footerView)
    pickerContainerView.addSubview(colorPickerView)
    footerView.addSubview(spacerView)
    footerView.addSubview(submitButtonView)

    submitButtonView.titleText = "OK"
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    pickerContainerView.translatesAutoresizingMaskIntoConstraints = false
    footerView.translatesAutoresizingMaskIntoConstraints = false
    colorPickerView.translatesAutoresizingMaskIntoConstraints = false
    spacerView.translatesAutoresizingMaskIntoConstraints = false
    submitButtonView.translatesAutoresizingMaskIntoConstraints = false

    let pickerContainerViewTopAnchorConstraint = pickerContainerView.topAnchor.constraint(equalTo: topAnchor)
    let pickerContainerViewLeadingAnchorConstraint = pickerContainerView
      .leadingAnchor
      .constraint(equalTo: leadingAnchor)
    let pickerContainerViewTrailingAnchorConstraint = pickerContainerView
      .trailingAnchor
      .constraint(equalTo: trailingAnchor)
    let footerViewBottomAnchorConstraint = footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
    let footerViewTopAnchorConstraint = footerView.topAnchor.constraint(equalTo: pickerContainerView.bottomAnchor)
    let footerViewLeadingAnchorConstraint = footerView.leadingAnchor.constraint(equalTo: leadingAnchor)
    let footerViewTrailingAnchorConstraint = footerView.trailingAnchor.constraint(equalTo: trailingAnchor)
    let colorPickerViewTopAnchorConstraint = colorPickerView
      .topAnchor
      .constraint(equalTo: pickerContainerView.topAnchor, constant: 12)
    let colorPickerViewLeadingAnchorConstraint = colorPickerView
      .leadingAnchor
      .constraint(equalTo: pickerContainerView.leadingAnchor, constant: 12)
    let colorPickerViewTrailingAnchorConstraint = colorPickerView
      .trailingAnchor
      .constraint(equalTo: pickerContainerView.trailingAnchor, constant: -12)
    let spacerViewHeightAnchorParentConstraint = spacerView
      .heightAnchor
      .constraint(lessThanOrEqualTo: footerView.heightAnchor, constant: -12)
    let submitButtonViewHeightAnchorParentConstraint = submitButtonView
      .heightAnchor
      .constraint(lessThanOrEqualTo: footerView.heightAnchor, constant: -12)
    let spacerViewLeadingAnchorConstraint = spacerView
      .leadingAnchor
      .constraint(equalTo: footerView.leadingAnchor, constant: 12)
    let spacerViewTopAnchorConstraint = spacerView.topAnchor.constraint(equalTo: footerView.topAnchor)
    let spacerViewCenterYAnchorConstraint = spacerView.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
    let spacerViewBottomAnchorConstraint = spacerView
      .bottomAnchor
      .constraint(equalTo: footerView.bottomAnchor, constant: -12)
    let submitButtonViewTrailingAnchorConstraint = submitButtonView
      .trailingAnchor
      .constraint(equalTo: footerView.trailingAnchor, constant: -12)
    let submitButtonViewLeadingAnchorConstraint = submitButtonView
      .leadingAnchor
      .constraint(equalTo: spacerView.trailingAnchor)
    let submitButtonViewTopAnchorConstraint = submitButtonView.topAnchor.constraint(equalTo: footerView.topAnchor)
    let submitButtonViewCenterYAnchorConstraint = submitButtonView
      .centerYAnchor
      .constraint(equalTo: footerView.centerYAnchor)
    let submitButtonViewBottomAnchorConstraint = submitButtonView
      .bottomAnchor
      .constraint(equalTo: footerView.bottomAnchor, constant: -12)
    let colorPickerViewHeightAnchorConstraint = colorPickerView.heightAnchor.constraint(equalToConstant: 240)

    spacerViewHeightAnchorParentConstraint.priority = NSLayoutConstraint.Priority.defaultLow
    submitButtonViewHeightAnchorParentConstraint.priority = NSLayoutConstraint.Priority.defaultLow

    NSLayoutConstraint.activate([
      pickerContainerViewTopAnchorConstraint,
      pickerContainerViewLeadingAnchorConstraint,
      pickerContainerViewTrailingAnchorConstraint,
      footerViewBottomAnchorConstraint,
      footerViewTopAnchorConstraint,
      footerViewLeadingAnchorConstraint,
      footerViewTrailingAnchorConstraint,
      colorPickerViewTopAnchorConstraint,
      colorPickerViewLeadingAnchorConstraint,
      colorPickerViewTrailingAnchorConstraint,
      spacerViewHeightAnchorParentConstraint,
      submitButtonViewHeightAnchorParentConstraint,
      spacerViewLeadingAnchorConstraint,
      spacerViewTopAnchorConstraint,
      spacerViewCenterYAnchorConstraint,
      spacerViewBottomAnchorConstraint,
      submitButtonViewTrailingAnchorConstraint,
      submitButtonViewLeadingAnchorConstraint,
      submitButtonViewTopAnchorConstraint,
      submitButtonViewCenterYAnchorConstraint,
      submitButtonViewBottomAnchorConstraint,
      colorPickerViewHeightAnchorConstraint
    ])
  }

  private func update() {
    colorPickerView.colorValue = colorValue
    colorPickerView.onChangeColorValue = handleOnChangeColorValue
    submitButtonView.onClick = handleOnSubmit
  }

  private func handleOnSubmit() {
    onSubmit?()
  }

  private func handleOnChangeColorValue(_ arg0: SwiftColor) {
    onChangeColorValue?(arg0)
  }
}

// MARK: - Parameters

extension ColorSuggestionEditor {
  public struct Parameters: Equatable {
    public var colorValue: ColorPickerColor
    public var onSubmit: (() -> Void)?
    public var onChangeColorValue: ColorPickerHandler

    public init(
      colorValue: ColorPickerColor,
      onSubmit: (() -> Void)? = nil,
      onChangeColorValue: ColorPickerHandler = nil)
    {
      self.colorValue = colorValue
      self.onSubmit = onSubmit
      self.onChangeColorValue = onChangeColorValue
    }

    public init() {
      self.init(colorValue: nil)
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.colorValue == rhs.colorValue
    }
  }
}

// MARK: - Model

extension ColorSuggestionEditor {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "ColorSuggestionEditor"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(
      colorValue: ColorPickerColor,
      onSubmit: (() -> Void)? = nil,
      onChangeColorValue: ColorPickerHandler = nil)
    {
      self.init(Parameters(colorValue: colorValue, onSubmit: onSubmit, onChangeColorValue: onChangeColorValue))
    }

    public init() {
      self.init(colorValue: nil)
    }
  }
}
