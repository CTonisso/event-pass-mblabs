//
//  ProfileViewModel.swift
//  EventPass
//
//  Created by Carlos Marcelo Tonisso Junior on 4/4/19.
//  Copyright © 2019 Carlos Marcelo Tonisso Junior. All rights reserved.
//

import Foundation
import FirebaseAuth

class ProfileViewModel: ViewModel {
    
    var authListener: AuthStateDidChangeListenerHandle?
    
    override init(_ navigationController: UINavigationController?) {
        super.init(navigationController)
        
    }
    
    func addAuthListener(completion: @escaping (Bool) -> ()) {
        authListener = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func removeAuthListener() {
        guard let listener = authListener else { return }
        Auth.auth().removeStateDidChangeListener(listener)
    }
    
    func navigateToEventCreation() {
        self.navigationController?.pushViewController(RegisterEventViewController(), animated: true)
    }
    
    func navigateToLogin() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error)
        }
    }
    
}
