//
//  Voucher.swift
//  IDFI
//
//  Created by IvánMS on 09/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit
class Voucher: NSObject, NSCoding {
    
    var amount: Float
    var folio: String
    var date: Date
    var imageURL: String?
    var image: UIImage? 
    let voucherKey: String
    var status: Int?
    var note: String
    var id: String
    
    
    
    init(amount: Float, folio: String,date: Date,imageURL: String,status: Int,note: String,id: String) {
        self.amount = amount
        self.folio = folio
        self.date = Date()
        self.imageURL = imageURL
        self.voucherKey = UUID().uuidString
        self.status = status
        self.note = note
        self.id = id
        super.init()
    }
    convenience init(random: Bool = false) {
        if random {
            self.init(amount: 0.0,folio: "", date: Date(), imageURL: "",status: 0,note: "",id:"")
        } else {
            self.init(amount: 0.0,folio: "folio", date: Date(), imageURL: "",status: 0,note: "",id:"")
            
        }
    }
    /* Dos métodos que conforman el protocolo NSCoding para poder guardar en el sandbox de la app */
    func encode(with aCoder: NSCoder) {
        aCoder.encode(amount,forKey: "amount")
        aCoder.encode(folio,forKey: "folio")
        aCoder.encode(date,forKey: "date")
        aCoder.encode(imageURL,forKey: "imageURL")
        aCoder.encode(voucherKey,forKey: "voucherKey")
        aCoder.encode(status,forKey: "status")
        aCoder.encode(note,forKey: "note")
        aCoder.encode(note,forKey: "id")

    }
    
    required init?(coder aDecoder: NSCoder) {
        self.amount = aDecoder.decodeFloat(forKey: "amount")
        self.folio = aDecoder.decodeObject(forKey: "folio") as! String
        self.date = aDecoder.decodeObject(forKey: "date") as! Date
        self.imageURL = aDecoder.decodeObject(forKey: "imageUrl") as! String?
        self.voucherKey = aDecoder.decodeObject(forKey: "voucherKey") as! String
        self.status = aDecoder.decodeObject(forKey: "status") as! Int?
        self.note = aDecoder.decodeObject(forKey: "note") as! String
        self.id = aDecoder.decodeObject(forKey: "id") as! String
        super.init()
    }
}
