//
//  FloatingTextField.swift
//  AnimatedTextField
//
//  Created by Alexey Zhulikov on 22.10.2019.
//  Copyright © 2019 Alexey Zhulikov. All rights reserved.
//

import UIKit

private extension TimeInterval {
    static let animation250ms: TimeInterval = 0.25
}

private extension UIColor {
    static let inactive: UIColor = .gray
}

private enum Constants {
    static let offset: CGFloat = 8
    static let placeholderSize: CGFloat = 14
}

enum typeTextField{
    case isPassword
    case none
}

final class FloatingTextField: UITextField {
    var typeTextField:typeTextField  = .none{
        didSet{
            if typeTextField == .none{
                eyeButton.isHidden = true
            }else if typeTextField == .isPassword{
                eyeButton.isHidden = false
            }
        }
    }
    
    private var showBalance: Bool = true {
        didSet {
            if showBalance{
                self.isSecureTextEntry = true
            }else{
                self.isSecureTextEntry = false
            }
        }
    }
    
    // MARK: - Subviews
    private let eyeButton: UIButton = UIButton()
    private var border = UIView()
    private var label = UILabel()
    
    // MARK: - Private Properties
    
    private var scale: CGFloat {
        Constants.placeholderSize / fontSize
    }
    
    private var fontSize: CGFloat {
        font?.pointSize ?? 0
    }
    
    private var labelHeight: CGFloat {
        ceil(font?.withSize(Constants.placeholderSize).lineHeight ?? 0)
    }
    
    private var textHeight: CGFloat {
        ceil(font?.lineHeight ?? 0)
    }
    
    private var isEmpty: Bool {
        text?.isEmpty ?? true
    }
    
    private var textInsets: UIEdgeInsets {
        UIEdgeInsets(top: Constants.offset + labelHeight, left: 0, bottom: Constants.offset, right: 0)
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - UITextField
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.width, height: textInsets.top + textHeight + textInsets.bottom)
    }
    
    override var placeholder: String? {
        didSet {
            label.text = placeholder
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        border.frame = CGRect(x: 0, y: bounds.height - 1, width: bounds.width, height: 1)
        updateLabel(animated: false)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return .zero
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard !isFirstResponder else {
            return
        }
        
        label.transform = .identity
        label.frame = bounds.inset(by: textInsets)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        borderStyle = .none
        
        border.backgroundColor = .inactive
        border.isUserInteractionEnabled = false
        addSubview(border)
        
        label.textColor = .inactive
        label.font = font
        label.text = placeholder
        label.isUserInteractionEnabled = false
        addSubview(label)
        
        
        // icon eye
        eyeButton.isHidden = true
        eyeButton.contentMode = .scaleAspectFill
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setBackgroundImage(UIImage(named: "icEyeWhiteShow"), for: .normal)
        addSubview(eyeButton)
        
        
        let constraints = [
            eyeButton.bottomAnchor.constraint(equalTo: border.topAnchor, constant: -10),
            eyeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            eyeButton.widthAnchor.constraint(equalToConstant: 20),
            eyeButton.heightAnchor.constraint(equalToConstant: 15)
        ]
        NSLayoutConstraint.activate(constraints)
        
        
        
        self.addTarget(self, action: #selector(handleEditing), for: .allEditingEvents)
        eyeButton.addTarget(self, action: #selector(onShowBalanceNumberTapped), for: .touchUpInside)
        
    }
    
    @objc func onShowBalanceNumberTapped(_ sender: UIButton) {
        showBalance = !showBalance
        eyeButton.setImage(UIImage(named: showBalance ? "icEyeWhiteShow": "icEyeWhiteHide"), for: .normal)
    }
    
    @objc
    private func handleEditing() {
        updateLabel()
        updateBorder()
    }
    
    private func updateBorder() {
        let borderColor = isFirstResponder ? tintColor : .inactive
        UIView.animate(withDuration: .animation250ms) {
            self.border.backgroundColor = borderColor
        }
    }
    
    private func updateLabel(animated: Bool = true) {
        let isActive = isFirstResponder || !isEmpty
        
        let offsetX = -label.bounds.width * (1 - scale) / 2
        let offsetY = -label.bounds.height * (1 - scale) / 2
        
        let transform = CGAffineTransform(translationX: offsetX, y: offsetY - labelHeight - Constants.offset)
            .scaledBy(x: scale, y: scale)
        
        guard animated else {
            label.transform = isActive ? transform : .identity
            return
        }
        
        UIView.animate(withDuration: .animation250ms) {
            self.label.transform = isActive ? transform : .identity
        }
    }
}
