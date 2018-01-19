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

class SizingViewController: UIViewController {
    
    private var widthTextField: UITextField!
    private var heightTextField: UITextField!
    private var setButton: UIButton!
    private var exampleView: UIView!
    private var widthConstraint: NSLayoutConstraint!
    private var heightConstraint: NSLayoutConstraint!
    private var bottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapToDismissKeyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapToDismissKeyboardRecognizer)
        
        setupTextFields()
        setupButton()
        setupView()
        setupConstraints()
        
        prepareForKeyboard()
    }
    
    private func setupTextFields() {
        widthTextField = UITextField()
        heightTextField = UITextField()
        
        widthTextField.keyboardType = .decimalPad
        heightTextField.keyboardType = .decimalPad
        
        widthTextField.placeholder = "Enter width..."
        heightTextField.placeholder = "Enter height..."
        
        self.view.addSubview(widthTextField)
        self.view.addSubview(heightTextField)
    }
    
    private func setupButton() {
        setButton = UIButton(type: .roundedRect)
        setButton.setTitle("Set size", for: .normal)
        setButton.addTarget(self, action: #selector(setSize), for: .touchUpInside)
        self.view.addSubview(setButton)
    }
    
    private func setupView() {
        exampleView = UIView()
        exampleView.backgroundColor = .red
        self.view.addSubview(exampleView)
        view.insertSubview(exampleView, at: 0)
    }
    
    private func setupConstraints() {
        widthTextField.translatesAutoresizingMaskIntoConstraints = false
        heightTextField.translatesAutoresizingMaskIntoConstraints = false
        setButton.translatesAutoresizingMaskIntoConstraints = false
        exampleView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomConstraint = (heightTextField.bottom |- -20 -| self.view.safeAreaLayoutGuide.bottom)
        self.view.safeAreaLayoutGuide.left |- -20 -| heightTextField.left
        heightTextField.right |- -20 -| setButton.left
        heightTextField.width |-| (self.view.width * 0.70)
        setButton.right |- -20 -| self.view.safeAreaLayoutGuide.right
        setButton.center(with: heightTextField, .vertically)
        
        widthTextField.bottom |- -20 -| heightTextField.top
        widthTextField.left |- 0 -| heightTextField.left
        widthTextField.right |- 0 -| heightTextField.right
        
        exampleView.center(in: self.view)
        heightConstraint = (exampleView.height |-| 0)
        widthConstraint = (exampleView.width |-| 0)
        
    }
    
    private func prepareForKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else {return}
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        bottomConstraint.constant -= keyboardHeight
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else {return}
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        bottomConstraint.constant += keyboardHeight
    }
    
    @objc private func dismissKeyboard() {
        widthTextField.resignFirstResponder()
        heightTextField.resignFirstResponder()
    }
    
    @objc private func setSize() {
        let widthText = widthTextField.text ?? "\(widthConstraint.constant)"
        let heighText = heightTextField.text ?? "\(heightConstraint.constant)"
        
        guard let width = NumberFormatter().number(from: widthText) else { return }
        guard let height = NumberFormatter().number(from: heighText) else { return }
        
        widthConstraint.constant = CGFloat(exactly: width) ?? 0
        heightConstraint.constant = CGFloat(exactly: height) ?? 0
    }

}
