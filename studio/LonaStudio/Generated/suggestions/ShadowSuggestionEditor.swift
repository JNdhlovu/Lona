import AppKit
import Foundation

// MARK: - ShadowSuggestionEditor

public class ShadowSuggestionEditor: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(shadowValue: ShadowPickerShadow) {
    self.init(Parameters(shadowValue: shadowValue))
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

  public var shadowValue: ShadowPickerShadow {
    get { return parameters.shadowValue }
    set {
      if parameters.shadowValue != newValue {
        parameters.shadowValue = newValue
      }
    }
  }

  public var onChangeShadowValue: ShadowPickerHandler {
    get { return parameters.onChangeShadowValue }
    set { parameters.onChangeShadowValue = newValue }
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
  private var shadowPickerView = ShadowPicker()
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
    pickerContainerView.addSubview(shadowPickerView)
    footerView.addSubview(spacerView)
    footerView.addSubview(submitButtonView)

    submitButtonView.titleText = "OK"
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    pickerContainerView.translatesAutoresizingMaskIntoConstraints = false
    footerView.translatesAutoresizingMaskIntoConstraints = false
    shadowPickerView.translatesAutoresizingMaskIntoConstraints = false
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
    let shadowPickerViewTopAnchorConstraint = shadowPickerView
      .topAnchor
      .constraint(equalTo: pickerContainerView.topAnchor, constant: 12)
    let shadowPickerViewBottomAnchorConstraint = shadowPickerView
      .bottomAnchor
      .constraint(equalTo: pickerContainerView.bottomAnchor, constant: -12)
    let shadowPickerViewLeadingAnchorConstraint = shadowPickerView
      .leadingAnchor
      .constraint(equalTo: pickerContainerView.leadingAnchor, constant: 12)
    let shadowPickerViewTrailingAnchorConstraint = shadowPickerView
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
      shadowPickerViewTopAnchorConstraint,
      shadowPickerViewBottomAnchorConstraint,
      shadowPickerViewLeadingAnchorConstraint,
      shadowPickerViewTrailingAnchorConstraint,
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
      submitButtonViewBottomAnchorConstraint
    ])
  }

  private func update() {
    shadowPickerView.optionalShadowValue = shadowValue
    shadowPickerView.onChangeShadowValue = handleOnChangeShadowValue
    submitButtonView.onClick = handleOnSubmit
  }

  private func handleOnSubmit() {
    onSubmit?()
  }

  private func handleOnChangeShadowValue(_ arg0: PickerShadow) {
    onChangeShadowValue?(arg0)
  }
}

// MARK: - Parameters

extension ShadowSuggestionEditor {
  public struct Parameters: Equatable {
    public var shadowValue: ShadowPickerShadow
    public var onSubmit: (() -> Void)?
    public var onChangeShadowValue: ShadowPickerHandler

    public init(
      shadowValue: ShadowPickerShadow,
      onSubmit: (() -> Void)? = nil,
      onChangeShadowValue: ShadowPickerHandler = nil)
    {
      self.shadowValue = shadowValue
      self.onSubmit = onSubmit
      self.onChangeShadowValue = onChangeShadowValue
    }

    public init() {
      self.init(shadowValue: nil)
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.shadowValue == rhs.shadowValue
    }
  }
}

// MARK: - Model

extension ShadowSuggestionEditor {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "ShadowSuggestionEditor"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(
      shadowValue: ShadowPickerShadow,
      onSubmit: (() -> Void)? = nil,
      onChangeShadowValue: ShadowPickerHandler = nil)
    {
      self.init(Parameters(shadowValue: shadowValue, onSubmit: onSubmit, onChangeShadowValue: onChangeShadowValue))
    }

    public init() {
      self.init(shadowValue: nil)
    }
  }
}
