//
//  ImageViewModel.swift
//  deabeteplus
//
//  Created by pasin on 8/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import AVKit

class ImageViewModel {
    
    
    func uploadImage(_ image: UIImage, path: String, onSuccess: @escaping(URL) -> Void, onError: @escaping(Error?) -> Void ) {
      
        
        /// 1 convert to data
        guard let imageData = image.jpegData(compressionQuality: 0.7) else { return }
            
        /// 2 metadata option
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"  //กำหนด type
        
        /// 3 path & filename
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let imageName = "image_" + formatter.string(from: date)
        
        
        /// 4 upload reference
        let uploadRef =  Storage.storage().reference().child("images").child(path).child(imageName)
        
        /// 5 upload image
        uploadRef.putData(imageData, metadata: metadata) { (metadata, error) in
            
            guard metadata != nil else {
                 onError(error)
                return
            }

            /// 6 download URL
            uploadRef.downloadURL(completion: { (downloadURL, error) in
                
                guard let downloadURL = downloadURL else {
                    onError(error)
                    return
                }
                onSuccess(downloadURL)
                
            })
               
        }
    }
}

