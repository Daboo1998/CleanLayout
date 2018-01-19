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

class ActivatingAndDeactivatingViewController: UIViewController {
    
    private var activatedAndDeactivatedConstraint: NSLayoutConstraint!
    private var constraintActiveToggleButton: UIButton!
    private var exampleView: UIView!
    
    private enum ConstraintState {
        case isActive
        case isNotActive
    }
    
    private var constraintState: ConstraintState {
        get {
            if activatedAndDeactivatedConstraint.isActive {
                return .isActive
            } else {
                return .isNotActive
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraintActiveToggleButton()
        setupOtherViews()
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    private func setupConstraintActiveToggleButton() {
        constraintActiveToggleButton = UIButton(type: .roundedRect)
        constraintActiveToggleButton.setTitle("deactivate constraint", for: .normal)
        constraintActiveToggleButton.addTarget(self, action: #selector(toggleContraintActive), for: .touchUpInside)
        self.view.addSubview(constraintActiveToggleButton)
    }
    
    private func setupOtherViews() {
        exampleView = UIView()
        exampleView.backgroundColor = .red
        self.view.addSubview(exampleView)
    }
    
    private func setupConstraints() {
        constraintActiveToggleButton.translatesAutoresizingMaskIntoConstraints = false
        constraintActiveToggleButton.center(with: self.view, .horizontally)
        constraintActiveToggleButton.bottom |- -50 -| self.view.bottom
        
        exampleView.translatesAutoresizingMaskIntoConstraints = false
        exampleView.center(in: self.view)
        exampleView.widthAnchor.constraint(greaterThanOrEqualToConstant: 50).activate()
        exampleView.height |-| 100
        activatedAndDeactivatedConstraint = (exampleView.width |-| 100)
    }
    
    @objc private func toggleContraintActive() {
        switch constraintState {
        case .isActive:
            activatedAndDeactivatedConstraint.deactivate()
            constraintActiveToggleButton.setTitle("activate constraint", for: .normal)
        case .isNotActive:
            activatedAndDeactivatedConstraint.activate()
            constraintActiveToggleButton.setTitle("deactivate constraint", for: .normal)
        }
    }
}
