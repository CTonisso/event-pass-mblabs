//
//  LoginViewModel.swift
//  EventPass
//
//  Created by Carlos Marcelo Tonisso Junior on 4/2/19.
//  Copyright © 2019 Carlos Marcelo Tonisso Junior. All rights reserved.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ViewModel {
    
    func loginUser(withEmail: String, password: String) {
        Auth.auth().signIn(withEmail: withEmail, password: password, completion: { (user, error) in
            if error == nil {
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                print(error?.localizedDescription)
            }
        })
    }
    
}
