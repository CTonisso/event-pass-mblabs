//
//  RegisterEventViewModel.swift
//  EventPass
//
//  Created by Carlos Marcelo Tonisso Junior on 4/5/19.
//  Copyright © 2019 Carlos Marcelo Tonisso Junior. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class RegisterEventViewModel: ViewModel {
    
    func uploadMedia(image: UIImage, completion: @escaping (_ url: String) -> Void){
        let storageRef = Storage.storage().reference().child(UUID().uuidString)
        if let uploadData = image.pngData() {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                completion(metadata?.path ?? "")
            }
        }
    }
    
//    func updateDatabase(image: UIImage, eventUID: String) {
//        self.uploadMedia(image: image) { url in
//            guard let url = url else { return }
//            Database.database().reference().child("Posts").childByAutoId().setValue(["myImageURL" : url])
//        }
//    }
}
