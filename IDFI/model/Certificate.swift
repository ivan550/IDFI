//
//  Certificate.swift
//  IDFI
//
//  Created by IvánMS on 05/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit

class Certificate: NSObject{
    var name: String
    var imageURL: String
    var places: Int
    
    init(name: String,imageURL: String ,places: Int) {
        self.name = name
        self.imageURL = imageURL
        self.places = places
    }
}
