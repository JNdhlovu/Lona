import AppKit
import Foundation

// MARK: - WorkspaceVerticalTabs

public class WorkspaceVerticalTabs: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(selectedValue: String) {
    self.init(Parameters(selectedValue: selectedValue))
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

  public var onClickLayers: (() -> Void)? {
    get { return parameters.onClickLayers }
    set { parameters.onClickLayers = newValue }
  }

  public var onClickDocumentation: (() -> Void)? {
    get { return parameters.onClickDocumentation }
    set { parameters.onClickDocumentation = newValue }
  }

  public var selectedValue: String {
    get { return parameters.selectedValue }
    set {
      if parameters.selectedValue != newValue {
        parameters.selectedValue = newValue
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

  private var innerView = NSBox()
  private var tabIconLayersView = TabIcon()
  private var tabIconDocumentationView = TabIcon()
  private var dividerView = NSBox()

  private func setUpViews() {
    boxType = .custom
    borderType = .noBorder
    contentViewMargins = .zero
    innerView.boxType = .custom
    innerView.borderType = .noBorder
    innerView.contentViewMargins = .zero
    dividerView.boxType = .custom
    dividerView.borderType = .noBorder
    dividerView.contentViewMargins = .zero

    addSubview(innerView)
    addSubview(dividerView)
    innerView.addSubview(tabIconLayersView)
    innerView.addSubview(tabIconDocumentationView)

    tabIconLayersView.icon = #imageLiteral(resourceName: "icon-tab-layers")
    tabIconDocumentationView.icon = #imageLiteral(resourceName: "icon-tab-docs")
    dividerView.fillColor = Colors.grey300
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    innerView.translatesAutoresizingMaskIntoConstraints = false
    dividerView.translatesAutoresizingMaskIntoConstraints = false
    tabIconLayersView.translatesAutoresizingMaskIntoConstraints = false
    tabIconDocumentationView.translatesAutoresizingMaskIntoConstraints = false

    let innerViewLeadingAnchorConstraint = innerView.leadingAnchor.constraint(equalTo: leadingAnchor)
    let innerViewTopAnchorConstraint = innerView.topAnchor.constraint(equalTo: topAnchor)
    let innerViewBottomAnchorConstraint = innerView.bottomAnchor.constraint(equalTo: bottomAnchor)
    let dividerViewTrailingAnchorConstraint = dividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
    let dividerViewLeadingAnchorConstraint = dividerView.leadingAnchor.constraint(equalTo: innerView.trailingAnchor)
    let dividerViewTopAnchorConstraint = dividerView.topAnchor.constraint(equalTo: topAnchor)
    let dividerViewBottomAnchorConstraint = dividerView.bottomAnchor.constraint(equalTo: bottomAnchor)
    let tabIconLayersViewTopAnchorConstraint = tabIconLayersView.topAnchor.constraint(equalTo: innerView.topAnchor)
    let tabIconLayersViewLeadingAnchorConstraint = tabIconLayersView
      .leadingAnchor
      .constraint(equalTo: innerView.leadingAnchor)
    let tabIconDocumentationViewTopAnchorConstraint = tabIconDocumentationView
      .topAnchor
      .constraint(equalTo: tabIconLayersView.bottomAnchor)
    let tabIconDocumentationViewLeadingAnchorConstraint = tabIconDocumentationView
      .leadingAnchor
      .constraint(equalTo: innerView.leadingAnchor)
    let dividerViewWidthAnchorConstraint = dividerView.widthAnchor.constraint(equalToConstant: 1)
    let tabIconLayersViewHeightAnchorConstraint = tabIconLayersView.heightAnchor.constraint(equalToConstant: 60)
    let tabIconLayersViewWidthAnchorConstraint = tabIconLayersView.widthAnchor.constraint(equalToConstant: 60)
    let tabIconDocumentationViewHeightAnchorConstraint = tabIconDocumentationView
      .heightAnchor
      .constraint(equalToConstant: 60)
    let tabIconDocumentationViewWidthAnchorConstraint = tabIconDocumentationView
      .widthAnchor
      .constraint(equalToConstant: 60)

    NSLayoutConstraint.activate([
      innerViewLeadingAnchorConstraint,
      innerViewTopAnchorConstraint,
      innerViewBottomAnchorConstraint,
      dividerViewTrailingAnchorConstraint,
      dividerViewLeadingAnchorConstraint,
      dividerViewTopAnchorConstraint,
      dividerViewBottomAnchorConstraint,
      tabIconLayersViewTopAnchorConstraint,
      tabIconLayersViewLeadingAnchorConstraint,
      tabIconDocumentationViewTopAnchorConstraint,
      tabIconDocumentationViewLeadingAnchorConstraint,
      dividerViewWidthAnchorConstraint,
      tabIconLayersViewHeightAnchorConstraint,
      tabIconLayersViewWidthAnchorConstraint,
      tabIconDocumentationViewHeightAnchorConstraint,
      tabIconDocumentationViewWidthAnchorConstraint
    ])
  }

  private func update() {
    tabIconDocumentationView.selected = false
    tabIconLayersView.selected = false
    tabIconLayersView.onClick = handleOnClickLayers
    tabIconDocumentationView.onClick = handleOnClickDocumentation
    if selectedValue == "layers" {
      tabIconLayersView.selected = true
    }
    if selectedValue == "documentation" {
      tabIconDocumentationView.selected = true
    }
  }

  private func handleOnClickLayers() {
    onClickLayers?()
  }

  private func handleOnClickDocumentation() {
    onClickDocumentation?()
  }
}

// MARK: - Parameters

extension WorkspaceVerticalTabs {
  public struct Parameters: Equatable {
    public var selectedValue: String
    public var onClickLayers: (() -> Void)?
    public var onClickDocumentation: (() -> Void)?

    public init(selectedValue: String, onClickLayers: (() -> Void)? = nil, onClickDocumentation: (() -> Void)? = nil) {
      self.selectedValue = selectedValue
      self.onClickLayers = onClickLayers
      self.onClickDocumentation = onClickDocumentation
    }

    public init() {
      self.init(selectedValue: "")
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.selectedValue == rhs.selectedValue
    }
  }
}

// MARK: - Model

extension WorkspaceVerticalTabs {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "WorkspaceVerticalTabs"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(selectedValue: String, onClickLayers: (() -> Void)? = nil, onClickDocumentation: (() -> Void)? = nil) {
      self
        .init(
          Parameters(
            selectedValue: selectedValue,
            onClickLayers: onClickLayers,
            onClickDocumentation: onClickDocumentation))
    }

    public init() {
      self.init(selectedValue: "")
    }
  }
}
