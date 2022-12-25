//
//  LoginVC.swift
//  Test
//
//  Created by Minh on 21/11/2022.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var emailTF: FloatingTextField!
    @IBOutlet weak var passwordTF: FloatingTextField!
    let viewModelSignUp = SignUpViewModel()
    var isCheck:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFloadingTextField()
        setupBtnContinue()
        setupBtnCheck()
        setupBinding()
        setupKeyBoardAppear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    
    override func viewWillLayoutSubviews() {
        print("viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
    }
    
    private func  setupKeyBoardAppear(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupBinding(){
        viewModelSignUp.signUpModel.bind { [weak self ] signModel in
            if let model = signModel,
               let token = model.token {
                StorageUserDefaut.shared.token = token
                DispatchQueue.main.async {
                    self?.goToCategoriesVC()
                }
            }
        }
    }
    
    private func goToCategoriesVC(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: CategoriesListVC.identifier) as? CategoriesListVC else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func setupFloadingTextField(){
        emailTF.placeholder = "Your Email"
        emailTF.delegate = self
        emailTF.tag = 1
        emailTF.typeTextField = .none
        
        passwordTF.placeholder = "Your Password"
        passwordTF.delegate = self
        passwordTF.tag = 2
        passwordTF.typeTextField = .isPassword
    }
    
    private func setupBtnCheck(){
        btnCheck.isUserInteractionEnabled = true
        btnCheck.setImage(UIImage(named: "uncheck_ic"), for: .normal)
        btnCheck.addTarget(self, action:#selector(btnRec), for: .touchUpInside)
    }
    
    private func setupBtnContinue(){
        continueBtn.tag = 1
        continueBtn.addTarget(self, action:#selector(buttonAction), for: .touchUpInside)
    }
    
    
    @objc func buttonAction(sender: UIButton!) {
        guard let emailText = emailTF.text,
              let passwordText = passwordTF.text else {return}
        viewModelSignUp.signUp(email: emailText, password: passwordText)
    }
    
    @objc func btnRec(sender: UIButton!) {
        isCheck = !isCheck
        if isCheck {
            sender.setImage(UIImage(named: "check_ic"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "uncheck_ic"), for: .normal)
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}


extension LoginVC:UITextFieldDelegate{
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
