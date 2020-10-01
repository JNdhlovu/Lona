//
//  CSLayer.swift
//  ComponentStudio
//
//  Created by devin_abbott on 6/26/17.
//  Copyright © 2017 Devin Abbott. All rights reserved.
//

import Foundation
import Lottie

// TODO Move elsewhere
extension Dictionary {
    init(_ pairs: [Element]) {
        self.init()
        for (k, v) in pairs {
            self[k] = v
        }
    }

    func map<OutValue>(_ transform: (Value) throws -> OutValue) rethrows -> [Key: OutValue] {
        return [Key: OutValue](try map { (k, v) in (k, try transform(v)) })
    }
}

enum ResizeMode: String {
    case contain, cover, stretch

    func lotViewContentMode() -> LOTViewContentMode {
        switch self {
        case .cover: return .scaleAspectFill
        case .contain: return .scaleAspectFit
        case .stretch: return .scaleToFill
        }
    }

    func resizingMode() -> CGSize.ResizingMode {
        switch self {
        case .cover: return .scaleAspectFill
        case .contain: return .scaleAspectFit
        case .stretch: return .scaleToFill
        }
    }
}

enum PositionType: String {
    case relative, absolute
}

extension CSData {
    var int: Int {
        return Int(numberValue)
    }
}

class CSLayer: CSDataDeserializable, CSDataSerializable, DataNode, NSCopying {
    enum BorderStyle: String {
        case solid, dotted, dashed

        init(index: Int) {
            switch index {
            case 0:
                self = .solid
            case 1:
                self = .dotted
            case 2:
                self = .dashed
            default:
                self = .solid
            }
        }

        var index: Int {
            switch self {
            case .solid:
                return 0
            case .dotted:
                return 1
            case .dashed:
                return 2
            }
        }

        static let displayNames = ["solid", "dotted", "dashed"]
    }

    enum BuiltInLayerType: String {
        case view = "View"
        case text = "Text"
        case image = "Image"
        case vectorGraphic = "VectorGraphic"
        case animation = "Animation"
        case children = "Children"
    }

    enum LayerType: Equatable {
        case builtIn(BuiltInLayerType)
        case custom(String)

        init(from string: String) {
            // TODO: This case is for backwards compat, before the "Lona:" prefix. Remove.
            if let layerType = BuiltInLayerType(rawValue: string) {
                self = .builtIn(layerType)
            } else if string.starts(with: "Lona:") {
                let index = string.index(after: string.index(of: ":")!)
                let suffix = String(string[index...])
                self = .builtIn(CSLayer.BuiltInLayerType(rawValue: suffix)!)
            } else {
                self = .custom(string)
            }
        }

        init(_ data: CSData) {
            self.init(from: data.stringValue)
        }

        var string: String {
            switch self {
            case .builtIn(let builtInLayerType):
                return "Lona:" + builtInLayerType.rawValue
            case .custom(let layerType):
                return layerType
            }
        }

        var displayName: String {
            switch self {
            case .builtIn(let builtInLayerType):
                return builtInLayerType.rawValue
            case .custom(let layerType):
                return layerType
            }
        }

        func toData() -> CSData {
            return string.toData()
        }

        static let view = LayerType.builtIn(.view)
        static let text = LayerType.builtIn(.text)
        static let image = LayerType.builtIn(.image)
        static let vectorGraphic = LayerType.builtIn(.vectorGraphic)
        static let animation = LayerType.builtIn(.animation)
        static let children = LayerType.builtIn(.children)

        static func == (lhs: LayerType, rhs: LayerType) -> Bool {
            switch (lhs, rhs) {
            case (.builtIn(let l), .builtIn(let r)):
                return l == r
            case (.custom(let l), .custom(let r)):
                return l == r
            default:
                return false
            }
        }
    }

    var name: String = "Layer"
    var type: LayerType = .view
    var children: [CSLayer] = []
    var parent: CSLayer?
    var parameters: [String: CSData] = [:]
    var metadata: [String: CSData] = [:]

    var rootAncestor: CSLayer {
        var root = self

        while let parent = root.parent {
            root = parent
        }

        return root
    }

