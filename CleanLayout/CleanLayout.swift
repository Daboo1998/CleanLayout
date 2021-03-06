//
//  MIT License
//
//  Copyright (c) 2018 Daboo1998
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit

public struct CLSizeConstraint {
    public internal(set) var width: NSLayoutConstraint
    public internal(set) var height: NSLayoutConstraint
    
    public func activate() {
        width.activate()
        height.activate()
    }
    
    public func deactivate() {
        width.deactivate()
        height.deactivate()
    }
}

public struct CLStretchedConstraint {
    public internal(set) var top: NSLayoutConstraint?
    public internal(set) var bottom: NSLayoutConstraint?
    public internal(set) var left: NSLayoutConstraint?
    public internal(set) var right: NSLayoutConstraint?
    
    public func activate() {
        top?.activate()
        bottom?.activate()
        left?.activate()
        right?.activate()
    }
    
    public func deactivate() {
        top?.deactivate()
        bottom?.deactivate()
        left?.deactivate()
        right?.deactivate()
    }
}

public struct CLFloat {
    public var relation: NSLayoutRelation
    public var value: CGFloat
}

public struct CLSize {
    var width: CLFloat
    var height: CLFloat
    
    public init(_ size: CGSize) {
        self.width = CLFloat(relation: .equal, value: size.width)
        self.height = CLFloat(relation: .equal, value: size.width)
    }
    
    public init(width: CGFloat, height: CGFloat) {
        self.width = CLFloat(relation: .equal, value: width)
        self.height = CLFloat(relation: .equal, value: height)
    }
    
    public init(width: CLFloat, heigh: CLFloat) {
        self.width = width
        self.height = heigh
    }
}

precedencegroup AnchorRightSide {
    associativity: right
}

precedencegroup AnchorLeftSide {
    associativity: right
    higherThan: AnchorRightSide
}

prefix operator >=

public prefix func >=(rhs: CGFloat) -> CLFloat {
    return CLFloat(relation: .greaterThanOrEqual, value: rhs)
}

prefix operator <=

public prefix func <=(rhs: CGFloat) -> CLFloat {
    return CLFloat(relation: .lessThanOrEqual, value: rhs)
}

infix operator -| : AnchorRightSide

@discardableResult public func -|(lhs: (CGFloat, NSLayoutXAxisAnchor), rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
    let constraint = lhs.1.constraint(equalTo: rhs, constant: lhs.0)
    constraint.isActive = true
    return constraint
}

@discardableResult public func -|(lhs: (CLFloat, NSLayoutXAxisAnchor), rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
    let constraint: NSLayoutConstraint
    
    switch lhs.0.relation {
    case .greaterThanOrEqual:
        constraint = lhs.1.constraint(greaterThanOrEqualTo: rhs, constant: lhs.0.value)
    case .lessThanOrEqual:
        constraint = lhs.1.constraint(lessThanOrEqualTo: rhs, constant: lhs.0.value)
    case .equal:
         constraint = lhs.1.constraint(equalTo: rhs, constant: lhs.0.value)
    }
    constraint.isActive = true
    
    return constraint
}

@discardableResult public func -|(lhs: (CGFloat, NSLayoutYAxisAnchor), rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
    let constraint = lhs.1.constraint(equalTo: rhs, constant: lhs.0)
    constraint.isActive = true
    return constraint
}

@discardableResult public func -|(lhs: (CLFloat, NSLayoutYAxisAnchor), rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
    let constraint: NSLayoutConstraint
    
    switch lhs.0.relation {
    case .greaterThanOrEqual:
        constraint = lhs.1.constraint(greaterThanOrEqualTo: rhs, constant: lhs.0.value)
    case .lessThanOrEqual:
        constraint = lhs.1.constraint(lessThanOrEqualTo: rhs, constant: lhs.0.value)
    case .equal:
       constraint = lhs.1.constraint(equalTo: rhs, constant: lhs.0.value)
    }
    constraint.isActive = true
    
    return constraint
}

