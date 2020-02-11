import AppKit
import Foundation

// MARK: - GeneratedOutputPreview

public class GeneratedOutputPreview: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(
    commandText: String,
    generatedCode: String,
    compilerTargetIndex: Int,
    compilerTargetValues: [String],
    frameworkIndex: Int,
    frameworkValues: [String])
  {
    self
      .init(
        Parameters(
          commandText: commandText,
          generatedCode: generatedCode,
          compilerTargetIndex: compilerTargetIndex,
          compilerTargetValues: compilerTargetValues,
          frameworkIndex: frameworkIndex,
          frameworkValues: frameworkValues))
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

  public var commandText: String {
    get { return parameters.commandText }
    set {
      if parameters.commandText != newValue {
        parameters.commandText = newValue
      }
    }
  }

  public var generatedCode: String {
    get { return parameters.generatedCode }
    set {
      if parameters.generatedCode != newValue {
        parameters.generatedCode = newValue
      }
    }
  }

  public var compilerTargetIndex: Int {
    get { return parameters.compilerTargetIndex }
    set {
      if parameters.compilerTargetIndex != newValue {
        parameters.compilerTargetIndex = newValue
      }
    }
  }

  public var compilerTargetValues: [String] {
    get { return parameters.compilerTargetValues }
    set {
      if parameters.compilerTargetValues != newValue {
        parameters.compilerTargetValues = newValue
      }
    }
  }

  public var onChangeFrameworkIndex: ((Int) -> Void)? {
    get { return parameters.onChangeFrameworkIndex }
    set { parameters.onChangeFrameworkIndex = newValue }
  }

  public var frameworkIndex: Int {
    get { return parameters.frameworkIndex }
    set {
      if parameters.frameworkIndex != newValue {
        parameters.frameworkIndex = newValue
      }
    }
  }

  public var frameworkValues: [String] {
    get { return parameters.frameworkValues }
    set {
      if parameters.frameworkValues != newValue {
        parameters.frameworkValues = newValue
      }
    }
  }

  public var onChangeCompilerTargetIndex: ((Int) -> Void)? {
    get { return parameters.onChangeCompilerTargetIndex }
    set { parameters.onChangeCompilerTargetIndex = newValue }
  }

  public var parameters: Parameters {
    didSet {
      if parameters != oldValue {
        update()
      }
    }
  }

  // MARK: Private

  private var inputsView = NSBox()
  private var targetContainerView = NSBox()
  private var targetLabelView = LNATextField(labelWithString: "")
  private var targetDropdownContainerView = NSBox()
  private var targetDropdownView = ControlledDropdown()
  private var spacerView = NSBox()
  private var frameworkContainerView = NSBox()
  private var frameworkLabelView = LNATextField(labelWithString: "")
  private var frameworkDropdownContainerView = NSBox()
  private var frameworkDropdownView = ControlledDropdown()
  private var divider1View = NSBox()
  private var commandContainerView = NSBox()
  var commandPreviewView = LNATextField(labelWithString: "")
  private var divider2View = NSBox()
  private var codeContainerView = NSBox()
  var codePreviewView = LNATextField(labelWithString: "")

  private var targetLabelViewTextStyle = TextStyles.regular
  private var frameworkLabelViewTextStyle = TextStyles.regular
  private var commandPreviewViewTextStyle = TextStyles.monospacedMicro
  private var codePreviewViewTextStyle = TextStyles.monospacedMicro

  private func setUpViews() {
    boxType = .custom
    borderType = .noBorder
    contentViewMargins = .zero
    inputsView.boxType = .custom
    inputsView.borderType = .noBorder
    inputsView.contentViewMargins = .zero
    divider1View.boxType = .custom
    divider1View.borderType = .noBorder
    divider1View.contentViewMargins = .zero
    commandContainerView.boxType = .custom
    commandContainerView.borderType = .noBorder
    commandContainerView.contentViewMargins = .zero
    divider2View.boxType = .custom
    divider2View.borderType = .noBorder
    divider2View.contentViewMargins = .zero
    codeContainerView.boxType = .custom
    codeContainerView.borderType = .noBorder
    codeContainerView.contentViewMargins = .zero
    targetContainerView.boxType = .custom
    targetContainerView.borderType = .noBorder
    targetContainerView.contentViewMargins = .zero
    spacerView.boxType = .custom
    spacerView.borderType = .noBorder
    spacerView.contentViewMargins = .zero
    frameworkContainerView.boxType = .custom
    frameworkContainerView.borderType = .noBorder
    frameworkContainerView.contentViewMargins = .zero
    targetLabelView.lineBreakMode = .byWordWrapping
    targetDropdownContainerView.boxType = .custom
    targetDropdownContainerView.borderType = .noBorder
    targetDropdownContainerView.contentViewMargins = .zero
    frameworkLabelView.lineBreakMode = .byWordWrapping
    frameworkDropdownContainerView.boxType = .custom
    frameworkDropdownContainerView.borderType = .noBorder
    frameworkDropdownContainerView.contentViewMargins = .zero
    commandPreviewView.lineBreakMode = .byWordWrapping
    codePreviewView.lineBreakMode = .byWordWrapping

    addSubview(inputsView)
    addSubview(divider1View)
    addSubview(commandContainerView)
    addSubview(divider2View)
    addSubview(codeContainerView)
    inputsView.addSubview(targetContainerView)
    inputsView.addSubview(spacerView)
    inputsView.addSubview(frameworkContainerView)
    targetContainerView.addSubview(targetLabelView)
    targetContainerView.addSubview(targetDropdownContainerView)
    targetDropdownContainerView.addSubview(targetDropdownView)
    frameworkContainerView.addSubview(frameworkLabelView)
    frameworkContainerView.addSubview(frameworkDropdownContainerView)
    frameworkDropdownContainerView.addSubview(frameworkDropdownView)
    commandContainerView.addSubview(commandPreviewView)
    codeContainerView.addSubview(codePreviewView)

    inputsView.fillColor = Colors.contentBackground
    targetLabelView.attributedStringValue = targetLabelViewTextStyle.apply(to: "Compiler target")
    frameworkLabelView.attributedStringValue = frameworkLabelViewTextStyle.apply(to: "Framework")
    divider1View.fillColor = Colors.darkTransparentOutline
    commandContainerView.fillColor = Colors.headerBackground
    commandPreviewViewTextStyle = TextStyles.monospacedMicro
    commandPreviewView.attributedStringValue =
      commandPreviewViewTextStyle.apply(to: commandPreviewView.attributedStringValue)
    divider2View.fillColor = Colors.darkTransparentOutline
    codeContainerView.fillColor = Colors.headerBackground
    codePreviewViewTextStyle = TextStyles.monospacedMicro
    codePreviewView.attributedStringValue = codePreviewViewTextStyle.apply(to: codePreviewView.attributedStringValue)
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    inputsView.translatesAutoresizingMaskIntoConstraints = false
    divider1View.translatesAutoresizingMaskIntoConstraints = false
    commandContainerView.translatesAutoresizingMaskIntoConstraints = false
    divider2View.translatesAutoresizingMaskIntoConstraints = false
    codeContainerView.translatesAutoresizingMaskIntoConstraints = false
    targetContainerView.translatesAutoresizingMaskIntoConstraints = false
    spacerView.translatesAutoresizingMaskIntoConstraints = false
    frameworkContainerView.translatesAutoresizingMaskIntoConstraints = false
    targetLabelView.translatesAutoresizingMaskIntoConstraints = false
    targetDropdownContainerView.translatesAutoresizingMaskIntoConstraints = false
    targetDropdownView.translatesAutoresizingMaskIntoConstraints = false
    frameworkLabelView.translatesAutoresizingMaskIntoConstraints = false
    frameworkDropdownContainerView.translatesAutoresizingMaskIntoConstraints = false
    frameworkDropdownView.translatesAutoresizingMaskIntoConstraints = false
    commandPreviewView.translatesAutoresizingMaskIntoConstraints = false
    codePreviewView.translatesAutoresizingMaskIntoConstraints = false

    let inputsViewTopAnchorConstraint = inputsView.topAnchor.constraint(equalTo: topAnchor)
    let inputsViewLeadingAnchorConstraint = inputsView.leadingAnchor.constraint(equalTo: leadingAnchor)
    let inputsViewTrailingAnchorConstraint = inputsView.trailingAnchor.constraint(equalTo: trailingAnchor)
    let divider1ViewTopAnchorConstraint = divider1View.topAnchor.constraint(equalTo: inputsView.bottomAnchor)
    let divider1ViewLeadingAnchorConstraint = divider1View.leadingAnchor.constraint(equalTo: leadingAnchor)
    let divider1ViewTrailingAnchorConstraint = divider1View.trailingAnchor.constraint(equalTo: trailingAnchor)
    let commandContainerViewTopAnchorConstraint = commandContainerView
      .topAnchor
      .constraint(equalTo: divider1View.bottomAnchor)
    let commandContainerViewLeadingAnchorConstraint = commandContainerView
      .leadingAnchor
      .constraint(equalTo: leadingAnchor)
    let commandContainerViewTrailingAnchorConstraint = commandContainerView
      .trailingAnchor
      .constraint(equalTo: trailingAnchor)
    let divider2ViewTopAnchorConstraint = divider2View.topAnchor.constraint(equalTo: commandContainerView.bottomAnchor)
    let divider2ViewLeadingAnchorConstraint = divider2View.leadingAnchor.constraint(equalTo: leadingAnchor)
    let divider2ViewTrailingAnchorConstraint = divider2View.trailingAnchor.constraint(equalTo: trailingAnchor)
    let codeContainerViewBottomAnchorConstraint = codeContainerView.bottomAnchor.constraint(equalTo: bottomAnchor)
    let codeContainerViewTopAnchorConstraint = codeContainerView
      .topAnchor
      .constraint(equalTo: divider2View.bottomAnchor)
    let codeContainerViewLeadingAnchorConstraint = codeContainerView.leadingAnchor.constraint(equalTo: leadingAnchor)
    let codeContainerViewTrailingAnchorConstraint = codeContainerView.trailingAnchor.constraint(equalTo: trailingAnchor)
    let targetContainerViewTopAnchorConstraint = targetContainerView
      .topAnchor
      .constraint(equalTo: inputsView.topAnchor, constant: 16)
    let targetContainerViewLeadingAnchorConstraint = targetContainerView
      .leadingAnchor
      .constraint(equalTo: inputsView.leadingAnchor, constant: 20)
    let targetContainerViewTrailingAnchorConstraint = targetContainerView
      .trailingAnchor
      .constraint(equalTo: inputsView.trailingAnchor, constant: -20)
    let spacerViewTopAnchorConstraint = spacerView.topAnchor.constraint(equalTo: targetContainerView.bottomAnchor)
    let spacerViewLeadingAnchorConstraint = spacerView
      .leadingAnchor
      .constraint(equalTo: inputsView.leadingAnchor, constant: 20)
    let spacerViewTrailingAnchorConstraint = spacerView
      .trailingAnchor
      .constraint(equalTo: inputsView.trailingAnchor, constant: -20)
    let frameworkContainerViewBottomAnchorConstraint = frameworkContainerView
      .bottomAnchor
      .constraint(equalTo: inputsView.bottomAnchor, constant: -16)
    let frameworkContainerViewTopAnchorConstraint = frameworkContainerView
      .topAnchor
      .constraint(equalTo: spacerView.bottomAnchor)
    let frameworkContainerViewLeadingAnchorConstraint = frameworkContainerView
      .leadingAnchor
      .constraint(equalTo: inputsView.leadingAnchor, constant: 20)
    let frameworkContainerViewTrailingAnchorConstraint = frameworkContainerView
      .trailingAnchor
      .constraint(equalTo: inputsView.trailingAnchor, constant: -20)
    let divider1ViewHeightAnchorConstraint = divider1View.heightAnchor.constraint(equalToConstant: 1)
    let commandPreviewViewTopAnchorConstraint = commandPreviewView
      .topAnchor
      .constraint(equalTo: commandContainerView.topAnchor, constant: 20)
    let commandPreviewViewBottomAnchorConstraint = commandPreviewView
      .bottomAnchor
      .constraint(equalTo: commandContainerView.bottomAnchor, constant: -20)
    let commandPreviewViewLeadingAnchorConstraint = commandPreviewView
      .leadingAnchor
      .constraint(equalTo: commandContainerView.leadingAnchor, constant: 20)
    let commandPreviewViewTrailingAnchorConstraint = commandPreviewView
      .trailingAnchor
      .constraint(equalTo: commandContainerView.trailingAnchor, constant: -20)
    let divider2ViewHeightAnchorConstraint = divider2View.heightAnchor.constraint(equalToConstant: 1)
    let codePreviewViewTopAnchorConstraint = codePreviewView
      .topAnchor
      .constraint(equalTo: codeContainerView.topAnchor, constant: 20)
    let codePreviewViewLeadingAnchorConstraint = codePreviewView
      .leadingAnchor
      .constraint(equalTo: codeContainerView.leadingAnchor, constant: 20)
    let codePreviewViewTrailingAnchorConstraint = codePreviewView
      .trailingAnchor
      .constraint(equalTo: codeContainerView.trailingAnchor, constant: -20)
    let targetLabelViewHeightAnchorParentConstraint = targetLabelView
      .heightAnchor
      .constraint(lessThanOrEqualTo: targetContainerView.heightAnchor)
    let targetDropdownContainerViewHeightAnchorParentConstraint = targetDropdownContainerView
      .heightAnchor
      .constraint(lessThanOrEqualTo: targetContainerView.heightAnchor)
    let targetLabelViewLeadingAnchorConstraint = targetLabelView
      .leadingAnchor
      .constraint(equalTo: targetContainerView.leadingAnchor)
    let targetLabelViewTopAnchorConstraint = targetLabelView
      .topAnchor
      .constraint(equalTo: targetContainerView.topAnchor)
    let targetLabelViewCenterYAnchorConstraint = targetLabelView
      .centerYAnchor
      .constraint(equalTo: targetContainerView.centerYAnchor)
    let targetLabelViewBottomAnchorConstraint = targetLabelView
      .bottomAnchor
      .constraint(equalTo: targetContainerView.bottomAnchor)
    let targetDropdownContainerViewLeadingAnchorConstraint = targetDropdownContainerView
      .leadingAnchor
      .constraint(equalTo: targetLabelView.trailingAnchor)
    let targetDropdownContainerViewTopAnchorConstraint = targetDropdownContainerView
      .topAnchor
      .constraint(equalTo: targetContainerView.topAnchor)
    let targetDropdownContainerViewCenterYAnchorConstraint = targetDropdownContainerView
      .centerYAnchor
      .constraint(equalTo: targetContainerView.centerYAnchor)
    let targetDropdownContainerViewBottomAnchorConstraint = targetDropdownContainerView
      .bottomAnchor
      .constraint(equalTo: targetContainerView.bottomAnchor)
    let spacerViewHeightAnchorConstraint = spacerView.heightAnchor.constraint(equalToConstant: 6)
    let frameworkLabelViewHeightAnchorParentConstraint = frameworkLabelView
      .heightAnchor
      .constraint(lessThanOrEqualTo: frameworkContainerView.heightAnchor)
    let frameworkDropdownContainerViewHeightAnchorParentConstraint = frameworkDropdownContainerView
      .heightAnchor
      .constraint(lessThanOrEqualTo: frameworkContainerView.heightAnchor)
    let frameworkLabelViewLeadingAnchorConstraint = frameworkLabelView
      .leadingAnchor
      .constraint(equalTo: frameworkContainerView.leadingAnchor)
    let frameworkLabelViewTopAnchorConstraint = frameworkLabelView
      .topAnchor
      .constraint(equalTo: frameworkContainerView.topAnchor)
    let frameworkLabelViewCenterYAnchorConstraint = frameworkLabelView
      .centerYAnchor
      .constraint(equalTo: frameworkContainerView.centerYAnchor)
    let frameworkLabelViewBottomAnchorConstraint = frameworkLabelView
      .bottomAnchor
      .constraint(equalTo: frameworkContainerView.bottomAnchor)
    let frameworkDropdownContainerViewLeadingAnchorConstraint = frameworkDropdownContainerView
      .leadingAnchor
      .constraint(equalTo: frameworkLabelView.trailingAnchor)
    let frameworkDropdownContainerViewTopAnchorConstraint = frameworkDropdownContainerView
      .topAnchor
      .constraint(equalTo: frameworkContainerView.topAnchor)
    let frameworkDropdownContainerViewCenterYAnchorConstraint = frameworkDropdownContainerView
      .centerYAnchor
      .constraint(equalTo: frameworkContainerView.centerYAnchor)
    let frameworkDropdownContainerViewBottomAnchorConstraint = frameworkDropdownContainerView
      .bottomAnchor
      .constraint(equalTo: frameworkContainerView.bottomAnchor)
    let targetLabelViewWidthAnchorConstraint = targetLabelView.widthAnchor.constraint(equalToConstant: 120)
    let targetDropdownContainerViewWidthAnchorConstraint = targetDropdownContainerView
      .widthAnchor
      .constraint(equalToConstant: 100)
    let targetDropdownViewTopAnchorConstraint = targetDropdownView
      .topAnchor
      .constraint(equalTo: targetDropdownContainerView.topAnchor)
    let targetDropdownViewBottomAnchorConstraint = targetDropdownView
      .bottomAnchor
      .constraint(equalTo: targetDropdownContainerView.bottomAnchor)
    let targetDropdownViewLeadingAnchorConstraint = targetDropdownView
      .leadingAnchor
      .constraint(equalTo: targetDropdownContainerView.leadingAnchor)
    let targetDropdownViewTrailingAnchorConstraint = targetDropdownView
      .trailingAnchor
      .constraint(equalTo: targetDropdownContainerView.trailingAnchor)
    let frameworkLabelViewWidthAnchorConstraint = frameworkLabelView.widthAnchor.constraint(equalToConstant: 120)
    let frameworkDropdownContainerViewWidthAnchorConstraint = frameworkDropdownContainerView
      .widthAnchor
      .constraint(equalToConstant: 100)
    let frameworkDropdownViewTopAnchorConstraint = frameworkDropdownView
      .topAnchor
      .constraint(equalTo: frameworkDropdownContainerView.topAnchor)
    let frameworkDropdownViewBottomAnchorConstraint = frameworkDropdownView
      .bottomAnchor
      .constraint(equalTo: frameworkDropdownContainerView.bottomAnchor)
    let frameworkDropdownViewLeadingAnchorConstraint = frameworkDropdownView
      .leadingAnchor
      .constraint(equalTo: frameworkDropdownContainerView.leadingAnchor)
    let frameworkDropdownViewTrailingAnchorConstraint = frameworkDropdownView
      .trailingAnchor
      .constraint(equalTo: frameworkDropdownContainerView.trailingAnchor)

    targetLabelViewHeightAnchorParentConstraint.priority = NSLayoutConstraint.Priority.defaultLow
    targetDropdownContainerViewHeightAnchorParentConstraint.priority = NSLayoutConstraint.Priority.defaultLow
    frameworkLabelViewHeightAnchorParentConstraint.priority = NSLayoutConstraint.Priority.defaultLow
    frameworkDropdownContainerViewHeightAnchorParentConstraint.priority = NSLayoutConstraint.Priority.defaultLow

    NSLayoutConstraint.activate([
      inputsViewTopAnchorConstraint,
      inputsViewLeadingAnchorConstraint,
      inputsViewTrailingAnchorConstraint,
      divider1ViewTopAnchorConstraint,
      divider1ViewLeadingAnchorConstraint,
      divider1ViewTrailingAnchorConstraint,
      commandContainerViewTopAnchorConstraint,
      commandContainerViewLeadingAnchorConstraint,
      commandContainerViewTrailingAnchorConstraint,
      divider2ViewTopAnchorConstraint,
      divider2ViewLeadingAnchorConstraint,
      divider2ViewTrailingAnchorConstraint,
      codeContainerViewBottomAnchorConstraint,
      codeContainerViewTopAnchorConstraint,
      codeContainerViewLeadingAnchorConstraint,
      codeContainerViewTrailingAnchorConstraint,
      targetContainerViewTopAnchorConstraint,
      targetContainerViewLeadingAnchorConstraint,
      targetContainerViewTrailingAnchorConstraint,
      spacerViewTopAnchorConstraint,
      spacerViewLeadingAnchorConstraint,
      spacerViewTrailingAnchorConstraint,
      frameworkContainerViewBottomAnchorConstraint,
      frameworkContainerViewTopAnchorConstraint,
      frameworkContainerViewLeadingAnchorConstraint,
      frameworkContainerViewTrailingAnchorConstraint,
      divider1ViewHeightAnchorConstraint,
      commandPreviewViewTopAnchorConstraint,
      commandPreviewViewBottomAnchorConstraint,
      commandPreviewViewLeadingAnchorConstraint,
      commandPreviewViewTrailingAnchorConstraint,
      divider2ViewHeightAnchorConstraint,
      codePreviewViewTopAnchorConstraint,
      codePreviewViewLeadingAnchorConstraint,
      codePreviewViewTrailingAnchorConstraint,
      targetLabelViewHeightAnchorParentConstraint,
      targetDropdownContainerViewHeightAnchorParentConstraint,
      targetLabelViewLeadingAnchorConstraint,
      targetLabelViewTopAnchorConstraint,
      targetLabelViewCenterYAnchorConstraint,
      targetLabelViewBottomAnchorConstraint,
      targetDropdownContainerViewLeadingAnchorConstraint,
      targetDropdownContainerViewTopAnchorConstraint,
      targetDropdownContainerViewCenterYAnchorConstraint,
      targetDropdownContainerViewBottomAnchorConstraint,
      spacerViewHeightAnchorConstraint,
      frameworkLabelViewHeightAnchorParentConstraint,
      frameworkDropdownContainerViewHeightAnchorParentConstraint,
      frameworkLabelViewLeadingAnchorConstraint,
      frameworkLabelViewTopAnchorConstraint,
      frameworkLabelViewCenterYAnchorConstraint,
      frameworkLabelViewBottomAnchorConstraint,
      frameworkDropdownContainerViewLeadingAnchorConstraint,
      frameworkDropdownContainerViewTopAnchorConstraint,
      frameworkDropdownContainerViewCenterYAnchorConstraint,
      frameworkDropdownContainerViewBottomAnchorConstraint,
      targetLabelViewWidthAnchorConstraint,
      targetDropdownContainerViewWidthAnchorConstraint,
      targetDropdownViewTopAnchorConstraint,
      targetDropdownViewBottomAnchorConstraint,
      targetDropdownViewLeadingAnchorConstraint,
      targetDropdownViewTrailingAnchorConstraint,
      frameworkLabelViewWidthAnchorConstraint,
      frameworkDropdownContainerViewWidthAnchorConstraint,
      frameworkDropdownViewTopAnchorConstraint,
      frameworkDropdownViewBottomAnchorConstraint,
      frameworkDropdownViewLeadingAnchorConstraint,
      frameworkDropdownViewTrailingAnchorConstraint
    ])
  }

  private func update() {
    commandPreviewView.attributedStringValue = commandPreviewViewTextStyle.apply(to: commandText)
    codePreviewView.attributedStringValue = codePreviewViewTextStyle.apply(to: generatedCode)
    targetDropdownView.selectedIndex = compilerTargetIndex
    targetDropdownView.values = compilerTargetValues
    targetDropdownView.onChangeIndex = handleOnChangeCompilerTargetIndex
    frameworkDropdownView.selectedIndex = frameworkIndex
    frameworkDropdownView.values = frameworkValues
    frameworkDropdownView.onChangeIndex = handleOnChangeFrameworkIndex
  }

  private func handleOnChangeFrameworkIndex(_ arg0: Int) {
    onChangeFrameworkIndex?(arg0)
  }

  private func handleOnChangeCompilerTargetIndex(_ arg0: Int) {
    onChangeCompilerTargetIndex?(arg0)
  }
}

