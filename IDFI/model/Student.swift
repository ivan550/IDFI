//
//  Student.swift
//  IDFI
//
//  Created by IvánMS on 12/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit

class Student: NSObject {
    var name: String
    var lastName: String
    var language: Bool?
    var socialService: Bool?
    var profileAcadem: Bool
    var certificateId: String
    
    init(name: String, lastName: String,language: Bool,socialService: Bool,profileAcadem: Bool,certificateId: String) {
        
        self.name = name
        self.lastName = lastName
        self.language = language
        self.socialService = socialService
        self.profileAcadem = profileAcadem
        self.certificateId = certificateId
        
        super.init()
    }
}