infix operator |- : AnchorLeftSide

public func |-(lhs: NSLayoutXAxisAnchor, rhs: CGFloat) -> (CGFloat, NSLayoutXAxisAnchor) {
    return (rhs,lhs)
}

public func |-(lhs: NSLayoutXAxisAnchor, rhs: CLFloat) -> (CLFloat, NSLayoutXAxisAnchor) {
    return (rhs,lhs)
}

public func |-(lhs: NSLayoutYAxisAnchor, rhs: CGFloat) -> (CGFloat, NSLayoutYAxisAnchor) {
    return (rhs,lhs)
}

public func |-(lhs: NSLayoutYAxisAnchor, rhs: CLFloat) -> (CLFloat, NSLayoutYAxisAnchor) {
    return (rhs,lhs)
}

infix operator |--| : AnchorLeftSide
@discardableResult public func |--|(lhs: UIView, rhs: UIView) -> UIView {
    lhs.rightAnchor.constraint(equalTo: rhs.leftAnchor).isActive = true
    return rhs
}

precedencegroup MultiplicationPrecedence {
    higherThan: DimensionPrecedence
}

precedencegroup DimensionPrecedence {
    associativity: left
}

infix operator |-| : DimensionPrecedence
@discardableResult public func |-|(lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalToConstant: rhs)
    constraint.isActive = true
    return constraint
}

@discardableResult public func |-|(lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalTo: rhs, multiplier: 1)
    constraint.isActive = true
    return constraint
}

@discardableResult public func |-|(lhs: NSLayoutDimension, rhs: CLFloat) -> NSLayoutConstraint {
    let constraint: NSLayoutConstraint
    
    switch rhs.relation {
    case .equal:
        constraint = lhs.constraint(equalToConstant: rhs.value)
    case .greaterThanOrEqual:
        constraint = lhs.constraint(greaterThanOrEqualToConstant: rhs.value)
    case .lessThanOrEqual:
        constraint = lhs.constraint(lessThanOrEqualToConstant: rhs.value)
    }
    
    constraint.activate()
    return constraint
}

public func *(lhs: NSLayoutDimension, rhs: CGFloat) -> (NSLayoutDimension, CGFloat) {
    return (lhs, rhs)
}

@discardableResult public func |-|(lhs: NSLayoutDimension, rhs: (NSLayoutDimension, CGFloat)) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalTo: rhs.0, multiplier: rhs.1)
    constraint.isActive = true
    return constraint
}

public enum CLAnchor {
    case top
    case bottom
    case left
    case right
}

public enum CLAxis {
    case yAxis
    case xAxis
}

public enum CLAligning {
    case horizontally
    case vertically
}

@available(*, unavailable, message: "Stretch functions where moved to UIView extension. Use view.stretch(with: UIView, in: CLAxis) instead.")
public func stretch(_ viewone: UIView, with viewtwo: UIView, axis: CLAxis) { }

@available(*, unavailable, message: "Stretch functions where moved to UIView extension. Use view.stretch(in: UIView) instead.")
public func stretch(_ viewone: UIView, with viewtwo: UIView) { }

public extension UIView {
    public var top: NSLayoutYAxisAnchor {
        get {
            return self.topAnchor
        }
    }
    
    public var bottom: NSLayoutYAxisAnchor {
        get {
            return self.bottomAnchor
        }
    }
    
    public var left: NSLayoutXAxisAnchor {
        get {
            return self.leftAnchor
        }
    }
    
    public var right: NSLayoutXAxisAnchor {
        get {
            return self.rightAnchor
        }
    }
    
    public var width: NSLayoutDimension {
        get {
            return self.widthAnchor
        }
    }
    
    public var centerY: NSLayoutYAxisAnchor {
        get {
            return self.centerYAnchor
        }
    }
    
    public var centerX: NSLayoutXAxisAnchor {
        get {
            return self.centerXAnchor
        }
    }
    
