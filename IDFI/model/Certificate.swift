//
//  Certificate.swift
//  IDFI
//
//  Created by IvánMS on 05/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit

class Certificate: NSObject{
    var id: String
    var name: String
    var imageURL: String
    var places: Int
    
    init(id: String,name: String,imageURL: String ,places: Int) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.places = places
    }
}
