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
let CHILD_VOUCHERS = "vouchers"
let STORAGE_URL =  "gs://idfi-7c378.appspot.com"

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
    var voucherRef: DatabaseReference!{
        return mainRef.child(CHILD_VOUCHERS)
    }
    /* Referencias al storage */
    var storageRef: StorageReference{
        return Storage.storage().reference()
    }
    var imageStoreRef: StorageReference{
        return storageRef.child("certificatesImages")
    }
    var vouchersImageStore: StorageReference{
        return storageRef.child(CHILD_VOUCHERS)
    }
    var mainStorageRef: StorageReference{
        return Storage.storage().reference(forURL: STORAGE_URL)
    }

    func saveStudent(_ student: Student,_ certificateId: String) {
        
        let std: [String:AnyObject] = [
            "rol": false as AnyObject,
            "certId": certificateId as AnyObject,
            "profile":[
                "name": student.name,
                "lastName": student.lastName,
                "language": student.language,
                "profileAcademic": student.profileAcadem,
                "socialService": student.socialService,
                "degreeOption": student.degreeOption
            ] as AnyObject
        ]
        self.studentRef.child(student.id).setValue(std)
        
    }
    func sendVouchers(_ voucher: Voucher){
        
        let voucher: [String:AnyObject] = [
            "amount": String(voucher.amount) as AnyObject,
            "date": voucher.date.toString() as AnyObject,
            "folio": voucher.folio as AnyObject,
            "imageURL": voucher.imageURL as AnyObject,
            "status": voucher.status as AnyObject,
            "studentId": AuthService.shared.user?.uid as AnyObject,
            "note": voucher.note as AnyObject
        ]
        self.voucherRef.childByAutoId().setValue(voucher)
        
        
    }
    func saveGeneration(_ generationKey: String,_ name: String,_ certId: String,_ studentId: String) {
        self.generationRef.child(generationKey).child("name").setValue(name)
        self.generationRef.child(generationKey).child("certId").setValue(certId)
        self.generationRef.child(generationKey).child("students").child(studentId).setValue(true)

    }
    
}
