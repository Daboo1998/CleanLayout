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
import CleanLayout

class StretchingViewController: UIViewController {

    private var strechButton: UIButton!
    private var exampleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraintActiveToggleButton()
        setupOtherViews()
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    private func setupConstraintActiveToggleButton() {
        strechButton = UIButton(type: .roundedRect)
        strechButton.setTitle("Strech!", for: .normal)
        strechButton.addTarget(self, action: #selector(strechAction(sender:)), for: .touchUpInside)
        self.view.addSubview(strechButton)
    }
    
    private func setupOtherViews() {
        exampleView = UIView()
        exampleView.backgroundColor = .red
        self.view.addSubview(exampleView)
        self.view.insertSubview(exampleView, at: 0)
    }
    
    private func setupConstraints() {
        strechButton.translatesAutoresizingMaskIntoConstraints = false
        strechButton.center(with: self.view, .horizontally)
        strechButton.bottom |- -50 -| self.view.bottom
        
        exampleView.translatesAutoresizingMaskIntoConstraints = false
        exampleView.center(in: self.view)
        exampleView.widthAnchor.constraint(greaterThanOrEqualToConstant: 50).activate()
        exampleView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).activate()
    }
    
    @objc private func strechAction(sender: UIButton) {
        exampleView.stretch(in: self.view)
        sender.isEnabled = false
        sender.setTitle("Streched", for: .normal)
    }

}
