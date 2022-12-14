//
//  LoginViewController.swift
//  JetDevsHomeWork
//
//  Created by Hemang Solanki on 14/12/22.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    
    // MARK: - Outlets -
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            self.loginButton.backgroundColor = UIColor(red: 159/255, green: 159/255, blue: 159/255, alpha: 1.0)
            self.loginButton.rx.tap.subscribe(onNext: { _ in
                self.loginButtonTapped()
            }).disposed(by: bag)
        }
    }
    
    @IBOutlet weak var btnCancel: UIButton! {
        didSet {
            btnCancel.rx.tap.subscribe(onNext: { _ in
                self.dismiss(animated: true)
            }).disposed(by: bag)
        }
    }
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            self.emailTextField.placeholder = "Email"
            self.emailTextField.setLeftPadding(paddingValue: 20)
            self.emailTextField.setCornerRadius(size: 5)
            self.emailTextField.borderWidth(size: 0.5)
            self.emailTextField.placeholderColors = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
            self.emailTextField.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
            self.emailTextField.layer.borderColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0).cgColor
            self.emailTextField.font = UIFont.latoRegularFont(size: 16)
            
            self.emailTextField.autocorrectionType = .no
            self.emailTextField.autocapitalizationType = .none
            
            self.emailTextField.rx.controlEvent(.editingDidBegin).subscribe { _ in
                self.emailTextField.layer.borderColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0).cgColor
            }.disposed(by: bag)
            self.emailTextField.rx.controlEvent(.allEvents).subscribe { _ in
                self.checkValidation()
            }.disposed(by: bag)
            
        }
    }
    
    @IBOutlet weak var emailLabel: UILabel! {
        didSet {
            self.emailLabel.text = " Email "
            self.emailLabel.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
            self.emailLabel.font = UIFont.latoRegularFont(size: 12)
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            self.passwordTextField.placeholder = "Password"
            self.passwordTextField.setLeftPadding(paddingValue: 20)
            self.passwordTextField.setCornerRadius(size: 5)
            self.passwordTextField.borderWidth(size: 0.5)
            self.passwordTextField.placeholderColors = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
            self.passwordTextField.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
            self.passwordTextField.layer.borderColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0).cgColor
            self.passwordTextField.font = UIFont.latoRegularFont(size: 16)
            self.passwordTextField.rx.controlEvent(.editingDidBegin).subscribe { _ in
                self.passwordTextField.layer.borderColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0).cgColor
                
            }.disposed(by: bag)
            
            self.passwordTextField.rx.controlEvent(.allEvents).subscribe { _ in
                self.checkValidation()
            }.disposed(by: bag)
        }
    }
    
    @IBOutlet weak var passwordLabel: UILabel! {
        didSet {
            self.passwordLabel.text = " Password "
            self.passwordLabel.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
            self.passwordLabel.font = UIFont.latoRegularFont(size: 12)
        }
    }
    
    // MARK: - Properties -
    var viewModel = LoginViewModel.init()
    let bag = DisposeBag()
    var handler: LoginResponseDelegate?
    
    // MARK: - View Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - ButtonTapped -
    
    func loginButtonTapped() {
        let result = self.viewModel.checkValidations(email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "")
        Logs.printLogs(message: result.1)
        if result.0 == true {
            self.viewModel.loginApi(email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "") { userModel in
                if userModel.result == 1 {
                    DispatchQueue.main.async {
                        if self.handler != nil {
                            self.handler!(true)
                        }
                        self.dismiss(animated: true)
                    }
                }
                if userModel.result == 0{
                    DispatchQueue.main.async {
                        self.loginButton.backgroundColor = UIColor(red: 159/255, green: 159/255, blue: 159/255, alpha: 1.0)
                        self.showToast(message: self.viewModel.loginData?.errorMessage ?? "Login Unsuccessfull")
                    }
                }
            }errorHandler: { error in
                DispatchQueue.main.async {
                    self.loginButton.backgroundColor = UIColor(red: 159/255, green: 159/255, blue: 159/255, alpha: 1.0)
                    self.showToast(message: error)
                }
            }
        }
        else {
            DispatchQueue.main.async {
                self.showToast(message: result.1)
            }
           
        }
        
    }
    
    // MARK: - Helper / Validation -
    func setLoginButton(valid: Bool) {
        if valid == true {
            self.loginButton.backgroundColor = UIColor(red: 31/255, green: 61/255, blue: 122/255, alpha: 1.0)
            self.loginButton.isUserInteractionEnabled = true
        } else {
            self.loginButton.isUserInteractionEnabled = true
            self.loginButton.backgroundColor = UIColor(red: 159/255, green: 159/255, blue: 159/255, alpha: 1.0)
        }
    }
    
    func checkValidation() {
        let result = self.viewModel.checkValidations(email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "")
        Logs.printLogs(message: result.1)
        self.setLoginButton(valid: result.0)
    }
    
    
}