    var descendantLayers: [CSLayer] {
        var result = [CSLayer]()

        func apply(layer: CSLayer) {
            result.append(layer)

            layer.children.forEach({ apply(layer: $0) })
        }

        apply(layer: self)

        return result
    }

    func accessibilityElementPaths(includingSubcomponentLayers: Bool) -> [[String]] {
        func inner(prefix: [String], layer: CSLayer) -> [[String]] {
            if includingSubcomponentLayers, let componentLayer = layer as? CSComponentLayer {
                let innerResults = componentLayer.component.rootLayer
                    .accessibilityElementPaths(includingSubcomponentLayers: includingSubcomponentLayers)
                    .map { prefix + [layer.name] + $0 }
                return innerResults
            }

            switch layer.accessibility {
            case .auto:
                return Array(layer.children.map { inner(prefix: prefix, layer: $0) }.joined())
            case .none:
                return []
            case .element:
                return [prefix + [layer.name]]
            case .container(let elements):
                let descendants = descendantLayers
                return Array(elements
                    .map { element in descendants.first(where: { element == $0.name }) }
                    .compactMap { $0 }
                    .map { inner(prefix: prefix, layer: $0) }
                    .joined())
            }
        }

        return inner(prefix: [], layer: self)
    }

    func accessibilityElementHierarchy() -> [CSLayer] {
        switch accessibility {
        case .auto:
            return Array(children.map { $0.accessibilityElementHierarchy() }.joined())
        case .none:
            return []
        case .element:
            return [self]
        case .container(let elements):
            let descendants = descendantLayers
            let layers = elements.map { name in descendants.first(where: { layer in layer.name == name }) }.compactMap { $0 }
            return Array(layers.map { $0.accessibilityElementHierarchy() }.joined())
        }
    }

    func descendantLayerNames(includingSelf: Bool) -> [String] {
        let names = descendantLayers.map({ $0.name })

        if includingSelf { return names }

        return names.filter({ $0 != self.name }).sorted()
    }

    func removeParameter(_ key: String) {
        parameters.removeValue(forKey: key)
    }

    var numberOfLines: Int? {
        get { return parameters["numberOfLines"]?.int }
        set { parameters["numberOfLines"] = newValue != nil ? Double(newValue!).toData() : nil }
    }
    var visible: Bool {
        get { return parameters["visible"]?.boolValue ?? true }
        set { parameters["visible"] = newValue.toData() }
    }
    var widthSizingRule: DimensionSizingRule {
        get {
            var value: DimensionSizingRule

            if self.parent?.flexDirection == "row" {
                if self.flex == 1 {
                    value = .Expand
                } else if self.width != nil {
                    value = .Fixed
                } else {
                    value = .Shrink
                }
            // This case also catches the root level which has no parent.
            // The root level is assumed to be in a "column" parent.
            } else {
                if self.alignSelf == "stretch" {
                    value = .Expand
                } else if self.width == nil {
                    value = .Shrink
                } else {
                    value = .Fixed
                }
            }

            return value
        }
        set {
            if self.parent?.flexDirection == "row" {
                switch newValue {
                case .Expand:
                    self.flex = 1
                    removeParameter("width")
                case .Shrink:
                    removeParameter("flex")
                    removeParameter("width")
                case .Fixed:
                    removeParameter("flex")
                    self.width = self.width ?? 0
                }
            } else {
                switch newValue {
                case .Expand:
                    self.alignSelf = "stretch"
                    removeParameter("width")
                case .Shrink:
                    removeParameter("alignSelf")
                    removeParameter("width")
                case .Fixed:
                    removeParameter("alignSelf")
                    self.width = self.width ?? 0
                }
            }
        }
    }

