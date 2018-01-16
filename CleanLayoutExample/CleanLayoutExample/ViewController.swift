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
import CleanLayout

class ViewController: UIViewController {

    let viewOne: UIView = {
        let view = UIView(
            frame: CGRect(x: 0, y: 0, width: 100, height: 100)
        )
        view.backgroundColor = .red
        return view
    }()
    
    let viewTwo: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    let viewThree: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    let viewFour: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    var constraint: NSLayoutConstraint!
    
    let viewFive: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(viewOne)
        self.view.addSubview(viewTwo)
        self.view.addSubview(viewThree)
        self.view.addSubview(viewFour)
        self.view.addSubview(viewFive)
        
        viewOne.translatesAutoresizingMaskIntoConstraints = false
        viewTwo.translatesAutoresizingMaskIntoConstraints = false
        viewThree.translatesAutoresizingMaskIntoConstraints = false
        viewFour.translatesAutoresizingMaskIntoConstraints = false
        viewFive.translatesAutoresizingMaskIntoConstraints = false
        
        viewOne.width |-| self.view.width
        viewOne.top |- 0 -| self.view.top
        viewOne.bottom |- 0 -| self.view.safeAreaLayoutGuide.top
        
        viewTwo.width |-| self.view.width
        viewTwo.height |-| 75
        viewTwo.top |- 0 -| self.view.safeAreaLayoutGuide.top
        
        viewThree.width |-| self.view.width
        viewThree.height |-| 50
        viewThree.bottom |- 0 -| self.view.bottom
        
        let aspectRatio: CGFloat = 0.76
        
        viewFour.height |-| 70
        viewFour.width |-| (viewFour.height * aspectRatio)
        viewFour.centerX |- 0 -| viewThree.centerX
        viewFour.centerY |- 0 -| viewThree.top
        
        viewFive.height |-| 150
        constraint = (viewFive.width |-| 30)
        viewFive.centerY |- 0 -| self.view.safeAreaLayoutGuide.centerY
        viewFive.right |- 0 -| self.view.right
        
        viewOne.topAnchor.constraint(equalTo: viewTwo.topAnchor, constant: 10).isActive = true
        viewOne.widthAnchor.constraint(equalToConstant: 10).isActive = true
        viewOne.heightAnchor.constraint(equalTo: viewOne.widthAnchor, multiplier: 0.71).isActive = true
        
        viewOne.top |- 10 -| viewTwo.top
        viewOne.width |-| 10
        viewOne.height |-| (viewOne.width * 0.71)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if UIDevice.current.orientation.isLandscape {
            constraint.isActive = false
        } else {
            constraint.isActive = true
        }
    }

}

