import AppKit
import Foundation

// MARK: - ShadowPicker

public class ShadowPicker: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(optionalShadowValue: ShadowPickerShadow) {
    self.init(Parameters(optionalShadowValue: optionalShadowValue))
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

  public var optionalShadowValue: ShadowPickerShadow {
    get { return parameters.optionalShadowValue }
    set {
      if parameters.optionalShadowValue != newValue {
        parameters.optionalShadowValue = newValue
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

  private func setUpViews() {
    boxType = .custom
    borderType = .noBorder
    contentViewMargins = .zero

    fillColor = Colors.red50
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
  }

  private func update() {}

  private func handleOnChangeShadowValue(_ arg0: PickerShadow) {
    onChangeShadowValue?(arg0)
  }
}

// MARK: - Parameters

extension ShadowPicker {
  public struct Parameters: Equatable {
    public var optionalShadowValue: ShadowPickerShadow
    public var onChangeShadowValue: ShadowPickerHandler

    public init(optionalShadowValue: ShadowPickerShadow, onChangeShadowValue: ShadowPickerHandler = nil) {
      self.optionalShadowValue = optionalShadowValue
      self.onChangeShadowValue = onChangeShadowValue
    }

    public init() {
      self.init(optionalShadowValue: nil)
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.optionalShadowValue == rhs.optionalShadowValue
    }
  }
}

// MARK: - Model

extension ShadowPicker {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "ShadowPicker"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(optionalShadowValue: ShadowPickerShadow, onChangeShadowValue: ShadowPickerHandler = nil) {
      self.init(Parameters(optionalShadowValue: optionalShadowValue, onChangeShadowValue: onChangeShadowValue))
    }

    public init() {
      self.init(optionalShadowValue: nil)
    }
  }
}
