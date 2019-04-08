//
//  RegisterViewModel.swift
//  EventPass
//
//  Created by Carlos Marcelo Tonisso Junior on 4/2/19.
//  Copyright © 2019 Carlos Marcelo Tonisso Junior. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class RegisterViewModel: ViewModel {
    
    var databaseRefence = Database.database().reference()
    
    //MARK: Methods
    func registerUser(withName username: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (authResult, error) in
            
            guard let user = authResult?.user else { return }
            
            if error == nil {
                
                self.databaseRefence.child("users").child(user.uid).setValue(["username": username, "email": email])
                
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                print(error?.localizedDescription)
            }
        })
    }
    
}