    var heightSizingRule: DimensionSizingRule {
        get {
            var value: DimensionSizingRule

            if self.parent?.flexDirection == "row" {
                if self.alignSelf == "stretch" {
                    value = .Expand
                } else if self.height == nil {
                    value = .Shrink
                } else {
                    value = .Fixed
                }
            // This case also catches the root level which has no parent.
            // The root level is assumed to be in a "column" parent.
            } else {
                if self.flex == 1 {
                    value = .Expand
                } else if self.height != nil {
                    value = .Fixed
                } else {
                    value = .Shrink
                }
            }

            return value
        }
        set {
            if self.parent?.flexDirection == "row" {
                switch newValue {
                case .Expand:
                    self.alignSelf = "stretch"
                    removeParameter("height")
                case .Shrink:
                    removeParameter("alignSelf")
                    removeParameter("height")
                case .Fixed:
                    removeParameter("alignSelf")
                    self.height = self.height ?? 0
                }
            } else {
                switch newValue {
                case .Expand:
                    self.flex = 1
                    removeParameter("height")
                case .Shrink:
                    removeParameter("flex")
                    removeParameter("height")
                case .Fixed:
                    removeParameter("flex")
                    self.height = self.height ?? 0
                }
            }
        }
    }

    var resizeMode: ResizeMode? {
        get { return ResizeMode(rawValue: parameters["resizeMode"]?.string ?? "") }
        set { parameters["resizeMode"] = newValue?.rawValue.toData() }
    }

    var image: String? {
        get { return parameters["image"]?.string }
        set { parameters["image"] = newValue?.toData() }
    }

    var animation: String? {
        get { return parameters["animation"]?.string }
        set { parameters["animation"] = newValue?.toData() }
    }
    var animationSpeed: Double? {
        get { return parameters["animationSpeed"]?.number }
        set { parameters["animationSpeed"] = newValue?.toData() }
    }
    var position: PositionType? {
        get { return PositionType(rawValue: parameters["position"]?.string ?? "") }
        set { parameters["position"] = newValue?.rawValue.toData() }
    }
    var top: Double? {
        get { return parameters["top"]?.number }
        set { parameters["top"] = newValue?.toData() }
    }
    var right: Double? {
        get { return parameters["right"]?.number }
        set { parameters["right"] = newValue?.toData() }
    }
    var bottom: Double? {
        get { return parameters["bottom"]?.number }
        set { parameters["bottom"] = newValue?.toData() }
    }
    var left: Double? {
        get { return parameters["left"]?.number }
        set { parameters["left"] = newValue?.toData() }
    }
    var flex: Double? {
        get { return parameters["flex"]?.number }
        set { parameters["flex"] = newValue?.toData() }
    }
    var width: Double? {
        get { return parameters["width"]?.number }
        set { parameters["width"] = newValue?.toData() }
    }
    var height: Double? {
        get { return parameters["height"]?.number }
        set { parameters["height"] = newValue?.toData() }
    }
    var paddingLeft: Double? {
        get { return parameters["paddingLeft"]?.number }
        set { parameters["paddingLeft"] = newValue?.toData() }
    }
    var paddingTop: Double? {
        get { return parameters["paddingTop"]?.number }
        set { parameters["paddingTop"] = newValue?.toData() }
    }
    var paddingRight: Double? {
        get { return parameters["paddingRight"]?.number }
        set { parameters["paddingRight"] = newValue?.toData() }
    }
    var paddingBottom: Double? {
        get { return parameters["paddingBottom"]?.number }
        set { parameters["paddingBottom"] = newValue?.toData() }
    }
    var marginLeft: Double? {
        get { return parameters["marginLeft"]?.number }
        set { parameters["marginLeft"] = newValue?.toData() }
    }
    var marginTop: Double? {
        get { return parameters["marginTop"]?.number }
        set { parameters["marginTop"] = newValue?.toData() }
    }
    var marginRight: Double? {
        get { return parameters["marginRight"]?.number }
        set { parameters["marginRight"] = newValue?.toData() }
    }
    var marginBottom: Double? {
        get { return parameters["marginBottom"]?.number }
        set { parameters["marginBottom"] = newValue?.toData() }
    }
    var aspectRatio: Double? {
        get { return parameters["aspectRatio"]?.number }
        set { parameters["aspectRatio"] = newValue?.toData() }
    }
    var opacity: Double? {
        get { return parameters["opacity"]?.number }
        set { parameters["opacity"] = newValue?.toData() }
    }

