//
//  ProfileViewController.swift
//  EventPass
//
//  Created by Carlos Marcelo Tonisso Junior on 3/29/19.
//  Copyright © 2019 Carlos Marcelo Tonisso Junior. All rights reserved.
//

import UIKit
import Cartography
import FirebaseAuth

enum ButtonType {
    case login
    case logout
}

class ProfileViewController: UIViewController {
    
    lazy var viewModel = ProfileViewModel(self.navigationController)
    
    lazy var createEventButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .highlightYellow
        button.addTarget(self, action: #selector(navigateToCreateEvent), for: .touchUpInside)
        button.setTitle("Criar evento", for: .normal)
        button.setTitleColor(.baseBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Black", size: 18)
        button.clipsToBounds = true
        return button
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .highlightYellow
        button.setTitleColor(.baseBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Black", size: 18)
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = false
        viewModel.addAuthListener { (isUserLoggedIn) in
            self.setupInitialState(isUserLoggedIn)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.removeAuthListener()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginButton.layer.cornerRadius = loginButton.bounds.height / 2
        createEventButton.layer.cornerRadius = createEventButton.bounds.height / 2
    }
    
    func setupInitialState(_ isUserLoggedIn: Bool) {
        self.view.backgroundColor = .baseBlue
        self.view.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        if isUserLoggedIn {
            setupButtonFor(.logout)
        } else {
            setupButtonFor(.login)
        }
        setupCreateEventButton()
    }
    
    func setupCreateEventButton() {
        self.view.addSubview(createEventButton)
        constrain(loginButton, createEventButton) { login, event in
            event.bottom == login.top - 12
            event.width == login.width
            event.height == 40
            event.centerX == login.centerX
        }
    }
    
    func setupButtonFor(_ buttonType: ButtonType) {
        self.view.addSubview(loginButton)
        
        switch buttonType {
        case .login:
            if loginButton.allTargets.count != 0 {
                loginButton.removeTarget(self, action: #selector(logout), for: .touchUpInside)
            }
            loginButton.addTarget(self, action: #selector(navigateToLogin), for: .touchUpInside)
            loginButton.setTitle("Faça o login", for: .normal)
        case .logout:
            if loginButton.allTargets.count != 0 {
                loginButton.removeTarget(self, action: #selector(navigateToLogin), for: .touchUpInside)
            }
            loginButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
            loginButton.setTitle("Logout", for: .normal)
        }
        
        
        constrain(loginButton) { button in
            guard let superview = button.superview else { return }
            button.width == superview.width * 0.6
            button.height == 40
            button.center == superview.center
        }
    }

    @objc func logout() {
        viewModel.logout()
    }
    
    @objc func navigateToLogin() {
        viewModel.navigateToLogin()
    }
    
    @objc func navigateToCreateEvent() {
        viewModel.navigateToEventCreation()
    }
    
}