// MARK: - Parameters

extension GeneratedOutputPreview {
  public struct Parameters: Equatable {
    public var commandText: String
    public var generatedCode: String
    public var compilerTargetIndex: Int
    public var compilerTargetValues: [String]
    public var frameworkIndex: Int
    public var frameworkValues: [String]
    public var onChangeFrameworkIndex: ((Int) -> Void)?
    public var onChangeCompilerTargetIndex: ((Int) -> Void)?

    public init(
      commandText: String,
      generatedCode: String,
      compilerTargetIndex: Int,
      compilerTargetValues: [String],
      frameworkIndex: Int,
      frameworkValues: [String],
      onChangeFrameworkIndex: ((Int) -> Void)? = nil,
      onChangeCompilerTargetIndex: ((Int) -> Void)? = nil)
    {
      self.commandText = commandText
      self.generatedCode = generatedCode
      self.compilerTargetIndex = compilerTargetIndex
      self.compilerTargetValues = compilerTargetValues
      self.frameworkIndex = frameworkIndex
      self.frameworkValues = frameworkValues
      self.onChangeFrameworkIndex = onChangeFrameworkIndex
      self.onChangeCompilerTargetIndex = onChangeCompilerTargetIndex
    }

    public init() {
      self
        .init(
          commandText: "",
          generatedCode: "",
          compilerTargetIndex: 0,
          compilerTargetValues: [],
          frameworkIndex: 0,
          frameworkValues: [])
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.commandText == rhs.commandText &&
        lhs.generatedCode == rhs.generatedCode &&
          lhs.compilerTargetIndex == rhs.compilerTargetIndex &&
            lhs.compilerTargetValues == rhs.compilerTargetValues &&
              lhs.frameworkIndex == rhs.frameworkIndex && lhs.frameworkValues == rhs.frameworkValues
    }
  }
}

// MARK: - Model

extension GeneratedOutputPreview {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "GeneratedOutputPreview"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(
      commandText: String,
      generatedCode: String,
      compilerTargetIndex: Int,
      compilerTargetValues: [String],
      frameworkIndex: Int,
      frameworkValues: [String],
      onChangeFrameworkIndex: ((Int) -> Void)? = nil,
      onChangeCompilerTargetIndex: ((Int) -> Void)? = nil)
    {
      self
        .init(
          Parameters(
            commandText: commandText,
            generatedCode: generatedCode,
            compilerTargetIndex: compilerTargetIndex,
            compilerTargetValues: compilerTargetValues,
            frameworkIndex: frameworkIndex,
            frameworkValues: frameworkValues,
            onChangeFrameworkIndex: onChangeFrameworkIndex,
            onChangeCompilerTargetIndex: onChangeCompilerTargetIndex))
    }

    public init() {
      self
        .init(
          commandText: "",
          generatedCode: "",
          compilerTargetIndex: 0,
          compilerTargetValues: [],
          frameworkIndex: 0,
          frameworkValues: [])
    }
  }
}
