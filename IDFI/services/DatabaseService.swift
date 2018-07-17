//
//  DatabaseService.swift
//  IDFI
//
//  Created by IvánMS on 05/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//
let CHILD_STUDENTS = "students"
let CHILD_CERTIFICATES = "certificates"
let CHILD_GENERATIONS = "generations"

import Foundation
import FirebaseDatabase
import FirebaseStorage

class DatabaseService{
    private static let _shared = DatabaseService()
    static var shared: DatabaseService{
        return _shared
    }
    /* Referencias a la base de datos */
    var mainRef: DatabaseReference!{
        return Database.database().reference()
    }
    var studentRef: DatabaseReference!{
        return mainRef.child(CHILD_STUDENTS)
    }
    var certificateRef: DatabaseReference!{
        return mainRef.child(CHILD_CERTIFICATES)
    }
    var generationRef: DatabaseReference!{
        return mainRef.child(CHILD_GENERATIONS)
    }
    /* Referencias al storage */
    var storageRef: StorageReference{
        return Storage.storage().reference()
    }
    var imageStoreRef: StorageReference{
        return storageRef.child("certificatesImages")
    }
    var mainStorageRef: StorageReference{
        return Storage.storage().reference(forURL: "gs://idfi-7c378.appspot.com")
    }
    var vouchersStorageRef: StorageReference{
        return mainStorageRef
    }

    
    func saveStudent(uuid: String) {
        let name: [String:AnyObject] = ["name": "" as AnyObject]
        self.studentRef.child(uuid).setValue(name)
    }
    
}
