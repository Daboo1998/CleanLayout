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

precedencegroup AnchorRightSide {
    associativity: right
}
precedencegroup AnchorLeftSide {
    associativity: right
    higherThan: AnchorRightSide
}

infix operator -| : AnchorRightSide

@discardableResult public func -|(lhs: (CGFloat, NSLayoutXAxisAnchor), rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
    let constraint = lhs.1.constraint(equalTo: rhs, constant: lhs.0)
    constraint.isActive = true
    return constraint
}

@discardableResult public func -|(lhs: (CGFloat, NSLayoutYAxisAnchor), rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
    let constraint = lhs.1.constraint(equalTo: rhs, constant: lhs.0)
    constraint.isActive = true
    return constraint
}

infix operator |- : AnchorLeftSide

@discardableResult public func |-(lhs: NSLayoutXAxisAnchor, rhs: CGFloat) -> (CGFloat, NSLayoutXAxisAnchor) {
    return (rhs,lhs)
}

@discardableResult public func |-(lhs: NSLayoutYAxisAnchor, rhs: CGFloat) -> (CGFloat, NSLayoutYAxisAnchor) {
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

public func strech(_ viewone: UIView, with viewtwo: UIView, axis: CLAxis) {
    switch axis {
    case .xAxis:
        viewone.leftAnchor.constraint(equalTo: viewone.leftAnchor).isActive = true
        viewone.rightAnchor.constraint(equalTo: viewone.rightAnchor).isActive = true
    case .yAxis:
        viewone.topAnchor.constraint(equalTo: viewone.topAnchor).isActive = true
        viewone.bottomAnchor.constraint(equalTo: viewone.bottomAnchor).isActive = true
    }
}

public func strech(_ viewone: UIView, with viewtwo: UIView) {
    viewone.leftAnchor.constraint(equalTo: viewone.leftAnchor).isActive = true
    viewone.rightAnchor.constraint(equalTo: viewone.rightAnchor).isActive = true
    viewone.topAnchor.constraint(equalTo: viewone.topAnchor).isActive = true
    viewone.bottomAnchor.constraint(equalTo: viewone.bottomAnchor).isActive = true
}


public func pin(_ viewOne: UIView, to anchor: CLAnchor, of viewTwo: UIView, constant: CGFloat) {
    switch anchor {
    case .top:
        viewOne.topAnchor.constraint(equalTo: viewTwo.topAnchor, constant: constant).isActive = true
    case .bottom:
        viewOne.bottomAnchor.constraint(equalTo: viewTwo.bottomAnchor, constant: constant).isActive = true
    case .left:
        viewOne.leftAnchor.constraint(equalTo: viewTwo.leftAnchor, constant: constant).isActive = true
    case .right:
        viewOne.rightAnchor.constraint(equalTo: viewTwo.rightAnchor, constant: constant).isActive = true
    }
}

public func pin(_ viewOne: UIView, to anchor: CLAnchor, of viewTwo: UIView) {
    switch anchor {
    case .top:
        viewOne.topAnchor.constraint(equalTo: viewTwo.topAnchor).isActive = true
    case .bottom:
        viewOne.bottomAnchor.constraint(equalTo: viewTwo.bottomAnchor).isActive = true
    case .left:
        viewOne.leftAnchor.constraint(equalTo: viewTwo.leftAnchor).isActive = true
    case .right:
        viewOne.rightAnchor.constraint(equalTo: viewTwo.rightAnchor).isActive = true
    }
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

