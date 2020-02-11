import AppKit
import Foundation

private class IconLonaFileVector: NSBox {
  public var foldFill = #colorLiteral(red: 0.933333333333, green: 0.933333333333, blue: 0.933333333333, alpha: 1)
  public var foldStroke = #colorLiteral(red: 0.549019607843, green: 0.549019607843, blue: 0.549019607843, alpha: 1)
  public var lonaLogoFill = #colorLiteral(red: 0.592156862745, green: 0.592156862745, blue: 0.592156862745, alpha: 1)
  public var outlineFill = #colorLiteral(red: 0.847058823529, green: 0.847058823529, blue: 0.847058823529, alpha: 1)
  public var outlineStroke = #colorLiteral(red: 0.549019607843, green: 0.549019607843, blue: 0.549019607843, alpha: 1)

  override var isFlipped: Bool {
    return true
  }

  var resizingMode = CGSize.ResizingMode.scaleAspectFill {
    didSet {
      if resizingMode != oldValue {
        needsDisplay = true
      }
    }
  }

  override func draw(_ dirtyRect: CGRect) {
    super.draw(dirtyRect)

    let viewBox = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 24, height: 24))
    let croppedRect = viewBox.size.resized(within: bounds.size, usingResizingMode: resizingMode)
    let scale = croppedRect.width / viewBox.width
    func transform(point: CGPoint) -> CGPoint {
      return CGPoint(x: point.x * scale + croppedRect.minX, y: point.y * scale + croppedRect.minY)
    }
    let outline = NSBezierPath()
    outline.move(to: transform(point: CGPoint(x: 5.5, y: 2.5)))
    outline.line(to: transform(point: CGPoint(x: 12.6715729, y: 2.5)))
    outline.curve(
      to: transform(point: CGPoint(x: 14.0857864, y: 3.08578644)),
      controlPoint1: transform(point: CGPoint(x: 13.2020059, y: 2.5)),
      controlPoint2: transform(point: CGPoint(x: 13.7107137, y: 2.71071368)))
    outline.line(to: transform(point: CGPoint(x: 17.9142136, y: 6.91421356)))
    outline.curve(
      to: transform(point: CGPoint(x: 18.5, y: 8.32842712)),
      controlPoint1: transform(point: CGPoint(x: 18.2892863, y: 7.28928632)),
      controlPoint2: transform(point: CGPoint(x: 18.5, y: 7.79799415)))
    outline.line(to: transform(point: CGPoint(x: 18.5, y: 20.5)))
    outline.curve(
      to: transform(point: CGPoint(x: 17.5, y: 21.5)),
      controlPoint1: transform(point: CGPoint(x: 18.5, y: 21.0522847)),
      controlPoint2: transform(point: CGPoint(x: 18.0522847, y: 21.5)))
    outline.line(to: transform(point: CGPoint(x: 5.5, y: 21.5)))
    outline.curve(
      to: transform(point: CGPoint(x: 4.5, y: 20.5)),
      controlPoint1: transform(point: CGPoint(x: 4.94771525, y: 21.5)),
      controlPoint2: transform(point: CGPoint(x: 4.5, y: 21.0522847)))
    outline.line(to: transform(point: CGPoint(x: 4.5, y: 3.5)))
    outline.curve(
      to: transform(point: CGPoint(x: 5.5, y: 2.5)),
      controlPoint1: transform(point: CGPoint(x: 4.5, y: 2.94771525)),
      controlPoint2: transform(point: CGPoint(x: 4.94771525, y: 2.5)))
    outline.close()
    outlineFill.setFill()
    outlineStroke.setStroke()
    outline.fill()
    outline.lineWidth = 1 * scale
    outline.lineCapStyle = .butt
    outline.stroke()
    let highlight = NSBezierPath()
    highlight.move(to: transform(point: CGPoint(x: 5.5, y: 20.5)))
    highlight.line(to: transform(point: CGPoint(x: 17.5, y: 20.5)))
    #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).setFill()
    #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2).setStroke()
    highlight.fill()
    highlight.lineWidth = 1 * scale
    highlight.lineCapStyle = .square
    highlight.stroke()
    let lonaLogo = NSBezierPath()
    lonaLogo.move(to: transform(point: CGPoint(x: 14.5065009, y: 14.1242399)))
    lonaLogo.line(to: transform(point: CGPoint(x: 14.1797327, y: 14.3906372)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.63783366, y: 12.3261922)),
      controlPoint1: transform(point: CGPoint(x: 13.00906058, y: 13.4397245)),
      controlPoint2: transform(point: CGPoint(x: 11.6893236, y: 12.3705814)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.33206926, y: 12.3261922)),
      controlPoint1: transform(point: CGPoint(x: 11.54551662, y: 12.2466063)),
      controlPoint2: transform(point: CGPoint(x: 11.43182959, y: 12.2466063)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 6.98895854, y: 15.8799266)),
      controlPoint1: transform(point: CGPoint(x: 11.23230893, y: 12.4057782)),
      controlPoint2: transform(point: CGPoint(x: 7.08359279, y: 15.802937)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 6.98895854, y: 16.2380104)),
      controlPoint1: transform(point: CGPoint(x: 6.89432428, y: 15.9569163)),
      controlPoint2: transform(point: CGPoint(x: 6.89432428, y: 16.1610393)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.33206926, y: 19.7818791)),
      controlPoint1: transform(point: CGPoint(x: 7.08359279, y: 16.3149815)),
      controlPoint2: transform(point: CGPoint(x: 11.21806226, y: 19.6925069)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.65526309, y: 19.7818791)),
      controlPoint1: transform(point: CGPoint(x: 11.44607625, y: 19.8712514)),
      controlPoint2: transform(point: CGPoint(x: 11.53787404, y: 19.8712514)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 15.9767512, y: 16.2457257)),
      controlPoint1: transform(point: CGPoint(x: 11.77265213, y: 19.6925069)),
      controlPoint2: transform(point: CGPoint(x: 15.899299, y: 16.3129816)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 15.9767512, y: 15.8598196)),
      controlPoint1: transform(point: CGPoint(x: 16.0542034, y: 16.1784699)),
      controlPoint2: transform(point: CGPoint(x: 16.0542034, y: 15.9401624)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 15.9727149, y: 15.8559761)),
      controlPoint1: transform(point: CGPoint(x: 15.9758983, y: 15.8589349)),
      controlPoint2: transform(point: CGPoint(x: 15.9745492, y: 15.8576508)))
    lonaLogo.line(to: transform(point: CGPoint(x: 16.2928292, y: 15.5906094)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 16.2848495, y: 16.5266374)),
      controlPoint1: transform(point: CGPoint(x: 16.5716917, y: 15.8185733)),
      controlPoint2: transform(point: CGPoint(x: 16.5690318, y: 16.2828573)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.87764483, y: 20.1435633)),
      controlPoint1: transform(point: CGPoint(x: 15.9979821, y: 16.7727208)),
      controlPoint2: transform(point: CGPoint(x: 12.1344828, y: 19.936458)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.09625397, y: 20.1435633)),
      controlPoint1: transform(point: CGPoint(x: 11.62080686, y: 20.3506685)),
      controlPoint2: transform(point: CGPoint(x: 11.33353114, y: 20.3506685)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 6.69296924, y: 16.5266374)),
      controlPoint1: transform(point: CGPoint(x: 10.8589768, y: 19.936458)),
      controlPoint2: transform(point: CGPoint(x: 6.93729095, y: 16.7342085)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 6.69296924, y: 15.5842114)),
      controlPoint1: transform(point: CGPoint(x: 6.44864752, y: 16.3190663)),
      controlPoint2: transform(point: CGPoint(x: 6.44864752, y: 15.7819477)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.09625397, y: 11.97656159)),
      controlPoint1: transform(point: CGPoint(x: 6.93729095, y: 15.3864751)),
      controlPoint2: transform(point: CGPoint(x: 10.88664404, y: 12.1524186)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.90014362, y: 11.97656159)),
      controlPoint1: transform(point: CGPoint(x: 11.30586389, y: 11.80070462)),
      controlPoint2: transform(point: CGPoint(x: 11.58117269, y: 11.71769622)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 14.5065009, y: 14.1242399)),
      controlPoint1: transform(point: CGPoint(x: 12.08068525, y: 12.1230827)),
      controlPoint2: transform(point: CGPoint(x: 13.36967557, y: 13.187257)))
    lonaLogo.close()
    lonaLogo.move(to: transform(point: CGPoint(x: 7.60331943, y: 15.8598698)))
    lonaLogo.line(to: transform(point: CGPoint(x: 7.9310631, y: 15.5918158)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.32234131, y: 18.3584362)),
      controlPoint1: transform(point: CGPoint(x: 9.18565186, y: 16.616361)),
      controlPoint2: transform(point: CGPoint(x: 11.24239923, y: 18.2957681)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.64553514, y: 18.3584362)),
      controlPoint1: transform(point: CGPoint(x: 11.4363483, y: 18.4478084)),
      controlPoint2: transform(point: CGPoint(x: 11.52814609, y: 18.4478084)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 15.9670233, y: 14.8222828)),
      controlPoint1: transform(point: CGPoint(x: 11.76292418, y: 18.2690639)),
      controlPoint2: transform(point: CGPoint(x: 15.8895711, y: 14.8895387)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 15.9670233, y: 14.4363767)),
      controlPoint1: transform(point: CGPoint(x: 16.0444755, y: 14.755027)),
      controlPoint2: transform(point: CGPoint(x: 16.0444755, y: 14.5167195)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.62810571, y: 10.90274933)),
      controlPoint1: transform(point: CGPoint(x: 15.8895711, y: 14.3560339)),
      controlPoint2: transform(point: CGPoint(x: 11.72042274, y: 10.9823353)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.32234131, y: 10.90274933)),
      controlPoint1: transform(point: CGPoint(x: 11.53578867, y: 10.82316335)),
      controlPoint2: transform(point: CGPoint(x: 11.42210164, y: 10.82316335)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 6.97923059, y: 14.4564837)),
      controlPoint1: transform(point: CGPoint(x: 11.22258098, y: 10.9823353)),
      controlPoint2: transform(point: CGPoint(x: 7.07386485, y: 14.379494)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 6.97923059, y: 14.8145675)),
      controlPoint1: transform(point: CGPoint(x: 6.88459633, y: 14.5334734)),
      controlPoint2: transform(point: CGPoint(x: 6.88459633, y: 14.7375963)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 7.01069414, y: 14.8402305)),
      controlPoint1: transform(point: CGPoint(x: 6.98311107, y: 14.8177237)),
      controlPoint2: transform(point: CGPoint(x: 6.99378416, y: 14.8264294)))
    lonaLogo.line(to: transform(point: CGPoint(x: 6.6886341, y: 15.1077588)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 6.68324129, y: 15.1031945)),
      controlPoint1: transform(point: CGPoint(x: 6.68667351, y: 15.1061046)),
      controlPoint2: transform(point: CGPoint(x: 6.68487517, y: 15.1045826)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 6.68324129, y: 14.1607685)),
      controlPoint1: transform(point: CGPoint(x: 6.43891957, y: 14.8956233)),
      controlPoint2: transform(point: CGPoint(x: 6.43891957, y: 14.3585048)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.08652602, y: 10.55311867)),
      controlPoint1: transform(point: CGPoint(x: 6.927563, y: 13.9630322)),
      controlPoint2: transform(point: CGPoint(x: 10.87691609, y: 10.72897563)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.89041568, y: 10.55311867)),
      controlPoint1: transform(point: CGPoint(x: 11.29613594, y: 10.3772617)),
      controlPoint2: transform(point: CGPoint(x: 11.57144474, y: 10.2942533)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 16.2751215, y: 14.1607685)),
      controlPoint1: transform(point: CGPoint(x: 12.20938661, y: 10.81198403)),
      controlPoint2: transform(point: CGPoint(x: 15.9882542, y: 13.9351997)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 16.2751215, y: 15.1031945)),
      controlPoint1: transform(point: CGPoint(x: 16.5619889, y: 14.3863373)),
      controlPoint2: transform(point: CGPoint(x: 16.5619889, y: 14.857111)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.86791688, y: 18.7201203)),
      controlPoint1: transform(point: CGPoint(x: 15.9882542, y: 15.3492779)),
      controlPoint2: transform(point: CGPoint(x: 12.12475485, y: 18.5130151)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.08652602, y: 18.7201203)),
      controlPoint1: transform(point: CGPoint(x: 11.61107891, y: 18.9272256)),
      controlPoint2: transform(point: CGPoint(x: 11.32380319, y: 18.9272256)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 7.60331943, y: 15.8598698)),
      controlPoint1: transform(point: CGPoint(x: 10.91621391, y: 18.571465)),
      controlPoint2: transform(point: CGPoint(x: 8.84768007, y: 16.8796996)))
    lonaLogo.close()
    lonaLogo.move(to: transform(point: CGPoint(x: 8.46293103, y: 15.1754235)))
    lonaLogo.line(to: transform(point: CGPoint(x: 8.78767052, y: 14.9026698)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.32234131, y: 16.9697983)),
      controlPoint1: transform(point: CGPoint(x: 9.95172361, y: 15.8531363)),
      controlPoint2: transform(point: CGPoint(x: 11.25892983, y: 16.9200889)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.64553514, y: 16.9697983)),
      controlPoint1: transform(point: CGPoint(x: 11.4363483, y: 17.0591706)),
      controlPoint2: transform(point: CGPoint(x: 11.52814609, y: 17.0591706)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 15.0120287, y: 14.2180775)),
      controlPoint1: transform(point: CGPoint(x: 11.72749735, y: 16.9073977)),
      controlPoint2: transform(point: CGPoint(x: 13.76396178, y: 15.2410565)))
    lonaLogo.line(to: transform(point: CGPoint(x: 15.3384969, y: 14.4885099)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.86791688, y: 17.3314825)),
      controlPoint1: transform(point: CGPoint(x: 14.0941506, y: 15.5114249)),
      controlPoint2: transform(point: CGPoint(x: 12.05224053, y: 17.1828503)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.08652602, y: 17.3314825)),
      controlPoint1: transform(point: CGPoint(x: 11.61107891, y: 17.5385877)),
      controlPoint2: transform(point: CGPoint(x: 11.32380319, y: 17.5385877)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 8.46293103, y: 15.1754235)),
      controlPoint1: transform(point: CGPoint(x: 10.95166425, y: 17.2137696)),
      controlPoint2: transform(point: CGPoint(x: 9.62656512, y: 16.1284842)))
    lonaLogo.close()
    lonaLogo.move(to: transform(point: CGPoint(x: 16.3000621, y: 13.691914)))
    lonaLogo.line(to: transform(point: CGPoint(x: 15.9766188, y: 13.4240073)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 15.9670233, y: 13.0477388)),
      controlPoint1: transform(point: CGPoint(x: 16.0443312, y: 13.3461129)),
      controlPoint2: transform(point: CGPoint(x: 16.0443312, y: 13.1136062)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.62810571, y: 9.51411145)),
      controlPoint1: transform(point: CGPoint(x: 15.8897153, y: 12.9818715)),
      controlPoint2: transform(point: CGPoint(x: 11.72042274, y: 9.59369742)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.32234131, y: 9.51411145)),
      controlPoint1: transform(point: CGPoint(x: 11.53578867, y: 9.43452547)),
      controlPoint2: transform(point: CGPoint(x: 11.42210164, y: 9.43452547)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 6.97923059, y: 13.0678458)),
      controlPoint1: transform(point: CGPoint(x: 11.22258098, y: 9.59369742)),
      controlPoint2: transform(point: CGPoint(x: 7.07386485, y: 12.9908562)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 6.97923059, y: 13.4259296)),
      controlPoint1: transform(point: CGPoint(x: 6.88459633, y: 13.1448355)),
      controlPoint2: transform(point: CGPoint(x: 6.88459633, y: 13.3489585)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 7.00322205, y: 13.4454947)),
      controlPoint1: transform(point: CGPoint(x: 6.98250436, y: 13.4285923)),
      controlPoint2: transform(point: CGPoint(x: 6.99061274, y: 13.4352049)))
    lonaLogo.line(to: transform(point: CGPoint(x: 6.68324129, y: 13.7145566)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 6.67944884, y: 13.7112911)),
      controlPoint1: transform(point: CGPoint(x: 6.68197053, y: 13.713477)),
      controlPoint2: transform(point: CGPoint(x: 6.68070638, y: 13.7123885)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 6.68324129, y: 12.7721306)),
      controlPoint1: transform(point: CGPoint(x: 6.43892618, y: 13.5014073)),
      controlPoint2: transform(point: CGPoint(x: 6.44019033, y: 12.9688384)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.08652602, y: 9.16448079)),
      controlPoint1: transform(point: CGPoint(x: 6.927563, y: 12.5743943)),
      controlPoint2: transform(point: CGPoint(x: 10.87691609, y: 9.34033775)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 11.89041568, y: 9.16448079)),
      controlPoint1: transform(point: CGPoint(x: 11.29613594, y: 8.98862382)),
      controlPoint2: transform(point: CGPoint(x: 11.57144474, y: 8.90561542)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 16.2751215, y: 12.7721306)),
      controlPoint1: transform(point: CGPoint(x: 12.20938661, y: 9.42334616)),
      controlPoint2: transform(point: CGPoint(x: 15.9882542, y: 12.5465618)))
    lonaLogo.curve(
      to: transform(point: CGPoint(x: 16.3000621, y: 13.691914)),
      controlPoint1: transform(point: CGPoint(x: 16.5534194, y: 12.9909611)),
      controlPoint2: transform(point: CGPoint(x: 16.5617329, y: 13.4405653)))
    lonaLogo.close()
    lonaLogoFill.setFill()
    lonaLogo.fill()
    let fold = NSBezierPath()
    fold.move(to: transform(point: CGPoint(x: 17.0857864, y: 8.5)))
    fold.line(to: transform(point: CGPoint(x: 13.5, y: 8.5)))
    fold.curve(
      to: transform(point: CGPoint(x: 12.5, y: 7.5)),
      controlPoint1: transform(point: CGPoint(x: 12.9477153, y: 8.5)),
      controlPoint2: transform(point: CGPoint(x: 12.5, y: 8.05228475)))
    fold.line(to: transform(point: CGPoint(x: 12.5, y: 3.91421356)))
    fold.curve(
      to: transform(point: CGPoint(x: 13.5, y: 2.91421356)),
      controlPoint1: transform(point: CGPoint(x: 12.5, y: 3.36192881)),
      controlPoint2: transform(point: CGPoint(x: 12.9477153, y: 2.91421356)))
    fold.curve(
      to: transform(point: CGPoint(x: 14.2071068, y: 3.20710678)),
      controlPoint1: transform(point: CGPoint(x: 13.7652165, y: 2.91421356)),
      controlPoint2: transform(point: CGPoint(x: 14.0195704, y: 3.0195704)))
    fold.line(to: transform(point: CGPoint(x: 17.7928932, y: 6.79289322)))
    fold.curve(
      to: transform(point: CGPoint(x: 17.7928932, y: 8.20710678)),
      controlPoint1: transform(point: CGPoint(x: 18.1834175, y: 7.18341751)),
      controlPoint2: transform(point: CGPoint(x: 18.1834175, y: 7.81658249)))
    fold.curve(
      to: transform(point: CGPoint(x: 17.0857864, y: 8.5)),
      controlPoint1: transform(point: CGPoint(x: 17.6053568, y: 8.39464316)),
      controlPoint2: transform(point: CGPoint(x: 17.3510029, y: 8.5)))
    fold.close()
    foldFill.setFill()
    foldStroke.setStroke()
    fold.fill()
    fold.lineWidth = 1 * scale
    fold.lineCapStyle = .butt
    fold.stroke()
  }
}