    // Border
    var borderRadius: Double? {
        get { return parameters["borderRadius"]?.number }
        set { parameters["borderRadius"] = newValue?.toData() }
    }
    var borderColor: String? {
        get { return parameters["borderColor"]?.string }
        set { parameters["borderColor"] = newValue?.toData() }
    }
    var borderWidth: Double? {
        get { return parameters["borderWidth"]?.number }
        set { parameters["borderWidth"] = newValue?.toData() }
    }
    var borderStyle: BorderStyle {
        get { return BorderStyle(rawValue: parameters["borderStyle"]?.string ?? "solid") ?? .solid }
        set { parameters["borderStyle"] = newValue.rawValue.toData() }
    }

    // Shadow
    var shadow: String? {
        get { return parameters["shadow"]?.string }
        set { parameters["shadow"] = newValue?.toData() }
    }
    var backgroundColor: String? {
        get { return parameters["backgroundColor"]?.string }
        set { parameters["backgroundColor"] = newValue?.toData() }
    }
    var backgroundGradient: String? {
        get { return parameters["backgroundGradient"]?.string }
        set { parameters["backgroundGradient"] = newValue?.toData() }
    }
    var text: String? {
        get { return parameters["text"]?.string }
        set { parameters["text"] = newValue?.toData() }
    }
    var font: String? {
        get { return parameters["textStyle"]?.string ?? parameters["font"]?.string }
        set { parameters["font"] = newValue?.toData() }
    }
    var textStyle: TextStyle?
    var textAlign: String? {
        get { return parameters["textAlign"]?.string }
        set { parameters["textAlign"] = newValue?.toData() }
    }
    var flexDirection: String? {
        get { return parameters["flexDirection"]?.string }

        // We need to rewrite sizingRules for children
        set {
            let widthSizingRules = children.map({ $0.widthSizingRule })
            let heightSizingRules = children.map({ $0.heightSizingRule })
            let horizontalAlignment = self.horizontalAlignment
            let verticalAlignment = self.verticalAlignment

            // Actually set the value - this will change what children sizingRule getters return
            parameters["flexDirection"] = newValue?.toData()

            for (i, value) in widthSizingRules.enumerated() {
                children[i].widthSizingRule = value
            }
            for (i, value) in heightSizingRules.enumerated() {
                children[i].heightSizingRule = value
            }
            self.horizontalAlignment = horizontalAlignment
            self.verticalAlignment = verticalAlignment
        }
    }
    var alignItems: String? {
        get { return parameters["alignItems"]?.string }
        set { parameters["alignItems"] = newValue?.toData() }
    }
    var justifyContent: String? {
        get { return parameters["justifyContent"]?.string }
        set { parameters["justifyContent"] = newValue?.toData() }
    }
    var alignSelf: String? {
        get { return parameters["alignSelf"]?.string }
        set { parameters["alignSelf"] = newValue?.toData() }
    }

    var horizontalAlignment: String {
        get {
            if flexDirection == "row" {
                return justifyContent ?? "flex-start"
            } else {
                return alignItems ?? "flex-start"
            }
        }
        set {
            if flexDirection == "row" {
                justifyContent = newValue
            } else {
                alignItems = newValue
            }
        }
    }

    var verticalAlignment: String {
        get {
            if flexDirection == "row" {
                return alignItems ?? "flex-start"
            } else {
                return justifyContent ?? "flex-start"
            }
        }
        set {
            if flexDirection == "row" {
                alignItems = newValue
            } else {
                justifyContent = newValue
            }
        }
    }

    private let accessibilityKeys = [
        "accessibilityType",
        "accessibilityLabel",
        "accessibilityHint",
        "accessibilityValue",
        "accessibilityRole",
        "accessibilityStates",
        "accessibilityElements"
    ]

    var accessibility: AccessibilityType {
        get { return AccessibilityType(CSData.Object(parameters)) }
        set {
            accessibilityKeys.forEach { parameters.removeValue(forKey: $0) }
            parameters.merge(with: newValue.toData().objectValue)
        }
    }

    static func deserialize(_ json: CSData) -> CSLayer? {
        let type = LayerType(json.get(key: "type"))

        if case LayerType.custom = type {
            let layer = CSComponentLayer(json)

            if layer.failedToLoad {
                layer.name = "Failed to Load"
            }

            return layer
        } else if case LayerType.builtIn(.children) = type {
            return CSParameterLayer(json)
        }

        return CSLayer(json)
    }

    init() {}

