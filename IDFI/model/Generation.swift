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
    var students = [Student]()
    
    init(name: String,student: Student) {
        self.students.append(student)
        self.name = name
        super.init()
    }
}
