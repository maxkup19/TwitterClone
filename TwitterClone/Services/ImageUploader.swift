//
//  ImageUploader.swift
//  TwitterClone
//
//  Created by Max Kup on 27.08.2022.
//

import FirebaseStorage
import UIKit

class ImageUploader {
    
    static func uploadImage(image: UIImage, completion: @escaping (String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
        
        ref.putData(imageData) { _, err in
            if let err = err {
                print("DEBUG: failed to upload a photo with error: \(err.localizedDescription)")
                return
            }
            
            print("DEBUG: uploaded image succesfully")
            
            ref.downloadURL { imageUrl, _ in
                guard let imageUrl = imageUrl?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
    
}
