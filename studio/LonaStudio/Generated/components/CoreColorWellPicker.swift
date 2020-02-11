import AppKit
import Foundation

// MARK: - CoreColorWellPicker

public class CoreColorWellPicker: NSBox {

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

  private var colorWellPickerView = ColorWellPicker()

  private func setUpViews() {
    boxType = .custom
    borderType = .noBorder
    contentViewMargins = .zero

    addSubview(colorWellPickerView)
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    colorWellPickerView.translatesAutoresizingMaskIntoConstraints = false

    let heightAnchorConstraint = heightAnchor.constraint(equalToConstant: 22)
    let widthAnchorConstraint = widthAnchor.constraint(equalToConstant: 34)
    let colorWellPickerViewTopAnchorConstraint = colorWellPickerView.topAnchor.constraint(equalTo: topAnchor)
    let colorWellPickerViewBottomAnchorConstraint = colorWellPickerView.bottomAnchor.constraint(equalTo: bottomAnchor)
    let colorWellPickerViewLeadingAnchorConstraint = colorWellPickerView
      .leadingAnchor
      .constraint(equalTo: leadingAnchor)
    let colorWellPickerViewTrailingAnchorConstraint = colorWellPickerView
      .trailingAnchor
      .constraint(equalTo: trailingAnchor)

    NSLayoutConstraint.activate([
      heightAnchorConstraint,
      widthAnchorConstraint,
      colorWellPickerViewTopAnchorConstraint,
      colorWellPickerViewBottomAnchorConstraint,
      colorWellPickerViewLeadingAnchorConstraint,
      colorWellPickerViewTrailingAnchorConstraint
    ])
  }

  private func update() {
    colorWellPickerView.colorValue = colorValue
    colorWellPickerView.onChangeColorValue = handleOnChangeColorValue
  }

  private func handleOnChangeColorValue(_ arg0: SwiftColor) {
    onChangeColorValue?(arg0)
  }
}

// MARK: - Parameters

extension CoreColorWellPicker {
  public struct Parameters: Equatable {
    public var colorValue: ColorPickerColor
    public var onChangeColorValue: ColorPickerHandler

    public init(colorValue: ColorPickerColor, onChangeColorValue: ColorPickerHandler = nil) {
      self.colorValue = colorValue
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

extension CoreColorWellPicker {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "CoreColorWellPicker"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(colorValue: ColorPickerColor, onChangeColorValue: ColorPickerHandler = nil) {
      self.init(Parameters(colorValue: colorValue, onChangeColorValue: onChangeColorValue))
    }

    public init() {
      self.init(colorValue: nil)
    }
  }
}
