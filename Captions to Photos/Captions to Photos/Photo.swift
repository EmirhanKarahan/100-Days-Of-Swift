//
//  Photo.swift
//  Captions to Photos
//
//  Created by Emirhan KARAHAN on 26.06.2022.
//

import UIKit

class Photo: NSObject, Codable {
    var fileName:String
    var caption:String
    static var PHOTOS_KEY = "Photos"
    
    init(fileName:String, caption:String){
        self.fileName = fileName
        self.caption = caption
    }
    
    static func getPhotosFromUserDetails() -> [Photo] {
        if let loadedPhotos = UserDefaults.standard.object(forKey: PHOTOS_KEY) as? Data {
            if let decodedPhotos = try? JSONDecoder().decode([Photo].self, from: loadedPhotos) {
                return decodedPhotos
            }
        }
        
        return [Photo]()
    }
    
    static func savePhotosToUserDetails(photos:[Photo]){
        if let encodedPhotos = try? JSONEncoder().encode(photos) {
            UserDefaults.standard.set(encodedPhotos, forKey: PHOTOS_KEY)
        }
    }
}
