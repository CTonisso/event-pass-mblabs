//
//  LoginViewController.swift
//  EventPass
//
//  Created by Carlos Marcelo Tonisso Junior on 4/2/19.
//  Copyright © 2019 Carlos Marcelo Tonisso Junior. All rights reserved.
//

import UIKit
import Cartography
import FirebaseAuth
import CodableFirebase

class LoginViewController: UIViewController {

    lazy var viewModel = LoginViewModel(self.navigationController)
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 12
        view.distribution = .fill
        view.axis = .vertical
        view.alignment = .center
        view.backgroundColor = .clear
        return view
    }()
    
    let logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logoBig")
        return image
    }()
    
    let emailTextField: EPTextField = {
        let view = EPTextField()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3
        view.font = UIFont(name: "Avenir-Book", size: 16)
        view.textColor = .highlightYellow
        view.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSAttributedString.Key.foregroundColor: UIColor.highlightYellow])
        view.leftPadding = 20
        view.keyboardType = .emailAddress
        view.clipsToBounds = true
        return view
    }()
    
    let passwordTextField: EPTextField = {
        let view = EPTextField()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3
        view.font = UIFont(name: "Avenir-Book", size: 16)
        view.textColor = .highlightYellow
        view.attributedPlaceholder = NSAttributedString(string: "Senha", attributes: [NSAttributedString.Key.foregroundColor: UIColor.highlightYellow])
        view.leftPadding = 20
        view.keyboardType = .default
        view.isSecureTextEntry = true
        view.clipsToBounds = true
        return view
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        button.setTitle("Entrar", for: .normal)
        button.backgroundColor = .highlightYellow
        button.setTitleColor(.baseBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Black", size: 18)
        button.clipsToBounds = true
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(register), for: .touchUpInside)
        button.setTitle("Cadastrar", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.highlightYellow, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 16)
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.observeKeyboard()
        self.hideKeyboardWhenTappedAround()
        setupInitialState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setupInitialState() {
        self.view.backgroundColor = .baseBlue
        setupScrollView()
        setupStackView()
        setupLogoImageView()
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupRegisterButton()
        setupForgetPasswordButton()
    }
    
    func setupScrollView() {
        self.view.addSubview(scrollView)
        constrain(scrollView) { view in
            guard let superview = view.superview else { return }
            view.width == superview.width
            view.bottom == superview.bottom
            view.top == superview.top
            view.centerX == superview.centerX
        }
    }
    
    func setupStackView() {
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(registerButton)
        stackView.setCustomSpacing(38, after: logoImageView)
        constrain(stackView) { view in
            guard let superview = view.superview else { return }
            view.top == superview.top
            view.bottom == superview.bottom
            view.width == superview.width
            view.centerX == superview.centerX
        }
    }
    
    func setupLogoImageView() {
        constrain(logoImageView) { view in
            guard let superview = view.superview else { return }
            view.width == superview.width * 0.92
            view.height == view.width * 0.55
        }
    }
    
    func setupEmailTextField() {
        constrain(emailTextField) { view in
            guard let superview = view.superview else { return }
            view.width == superview.width * 0.87
            view.height == 52
        }
        
        emailTextField.layer.cornerRadius = 26
    }
    
    func setupPasswordTextField() {
        constrain(passwordTextField) { view in
            guard let superview = view.superview else { return }
            view.width == superview.width * 0.87
            view.height == 52
        }
        
        passwordTextField.layer.cornerRadius = 26
    }
    
    func setupLoginButton() {
        constrain(loginButton) { button in
            guard let superview = button.superview else { return }
            button.width == superview.width * 0.6
            button.height == 40
        }
        
        loginButton.layer.cornerRadius = 20
    }
    
    func setupRegisterButton() {
        constrain(registerButton) { button in
            button.height == 24
        }
    }
    
    func setupForgetPasswordButton() {
        
    }
    
    @objc func login() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        viewModel.loginUser(withEmail: email, password: password)
    }
    
    @objc func register() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}