    required init(_ json: CSData) {
        name = json.get(key: "id").string ?? json.get(key: "name").stringValue
        type = LayerType(json.get(key: "type"))
        parameters = decode(parameters: json.get(key: "params").object ?? json.get(key: "parameters").objectValue)
        metadata = json.get(key: "metadata").objectValue
        children = json.get(key: "children").arrayValue.map({ CSLayer.deserialize($0) }).compactMap({ $0 })
        children.forEach({ $0.parent = self })
    }

    init(name: String, type: LayerType, parameters: [String: CSData] = [:], children: [CSLayer] = []) {
        self.name = name
        self.type = type
        self.parameters = parameters
        self.children = children
        children.forEach({ $0.parent = self })

        if let rule = parameters["widthSizingRule"] {
            self.widthSizingRule = DimensionSizingRule.fromString(rawValue: rule.stringValue)
            self.parameters.removeValue(forKey: "widthSizingRule")
        }

        if let rule = parameters["heightSizingRule"] {
            self.heightSizingRule = DimensionSizingRule.fromString(rawValue: rule.stringValue)
            self.parameters.removeValue(forKey: "heightSizingRule")
        }
    }

    static let defaultParameterValue: [String: CSData] = [
        "alignItems": CSData.String("flex-start"),
        "aspectRatio": CSData.Number(-1),
        "borderRadius": CSData.Number(0),
        "borderWidth": CSData.Number(0),
        "borderStyle": CSData.String("solid"),
        "flex": CSData.Number(0),
        "flexDirection": CSData.String("column"),
        "justifyContent": CSData.String("flex-start"),
        "marginTop": CSData.Number(0),
        "marginRight": CSData.Number(0),
        "marginBottom": CSData.Number(0),
        "marginLeft": CSData.Number(0),
        "opacity": CSData.Number(1),
        "paddingTop": CSData.Number(0),
        "paddingRight": CSData.Number(0),
        "paddingBottom": CSData.Number(0),
        "paddingLeft": CSData.Number(0),
        "resizeMode": CSData.String("cover"),
        "textAlign": CSData.String("left"),
        "visible": CSData.Bool(true)
    ]

    static let accessibilityRoles = [
        "none",
        "button",
        "link",
        "checkbox",
        "search",
        "image",
        "keyboardkey",
        "text",
        "adjustable",
        "imagebutton",
        "header",
        "summary"
    ]

    func decode(parameters: [String: CSData]) -> [String: CSData] {
        return parameters
    }

    func encode(parameters: [String: CSData]) -> [String: CSData] {
        var parameters = parameters

        for (key, value) in parameters where value == CSData.Null {
            parameters.removeValue(forKey: key)
        }

        for (key, defaultValue) in CSLayer.defaultParameterValue {
            if let value = parameters[key], value == defaultValue {
                parameters.removeValue(forKey: key)
            }
        }

        return parameters
    }

    func toData() -> CSData {
        var data = CSData.Object([
            "id": name.toData(),
            "type": type.toData(),
            "params": CSData.Object(encode(parameters: parameters))
        ])

        if !children.isEmpty {
            data["children"] = children.toData()
        }

        if !metadata.isEmpty {
            data["metadata"] = CSData.Object(metadata)
        }

        return data
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let serialized = toData()
        let copy = CSLayer.deserialize(serialized)!

        copy.parent = self.parent

        return copy as Any
    }

    var label: String { return name }
    func childCount() -> Int { return children.count }
    func child(at index: Int) -> Any { return children[index] }

    @discardableResult func removeFromParent() -> Int {
        if parent == nil { return -1 }

        if let index = parent!.children.firstIndex(where: { $0 === self }) {
            parent!.children.remove(at: index)

            return index
        }

        return -1
    }

    func insertChild(_ child: CSLayer, at index: Int) {
        child.removeFromParent()

        children.insert(child, at: index)
        child.parent = self
    }

    func appendChild(_ child: CSLayer) {
        insertChild(child, at: children.count)
    }

