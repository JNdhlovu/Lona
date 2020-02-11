import AppKit
import Foundation

// MARK: - RecentProjectItem

public class RecentProjectItem: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(projectName: String, projectDirectoryPath: String, selected: Bool) {
    self.init(Parameters(projectName: projectName, projectDirectoryPath: projectDirectoryPath, selected: selected))
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

  public var projectName: String {
    get { return parameters.projectName }
    set {
      if parameters.projectName != newValue {
        parameters.projectName = newValue
      }
    }
  }

  public var projectDirectoryPath: String {
    get { return parameters.projectDirectoryPath }
    set {
      if parameters.projectDirectoryPath != newValue {
        parameters.projectDirectoryPath = newValue
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

  private var projectNameView = LNATextField(labelWithString: "")
  private var projectDirectoryPathView = LNATextField(labelWithString: "")

  private var projectNameViewTextStyle = TextStyles.regular
  private var projectDirectoryPathViewTextStyle = TextStyles.regularMuted

  private func setUpViews() {
    boxType = .custom
    borderType = .noBorder
    contentViewMargins = .zero
    projectNameView.lineBreakMode = .byWordWrapping
    projectDirectoryPathView.lineBreakMode = .byWordWrapping

    addSubview(projectNameView)
    addSubview(projectDirectoryPathView)

    projectNameView.maximumNumberOfLines = 1
    projectDirectoryPathView.maximumNumberOfLines = 1
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    projectNameView.translatesAutoresizingMaskIntoConstraints = false
    projectDirectoryPathView.translatesAutoresizingMaskIntoConstraints = false

    let heightAnchorConstraint = heightAnchor.constraint(equalToConstant: 54)
    let projectNameViewTopAnchorConstraint = projectNameView.topAnchor.constraint(equalTo: topAnchor, constant: 10)
    let projectNameViewLeadingAnchorConstraint = projectNameView
      .leadingAnchor
      .constraint(equalTo: leadingAnchor, constant: 12)
    let projectNameViewTrailingAnchorConstraint = projectNameView
      .trailingAnchor
      .constraint(equalTo: trailingAnchor, constant: -12)
    let projectDirectoryPathViewTopAnchorConstraint = projectDirectoryPathView
      .topAnchor
      .constraint(equalTo: projectNameView.bottomAnchor, constant: 4)
    let projectDirectoryPathViewLeadingAnchorConstraint = projectDirectoryPathView
      .leadingAnchor
      .constraint(equalTo: leadingAnchor, constant: 12)
    let projectDirectoryPathViewTrailingAnchorConstraint = projectDirectoryPathView
      .trailingAnchor
      .constraint(equalTo: trailingAnchor, constant: -12)

    NSLayoutConstraint.activate([
      heightAnchorConstraint,
      projectNameViewTopAnchorConstraint,
      projectNameViewLeadingAnchorConstraint,
      projectNameViewTrailingAnchorConstraint,
      projectDirectoryPathViewTopAnchorConstraint,
      projectDirectoryPathViewLeadingAnchorConstraint,
      projectDirectoryPathViewTrailingAnchorConstraint
    ])
  }

  private func update() {
    projectDirectoryPathViewTextStyle = TextStyles.regularMuted
    projectDirectoryPathView.attributedStringValue =
      projectDirectoryPathViewTextStyle.apply(to: projectDirectoryPathView.attributedStringValue)
    projectNameViewTextStyle = TextStyles.regular
    projectNameView.attributedStringValue = projectNameViewTextStyle.apply(to: projectNameView.attributedStringValue)
    projectNameView.attributedStringValue = projectNameViewTextStyle.apply(to: projectName)
    projectDirectoryPathView.attributedStringValue = projectDirectoryPathViewTextStyle.apply(to: projectDirectoryPath)
    if selected {
      projectNameViewTextStyle = TextStyles.regularInverse
      projectNameView.attributedStringValue = projectNameViewTextStyle.apply(to: projectNameView.attributedStringValue)
      projectDirectoryPathViewTextStyle = TextStyles.regularInverse
      projectDirectoryPathView.attributedStringValue =
        projectDirectoryPathViewTextStyle.apply(to: projectDirectoryPathView.attributedStringValue)
    }
  }
}

// MARK: - Parameters

extension RecentProjectItem {
  public struct Parameters: Equatable {
    public var projectName: String
    public var projectDirectoryPath: String
    public var selected: Bool

    public init(projectName: String, projectDirectoryPath: String, selected: Bool) {
      self.projectName = projectName
      self.projectDirectoryPath = projectDirectoryPath
      self.selected = selected
    }

    public init() {
      self.init(projectName: "", projectDirectoryPath: "", selected: false)
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.projectName == rhs.projectName &&
        lhs.projectDirectoryPath == rhs.projectDirectoryPath && lhs.selected == rhs.selected
    }
  }
}

// MARK: - Model

extension RecentProjectItem {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "RecentProjectItem"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(projectName: String, projectDirectoryPath: String, selected: Bool) {
      self.init(Parameters(projectName: projectName, projectDirectoryPath: projectDirectoryPath, selected: selected))
    }

    public init() {
      self.init(projectName: "", projectDirectoryPath: "", selected: false)
    }
  }
}
