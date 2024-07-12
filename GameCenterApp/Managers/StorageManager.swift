//
//  StorageManager.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 3.03.2024.
//

import Foundation
import FirebaseStorage

class StorageManager {
    static let shared = StorageManager()
    
    private init() {}
    
    private let storageRef = Storage.storage().reference()
    
    
    func uploadImage(image: Data, folder: String, completion: @escaping (String?) -> Void) {
        let imageId = UUID().uuidString
        let storageRef = storageRef.child("\(folder)/\(imageId).jpeg")
        storageRef.putData(image) { metaData, error in
            guard error == nil else {
                completion(nil)
                return
            }
            
            storageRef.downloadURL { url, error in
                guard let url, error == nil else {
                    completion(nil)
                    return
                }
                completion(url.absoluteString)
            }
        }
    }
    
    func deleteImage() {
        
    }
}