    func visibleChildren(for config: ComponentConfiguration) -> [CSLayer] {
        let dynamicChildren: [CSLayer] = config.get(attribute: "children", for: name).arrayValue.map({ childData in
            let layer = CSLayer.deserialize(childData)
//            layer?.config = config
            return layer
        }).compactMap({ $0 })

        return (children + dynamicChildren).filter({ layer in
            var layerVisible = layer.visible

            if let visible = config.get(attribute: "visible", for: layer.name).bool {
                layerVisible = visible
            }

            return layerVisible
        })
    }

    func value() -> CSValue {
        var valueType = CSLayerType

        let accessibility = self.accessibility

        var data = CSData.Object([
            "name": CSData.String(name),
            "visible": CSData.Bool(visible),

            // Box model
            "height": CSData.Number(height ?? 0),
            "width": CSData.Number(width ?? 0),
            "marginTop": CSData.Number(marginTop ?? 0),
            "marginRight": CSData.Number(marginRight ?? 0),
            "marginBottom": CSData.Number(marginBottom ?? 0),
            "marginLeft": CSData.Number(marginLeft ?? 0),
            "paddingTop": CSData.Number(paddingTop ?? 0),
            "paddingRight": CSData.Number(paddingRight ?? 0),
            "paddingBottom": CSData.Number(paddingBottom ?? 0),
            "paddingLeft": CSData.Number(paddingLeft ?? 0),

            // Content
            "opacity": CSData.Number(opacity ?? 1),
            "backgroundColor": CSData.String(backgroundColor ?? "transparent"),

            // Border
            "borderWidth": CSData.Number(borderWidth ?? 0),
            "borderRadius": CSData.Number(borderRadius ?? 0),
            "borderColor": CSData.String(borderColor ?? "transparent"),
            "borderStyle": CSValue.expand(type: CSBorderStyleType, data: borderStyle.rawValue.toData()),

            // Shadow
            "shadow": CSData.String(shadow ?? ""),

            // Accessibility
            "accessibilityLabel": (accessibility.label ?? "").toData(),
            "accessibilityHint": (accessibility.hint ?? "").toData(),
            "accessibilityValue": (accessibility.value ?? "").toData(),
            "accessibilityElements": accessibility.elements.toData(),

            // Children
            "children": CSData.Array([])
        ])

        switch accessibility.role ?? AccessibilityRole.none {
        case .checkbox:
            data["accessibilityChecked"] = CSData.Bool(false)
        default:
            break
        }

        if type == .view {
            data["pressed"] = CSData.Bool(false)
            data["hovered"] = CSData.Bool(false)
            data["onPress"] = CSData.Null
            data["onAccessibilityActivate"] = CSData.Null
        }

        // Text
        if let value = text {
            data["text"] = CSData.String(value)
            data["textStyle"] = CSData.String(font ?? CSTypography.defaultName)
        }

        // Image
        if type == .image {
            data["image"] = CSData.String(image ?? "")
        }

        // Animation
        if type == .animation,
            let animation = animation,
            let url = URL(string: animation),
            let animationData = AnimationUtils.decode(contentsOf: url) {
            let assetMap = AnimationUtils.assetMapValue(from: animationData)
            data["images"] = assetMap.data
            valueType = valueType.merge(key: "images", type: assetMap.type, access: .write)
        }

        // VectorGraphic
        if type == .vectorGraphic,
            let image = image,
            let url = URL(string: image)?.absoluteURLForWorkspaceURL(),
            let svg = SVG.decodeSync(contentsOf: url) {
            data["vector"] = SVG.paramsData(node: svg)
            valueType = valueType.merge(key: "vector", type: SVG.paramsType(node: svg), access: .write)
        }

        return CSValue(type: valueType, data: data)
    }

    func layerValue() -> CSValue {
        let parametersValue = self.value()

        let type = CSType.dictionary([
            "type": (type: .string, access: .write),
            "parameters": (type: parametersValue.type, access: .write)
        ])

        let data = CSData.Object([
            "type": self.type.toData(),
            "parameters": parametersValue.data
        ])

        return CSValue(type: type, data: data)
    }
}

extension CSLayer: Equatable {
    static func == (lhs: CSLayer, rhs: CSLayer) -> Bool {
        return (lhs.name == rhs.name &&
            lhs.type == rhs.type &&
            lhs.children == rhs.children &&
            lhs.parameters == rhs.parameters &&
            lhs.metadata == rhs.metadata)
    }
}
