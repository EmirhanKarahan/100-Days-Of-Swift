//
//  Petition.swift
//  Whitehouse Petitions
//
//  Created by Emirhan KARAHAN on 21.06.2022.
//

import Foundation

struct Petition: Codable {
    var title:String
    var body:String
    var signatureCount:Int
}