    public var height: NSLayoutDimension {
        get {
            return self.heightAnchor
        }
    }
}

public extension UIView {
    func center(with view: UIView, _ aligning: CLAligning) {
        switch aligning {
        case .horizontally:
            self.centerX |- 0 -| view.centerX
        case .vertically:
            self.centerY |- 0 -| view.centerY
        }
    }
    
    func center(in view: UIView) {
        self.centerX |- 0 -| view.centerX
        self.centerY |- 0 -| view.centerY
    }
}

public extension UIView {
    
    @discardableResult func constraintSize(width: CGFloat, height: CGFloat) -> CLSizeConstraint {
        let widthConstraint = (self.width |-| width)
        let heightConstraint = (self.height |-| height)
        
        return CLSizeConstraint(width: widthConstraint, height: heightConstraint)
    }
    
    @discardableResult func constraintSize(with size: CLSize) -> CLSizeConstraint {
        let widthConstraint: NSLayoutConstraint
        let heightConstraint: NSLayoutConstraint
        
        switch size.height.relation {
        case .equal:
            heightConstraint = self.height.constraint(equalToConstant: size.height.value)
        case .greaterThanOrEqual:
            heightConstraint = self.height.constraint(greaterThanOrEqualToConstant: size.height.value)
        case .lessThanOrEqual:
            heightConstraint = self.height.constraint(lessThanOrEqualToConstant: size.height.value)
        }
        
        switch size.width.relation {
        case .equal:
            widthConstraint = self.width.constraint(equalToConstant: size.width.value)
        case .greaterThanOrEqual:
            widthConstraint = self.width.constraint(greaterThanOrEqualToConstant: size.width.value)
        case .lessThanOrEqual:
            widthConstraint = self.width.constraint(lessThanOrEqualToConstant: size.width.value)
        }
        
        widthConstraint.activate()
        heightConstraint.activate()

        return CLSizeConstraint(width: widthConstraint, height: heightConstraint)
    }
}

public extension UIView {
    @discardableResult public func stretch(with view: UIView, in axis: CLAxis) -> CLStretchedConstraint {
        var constraint = CLStretchedConstraint()
        
        switch axis {
        case .xAxis:
            constraint.left = (self.left |- 0 -| view.left)
            constraint.right = (self.right |- 0 -| view.right)
        case .yAxis:
            constraint.top = (self.top |- 0 -| view.top)
            constraint.bottom = (self.bottom |- 0 -| view.bottom)
        }
        
        return constraint
    }
    
    @discardableResult public func stretch(in view: UIView) -> CLStretchedConstraint {
        var constraint = CLStretchedConstraint()
        
        constraint.left = (self.left |- 0 -| view.left)
        constraint.right = (self.right |- 0 -| view.right)
        constraint.top = (self.top |- 0 -| view.top)
        constraint.bottom = (self.bottom |- 0 -| view.bottom)
        
        return constraint
    }
}

public extension NSLayoutConstraint {
    func activate() {
        self.isActive = true
    }
    
    func deactivate() {
        self.isActive = false
    }
}

public extension UILayoutGuide {
    public var top: NSLayoutYAxisAnchor {
        get {
            return self.topAnchor
        }
    }
    
    public var bottom: NSLayoutYAxisAnchor {
        get {
            return self.bottomAnchor
        }
    }
    
    public var left: NSLayoutXAxisAnchor {
        get {
            return self.leftAnchor
        }
    }
    
    public var right: NSLayoutXAxisAnchor {
        get {
            return self.rightAnchor
        }
    }
    
    public var width: NSLayoutDimension {
        get {
            return self.widthAnchor
        }
    }
    
    public var centerY: NSLayoutYAxisAnchor {
        get {
            return self.centerYAnchor
        }
    }
    
    public var centerX: NSLayoutXAxisAnchor {
        get {
            return self.centerXAnchor
        }
    }
    
    public var height: NSLayoutDimension {
        get {
            return self.heightAnchor
        }
    }
}
