import AppKit
import Foundation

// MARK: - ComponentPreviewCard

public class ComponentPreviewCard: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(componentName: String, selected: Bool) {
    self.init(Parameters(componentName: componentName, selected: selected))
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

  public var selected: Bool {
    get { return parameters.selected }
    set {
      if parameters.selected != newValue {
        parameters.selected = newValue
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

  private var previewView = NSBox()
  private var componentPreviewView = ComponentPreview()
  private var detailsView = NSBox()
  private var componentNameView = LNATextField(labelWithString: "")

  private var componentNameViewTextStyle = TextStyles.regular

  private func setUpViews() {
    boxType = .custom
    borderType = .lineBorder
    contentViewMargins = .zero
    previewView.boxType = .custom
    previewView.borderType = .noBorder
    previewView.contentViewMargins = .zero
    detailsView.boxType = .custom
    detailsView.borderType = .noBorder
    detailsView.contentViewMargins = .zero
    componentNameView.lineBreakMode = .byWordWrapping

    addSubview(previewView)
    addSubview(detailsView)
    previewView.addSubview(componentPreviewView)
    detailsView.addSubview(componentNameView)

    cornerRadius = 4
    borderWidth = 1
    previewView.fillColor = Colors.dividerSubtle
    previewView.cornerRadius = 3
    componentNameViewTextStyle = TextStyles.regular
    componentNameView.attributedStringValue =
      componentNameViewTextStyle.apply(to: componentNameView.attributedStringValue)
    componentNameView.maximumNumberOfLines = 2
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    previewView.translatesAutoresizingMaskIntoConstraints = false
    detailsView.translatesAutoresizingMaskIntoConstraints = false
    componentPreviewView.translatesAutoresizingMaskIntoConstraints = false
    componentNameView.translatesAutoresizingMaskIntoConstraints = false

    let previewViewTopAnchorConstraint = previewView.topAnchor.constraint(equalTo: topAnchor, constant: 5)
    let previewViewLeadingAnchorConstraint = previewView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5)
    let previewViewTrailingAnchorConstraint = previewView
      .trailingAnchor
      .constraint(equalTo: trailingAnchor, constant: -5)
    let detailsViewBottomAnchorConstraint = detailsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
    let detailsViewTopAnchorConstraint = detailsView
      .topAnchor
      .constraint(equalTo: previewView.bottomAnchor, constant: 5)
    let detailsViewLeadingAnchorConstraint = detailsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5)
    let detailsViewTrailingAnchorConstraint = detailsView
      .trailingAnchor
      .constraint(equalTo: trailingAnchor, constant: -5)
    let componentPreviewViewTopAnchorConstraint = componentPreviewView
      .topAnchor
      .constraint(equalTo: previewView.topAnchor)
    let componentPreviewViewBottomAnchorConstraint = componentPreviewView
      .bottomAnchor
      .constraint(equalTo: previewView.bottomAnchor)
    let componentPreviewViewLeadingAnchorConstraint = componentPreviewView
      .leadingAnchor
      .constraint(equalTo: previewView.leadingAnchor)
    let componentPreviewViewTrailingAnchorConstraint = componentPreviewView
      .trailingAnchor
      .constraint(equalTo: previewView.trailingAnchor)
    let componentNameViewTopAnchorConstraint = componentNameView.topAnchor.constraint(equalTo: detailsView.topAnchor)
    let componentNameViewBottomAnchorConstraint = componentNameView
      .bottomAnchor
      .constraint(equalTo: detailsView.bottomAnchor)
    let componentNameViewLeadingAnchorConstraint = componentNameView
      .leadingAnchor
      .constraint(equalTo: detailsView.leadingAnchor)
    let componentNameViewTrailingAnchorConstraint = componentNameView
      .trailingAnchor
      .constraint(equalTo: detailsView.trailingAnchor)

    NSLayoutConstraint.activate([
      previewViewTopAnchorConstraint,
      previewViewLeadingAnchorConstraint,
      previewViewTrailingAnchorConstraint,
      detailsViewBottomAnchorConstraint,
      detailsViewTopAnchorConstraint,
      detailsViewLeadingAnchorConstraint,
      detailsViewTrailingAnchorConstraint,
      componentPreviewViewTopAnchorConstraint,
      componentPreviewViewBottomAnchorConstraint,
      componentPreviewViewLeadingAnchorConstraint,
      componentPreviewViewTrailingAnchorConstraint,
      componentNameViewTopAnchorConstraint,
      componentNameViewBottomAnchorConstraint,
      componentNameViewLeadingAnchorConstraint,
      componentNameViewTrailingAnchorConstraint
    ])
  }

  private func update() {
    borderColor = Colors.transparent
    componentNameView.attributedStringValue = componentNameViewTextStyle.apply(to: componentName)
    componentPreviewView.componentName = componentName
    if selected {
      borderColor = Colors.lightblue600
    }
  }
}

// MARK: - Parameters

extension ComponentPreviewCard {
  public struct Parameters: Equatable {
    public var componentName: String
    public var selected: Bool

    public init(componentName: String, selected: Bool) {
      self.componentName = componentName
      self.selected = selected
    }

    public init() {
      self.init(componentName: "", selected: false)
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.componentName == rhs.componentName && lhs.selected == rhs.selected
    }
  }
}

// MARK: - Model

extension ComponentPreviewCard {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "ComponentPreviewCard"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(componentName: String, selected: Bool) {
      self.init(Parameters(componentName: componentName, selected: selected))
    }

    public init() {
      self.init(componentName: "", selected: false)
    }
  }
}
