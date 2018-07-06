//
//  DatabaseService.swift
//  IDFI
//
//  Created by IvánMS on 05/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

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
        return mainRef.child("students")
    }
    
    
    
    
    var certificates: DatabaseReference{
        return mainRef.child("certificates")
    }
    func saveStudent(uuid: String) {
        let name: [String:AnyObject] = ["name": "" as AnyObject]
        self.studentRef.child(uuid).child("name").setValue(name)
    }
}
