//
//  DatabaseService.swift
//  IDFI
//
//  Created by IvánMS on 05/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//
let CHILD_STUDENTS = "students"
let CHILD_CERTIFICATES = "certificates"

import Foundation
import FirebaseDatabase

class DatabaseService{
    private static let _shared = DatabaseService()
    static var shared: DatabaseService{
        return _shared
    }
    var mainRef: DatabaseReference!{
        return Database.database().reference()
    }
    var studentRef: DatabaseReference!{
        return mainRef.child(CHILD_STUDENTS)
    }
    var certificateRef: DatabaseReference!{
        return mainRef.child(CHILD_CERTIFICATES)
    }
    
    
    
    
    var certificates: DatabaseReference{
        return mainRef.child(CHILD_CERTIFICATES)
    }
    func saveStudent(uuid: String) {
        let name: [String:AnyObject] = ["name": "" as AnyObject]
        self.studentRef.child(uuid).setValue(name)
    }
}