// MARK: - LonaFileIcon

public class LonaFileIcon: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(selected: Bool) {
    self.init(Parameters(selected: selected))
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

  private var vectorGraphicView = IconLonaFileVector()

  private func setUpViews() {
    boxType = .custom
    borderType = .noBorder
    contentViewMargins = .zero
    vectorGraphicView.boxType = .custom
    vectorGraphicView.borderType = .noBorder
    vectorGraphicView.contentViewMargins = .zero

    addSubview(vectorGraphicView)
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    vectorGraphicView.translatesAutoresizingMaskIntoConstraints = false

    let vectorGraphicViewHeightAnchorParentConstraint = vectorGraphicView
      .heightAnchor
      .constraint(lessThanOrEqualTo: heightAnchor)
    let vectorGraphicViewLeadingAnchorConstraint = vectorGraphicView.leadingAnchor.constraint(equalTo: leadingAnchor)
    let vectorGraphicViewCenterYAnchorConstraint = vectorGraphicView.centerYAnchor.constraint(equalTo: centerYAnchor)
    let vectorGraphicViewHeightAnchorConstraint = vectorGraphicView.heightAnchor.constraint(equalToConstant: 24)
    let vectorGraphicViewWidthAnchorConstraint = vectorGraphicView.widthAnchor.constraint(equalToConstant: 24)

    vectorGraphicViewHeightAnchorParentConstraint.priority = NSLayoutConstraint.Priority.defaultLow

    NSLayoutConstraint.activate([
      vectorGraphicViewHeightAnchorParentConstraint,
      vectorGraphicViewLeadingAnchorConstraint,
      vectorGraphicViewCenterYAnchorConstraint,
      vectorGraphicViewHeightAnchorConstraint,
      vectorGraphicViewWidthAnchorConstraint
    ])
  }

