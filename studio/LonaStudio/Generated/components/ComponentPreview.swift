import AppKit
import Foundation

// MARK: - ComponentPreview

public class ComponentPreview: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(componentName: String) {
    self.init(Parameters(componentName: componentName))
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

  public var componentName: String {
    get { return parameters.componentName }
    set {
      if parameters.componentName != newValue {
        parameters.componentName = newValue
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
}

// MARK: - Parameters

extension ComponentPreview {
  public struct Parameters: Equatable {
    public var componentName: String

    public init(componentName: String) {
      self.componentName = componentName
    }

    public init() {
      self.init(componentName: "")
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.componentName == rhs.componentName
    }
  }
}

// MARK: - Model

extension ComponentPreview {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "ComponentPreview"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(componentName: String) {
      self.init(Parameters(componentName: componentName))
    }

    public init() {
      self.init(componentName: "")
    }
  }
}
