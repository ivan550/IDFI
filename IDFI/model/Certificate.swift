//
//  Certificate.swift
//  IDFI
//
//  Created by IvánMS on 05/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit

class Certificate: NSObject{
    var id: Int
    var name: String
    var image: UIImage
    var places: Int
    
    init(id: Int,name: String,image: UIImage,places: Int) {
        self.id = id
        self.name = name
        self.image = image
        self.places = places
    }
}
