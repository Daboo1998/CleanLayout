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

public struct CLFloat {
    var equality: CLEquality
    var value: CGFloat
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
    return CLFloat(equality: .graterOrEqual, value: rhs)
}

prefix operator <=

public prefix func <=(rhs: CGFloat) -> CLFloat {
    return CLFloat(equality: .lessOrEqual, value: rhs)
}

infix operator -| : AnchorRightSide

@discardableResult public func -|(lhs: (CGFloat, NSLayoutXAxisAnchor), rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
    let constraint = lhs.1.constraint(equalTo: rhs, constant: lhs.0)
    constraint.isActive = true
    return constraint
}

@discardableResult public func -|(lhs: (CLFloat, NSLayoutXAxisAnchor), rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
    let constraint: NSLayoutConstraint
    
    switch lhs.0.equality {
    case .graterOrEqual:
        constraint = lhs.1.constraint(greaterThanOrEqualTo: rhs, constant: lhs.0.value)
    case .lessOrEqual:
        constraint = lhs.1.constraint(lessThanOrEqualTo: rhs, constant: lhs.0.value)
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
    
    switch lhs.0.equality {
    case .graterOrEqual:
        constraint = lhs.1.constraint(greaterThanOrEqualTo: rhs, constant: lhs.0.value)
    case .lessOrEqual:
        constraint = lhs.1.constraint(lessThanOrEqualTo: rhs, constant: lhs.0.value)
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

public enum CLEquality {
    case graterOrEqual
    case lessOrEqual
}

public enum CLAligning {
    case horizontally
    case vertically
}

public func strech(_ viewone: UIView, with viewtwo: UIView, axis: CLAxis) {
    switch axis {
    case .xAxis:
        viewone.left    |- 0 -|     viewtwo.left
        viewone.right   |- 0 -|     viewtwo.right
    case .yAxis:
        viewone.top     |- 0 -|     viewtwo.top
        viewone.bottom  |- 0 -|     viewtwo.bottom
    }
}

public func strech(_ viewone: UIView, with viewtwo: UIView) {
    viewone.left    |- 0 -|     viewtwo.left
    viewone.right   |- 0 -|     viewtwo.right
    viewone.top     |- 0 -|     viewtwo.top
    viewone.bottom  |- 0 -|     viewtwo.bottom
}

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
