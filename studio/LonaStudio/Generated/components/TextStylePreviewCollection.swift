import AppKit
import Foundation

// MARK: - TextStylePreviewCollection

public class TextStylePreviewCollection: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(textStyles: TextStyleList) {
    self.init(Parameters(textStyles: textStyles))
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

  public var onSelectTextStyle: TextStyleHandler {
    get { return parameters.onSelectTextStyle }
    set { parameters.onSelectTextStyle = newValue }
  }

  public var onChangeTextStyle: TextStyleHandler {
    get { return parameters.onChangeTextStyle }
    set { parameters.onChangeTextStyle = newValue }
  }

  public var onDeleteTextStyle: TextStyleHandler {
    get { return parameters.onDeleteTextStyle }
    set { parameters.onDeleteTextStyle = newValue }
  }

  public var onMoveTextStyle: ItemMoveHandler {
    get { return parameters.onMoveTextStyle }
    set { parameters.onMoveTextStyle = newValue }
  }

  public var textStyles: TextStyleList {
    get { return parameters.textStyles }
    set {
      if parameters.textStyles != newValue {
        parameters.textStyles = newValue
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

  private func setUpViews() {
    boxType = .custom
    borderType = .noBorder
    contentViewMargins = .zero

    fillColor = Colors.pink50
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
  }

  private func update() {}

  private func handleOnSelectTextStyle(_ arg0: CSTextStyle?) {
    onSelectTextStyle?(arg0)
  }

  private func handleOnChangeTextStyle(_ arg0: CSTextStyle?) {
    onChangeTextStyle?(arg0)
  }

  private func handleOnDeleteTextStyle(_ arg0: CSTextStyle?) {
    onDeleteTextStyle?(arg0)
  }

  private func handleOnMoveTextStyle(_ arg0: Int, _ arg1: Int) {
    onMoveTextStyle?(arg0, arg1)
  }
}

// MARK: - Parameters

extension TextStylePreviewCollection {
  public struct Parameters: Equatable {
    public var textStyles: TextStyleList
    public var onSelectTextStyle: TextStyleHandler
    public var onChangeTextStyle: TextStyleHandler
    public var onDeleteTextStyle: TextStyleHandler
    public var onMoveTextStyle: ItemMoveHandler

    public init(
      textStyles: TextStyleList,
      onSelectTextStyle: TextStyleHandler = nil,
      onChangeTextStyle: TextStyleHandler = nil,
      onDeleteTextStyle: TextStyleHandler = nil,
      onMoveTextStyle: ItemMoveHandler = nil)
    {
      self.textStyles = textStyles
      self.onSelectTextStyle = onSelectTextStyle
      self.onChangeTextStyle = onChangeTextStyle
      self.onDeleteTextStyle = onDeleteTextStyle
      self.onMoveTextStyle = onMoveTextStyle
    }

    public init() {
      self.init(textStyles: [])
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.textStyles == rhs.textStyles
    }
  }
}

// MARK: - Model

extension TextStylePreviewCollection {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "TextStylePreviewCollection"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(
      textStyles: TextStyleList,
      onSelectTextStyle: TextStyleHandler = nil,
      onChangeTextStyle: TextStyleHandler = nil,
      onDeleteTextStyle: TextStyleHandler = nil,
      onMoveTextStyle: ItemMoveHandler = nil)
    {
      self
        .init(
          Parameters(
            textStyles: textStyles,
            onSelectTextStyle: onSelectTextStyle,
            onChangeTextStyle: onChangeTextStyle,
            onDeleteTextStyle: onDeleteTextStyle,
            onMoveTextStyle: onMoveTextStyle))
    }

    public init() {
      self.init(textStyles: [])
    }
  }
}