  private func update() {
    vectorGraphicView.foldFill = #colorLiteral(red: 0.933333333333, green: 0.933333333333, blue: 0.933333333333, alpha: 1)
    vectorGraphicView.foldStroke = #colorLiteral(red: 0.549019607843, green: 0.549019607843, blue: 0.549019607843, alpha: 1)
    vectorGraphicView.lonaLogoFill = #colorLiteral(red: 0.592156862745, green: 0.592156862745, blue: 0.592156862745, alpha: 1)
    vectorGraphicView.outlineFill = #colorLiteral(red: 0.847058823529, green: 0.847058823529, blue: 0.847058823529, alpha: 1)
    vectorGraphicView.outlineStroke = #colorLiteral(red: 0.549019607843, green: 0.549019607843, blue: 0.549019607843, alpha: 1)
    if selected {
      vectorGraphicView.outlineStroke = Colors.selectedIconStroke
      vectorGraphicView.outlineFill = Colors.selectedIcon
      vectorGraphicView.foldStroke = Colors.selectedIconStroke
      vectorGraphicView.foldFill = Colors.selectedIcon
      vectorGraphicView.lonaLogoFill = Colors.selectedIconStroke
    }
    vectorGraphicView.needsDisplay = true
  }
}

// MARK: - Parameters

extension LonaFileIcon {
  public struct Parameters: Equatable {
    public var selected: Bool

    public init(selected: Bool) {
      self.selected = selected
    }

    public init() {
      self.init(selected: false)
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.selected == rhs.selected
    }
  }
}

// MARK: - Model

extension LonaFileIcon {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "LonaFileIcon"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(selected: Bool) {
      self.init(Parameters(selected: selected))
    }

    public init() {
      self.init(selected: false)
    }
  }
}
