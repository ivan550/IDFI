//
//  Student.swift
//  IDFI
//
//  Created by IvánMS on 12/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit

class Student: NSObject {
    var id: String
    var name: String
    var lastName: String
    var degreeOption: Bool
    var language: Bool
    var socialService: Bool
    var profileAcadem: Bool
    var certificateId: String
    
    init(name: String, lastName: String,language: Bool?,socialService: Bool?,profileAcadem: Bool,certificateId: String,id: String,degreeOption: Bool?) {
        
        self.name = name
        self.lastName = lastName
        self.language = language ?? false
        self.socialService = socialService ?? false
        self.profileAcadem = profileAcadem
        self.certificateId = certificateId
        self.id = id
        self.degreeOption = degreeOption ?? false
        super.init()
    }
}
