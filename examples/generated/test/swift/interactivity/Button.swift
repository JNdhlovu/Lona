import UIKit
import Foundation

// MARK: - Button

public class Button: LonaControlView {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(label: String, secondary: Bool) {
    self.init(Parameters(label: label, secondary: secondary))
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

  public var label: String {
    get { return parameters.label }
    set {
      if parameters.label != newValue {
        parameters.label = newValue
      }
    }
  }

  public var onTap: (() -> Void)? {
    get { return parameters.onTap }
    set { parameters.onTap = newValue }
  }

  public var secondary: Bool {
    get { return parameters.secondary }
    set {
      if parameters.secondary != newValue {
        parameters.secondary = newValue
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

  public var textView = UILabel()

  private var textViewTextStyle = TextStyles.button

  private var onTapViewView: (() -> Void)?

  private func setUpViews() {
    textView.isUserInteractionEnabled = false
    textView.numberOfLines = 0

    addSubview(textView)

    textViewTextStyle = TextStyles.button
    textView.attributedText = textViewTextStyle.apply(to: textView.attributedText ?? NSAttributedString())

    addTarget(self, action: #selector(handleTapViewView), for: .touchUpInside)
    onHighlight = update
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    textView.translatesAutoresizingMaskIntoConstraints = false

    let textViewWidthAnchorParentConstraint = textView
      .widthAnchor
      .constraint(lessThanOrEqualTo: widthAnchor, constant: -32)
    let textViewTopAnchorConstraint = textView.topAnchor.constraint(equalTo: topAnchor, constant: 12)
    let textViewBottomAnchorConstraint = textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
    let textViewLeadingAnchorConstraint = textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
    let textViewTrailingAnchorConstraint = textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)

    textViewWidthAnchorParentConstraint.priority = UILayoutPriority.defaultLow

    NSLayoutConstraint.activate([
      textViewWidthAnchorParentConstraint,
      textViewTopAnchorConstraint,
      textViewBottomAnchorConstraint,
      textViewLeadingAnchorConstraint,
      textViewTrailingAnchorConstraint
    ])
  }

  private func update() {
    backgroundColor = Colors.blue100
    textView.attributedText = textViewTextStyle.apply(to: label)
    onTapViewView = handleOnTap

    if showsHighlight {
      backgroundColor = Colors.blue50
    }
    if secondary {
      backgroundColor = Colors.lightblue100
    }
  }

  private func handleOnTap() {
    onTap?()
  }

  @objc private func handleTapViewView() {
    onTapViewView?()
  }
}

// MARK: - Parameters

extension Button {
  public struct Parameters: Equatable {
    public var label: String
    public var secondary: Bool
    public var onTap: (() -> Void)?

    public init(label: String, secondary: Bool, onTap: (() -> Void)? = nil) {
      self.label = label
      self.secondary = secondary
      self.onTap = onTap
    }

    public init() {
      self.init(label: "", secondary: false)
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.label == rhs.label && lhs.secondary == rhs.secondary
    }
  }
}

// MARK: - Model

extension Button {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "Button"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(label: String, secondary: Bool, onTap: (() -> Void)? = nil) {
      self.init(Parameters(label: label, secondary: secondary, onTap: onTap))
    }

    public init() {
      self.init(label: "", secondary: false)
    }
  }
}
