//
//  Generations.swift
//  IDFI
//
//  Created by IvánMS on 12/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit

class Generation: NSObject{
    var name: String
    var id: String?
    var studentsId: [String]
    
    init(name: String,id: String?,studentsId: [String]) {
        self.name = name
        self.id = id
        self.studentsId = studentsId
        super.init()
    }
}
