import AppKit
import Foundation

// MARK: - LabeledDropdownRow

public class LabeledDropdownRow: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(selectedIndex: Int, labelText: String, options: [String]) {
    self.init(Parameters(selectedIndex: selectedIndex, labelText: labelText, options: options))
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

  public var selectedIndex: Int {
    get { return parameters.selectedIndex }
    set {
      if parameters.selectedIndex != newValue {
        parameters.selectedIndex = newValue
      }
    }
  }

  public var onChangeSelectedIndex: ((Int) -> Void)? {
    get { return parameters.onChangeSelectedIndex }
    set { parameters.onChangeSelectedIndex = newValue }
  }

  public var labelText: String {
    get { return parameters.labelText }
    set {
      if parameters.labelText != newValue {
        parameters.labelText = newValue
      }
    }
  }

  public var options: [String] {
    get { return parameters.options }
    set {
      if parameters.options != newValue {
        parameters.options = newValue
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

  private var labelView = LNATextField(labelWithString: "")
  private var dropdownView = ControlledDropdown()

  private var labelViewTextStyle = TextStyles.regular

  private func setUpViews() {
    boxType = .custom
    borderType = .noBorder
    contentViewMargins = .zero
    labelView.lineBreakMode = .byWordWrapping

    addSubview(labelView)
    addSubview(dropdownView)
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    labelView.translatesAutoresizingMaskIntoConstraints = false
    dropdownView.translatesAutoresizingMaskIntoConstraints = false

    let labelViewTopAnchorConstraint = labelView.topAnchor.constraint(equalTo: topAnchor)
    let labelViewLeadingAnchorConstraint = labelView.leadingAnchor.constraint(equalTo: leadingAnchor)
    let labelViewTrailingAnchorConstraint = labelView.trailingAnchor.constraint(equalTo: trailingAnchor)
    let dropdownViewBottomAnchorConstraint = dropdownView.bottomAnchor.constraint(equalTo: bottomAnchor)
    let dropdownViewTopAnchorConstraint = dropdownView
      .topAnchor
      .constraint(equalTo: labelView.bottomAnchor, constant: 8)
    let dropdownViewLeadingAnchorConstraint = dropdownView.leadingAnchor.constraint(equalTo: leadingAnchor)
    let dropdownViewTrailingAnchorConstraint = dropdownView.trailingAnchor.constraint(equalTo: trailingAnchor)

    NSLayoutConstraint.activate([
      labelViewTopAnchorConstraint,
      labelViewLeadingAnchorConstraint,
      labelViewTrailingAnchorConstraint,
      dropdownViewBottomAnchorConstraint,
      dropdownViewTopAnchorConstraint,
      dropdownViewLeadingAnchorConstraint,
      dropdownViewTrailingAnchorConstraint
    ])
  }

  private func update() {
    labelView.attributedStringValue = labelViewTextStyle.apply(to: labelText)
    dropdownView.selectedIndex = selectedIndex
    dropdownView.onChangeIndex = handleOnChangeSelectedIndex
    dropdownView.values = options
  }

  private func handleOnChangeSelectedIndex(_ arg0: Int) {
    onChangeSelectedIndex?(arg0)
  }
}

// MARK: - Parameters

extension LabeledDropdownRow {
  public struct Parameters: Equatable {
    public var selectedIndex: Int
    public var labelText: String
    public var options: [String]
    public var onChangeSelectedIndex: ((Int) -> Void)?

    public init(
      selectedIndex: Int,
      labelText: String,
      options: [String],
      onChangeSelectedIndex: ((Int) -> Void)? = nil)
    {
      self.selectedIndex = selectedIndex
      self.labelText = labelText
      self.options = options
      self.onChangeSelectedIndex = onChangeSelectedIndex
    }

    public init() {
      self.init(selectedIndex: 0, labelText: "", options: [])
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.selectedIndex == rhs.selectedIndex && lhs.labelText == rhs.labelText && lhs.options == rhs.options
    }
  }
}

// MARK: - Model

extension LabeledDropdownRow {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "LabeledDropdownRow"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(
      selectedIndex: Int,
      labelText: String,
      options: [String],
      onChangeSelectedIndex: ((Int) -> Void)? = nil)
    {
      self
        .init(
          Parameters(
            selectedIndex: selectedIndex,
            labelText: labelText,
            options: options,
            onChangeSelectedIndex: onChangeSelectedIndex))
    }

    public init() {
      self.init(selectedIndex: 0, labelText: "", options: [])
    }
  }
}
