//
//  Voucher.swift
//  IDFI
//
//  Created by IvánMS on 09/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit
class Voucher: NSObject, NSCoding {
    
    var name: String
    var amount: Float
    var folio: String
    let date: Date
    var imageURL: String?
    var image: UIImage? = UIImage(named: "voucher")!
    let voucherKey: String
    
    
    
    init(name: String, amount: Float, folio: String,date: Date,imageURL: String) {
        self.name = name
        self.amount = amount
        self.folio = folio
        self.date = Date()
        self.imageURL = imageURL
        self.voucherKey = UUID().uuidString
        super.init()
    }
    convenience init(random: Bool = false) {
        if random {
            self.init(name: "", amount: 10.0,folio: "", date: Date(), imageURL: "")
        } else {
            self.init(name: "", amount: 0.0,folio: "folio", date: Date(), imageURL: "")
            
        }
    }
    /* Dos métodos que conforman el protocolo NSCoding para poder guardar en el sandbox de la app */
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name,forKey: "name")
        aCoder.encode(amount,forKey: "amount")
        aCoder.encode(folio,forKey: "folio")
        aCoder.encode(date,forKey: "date")
        aCoder.encode(imageURL,forKey: "imageURL")
        aCoder.encode(voucherKey,forKey: "voucherKey")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.amount = aDecoder.decodeFloat(forKey: "amount")
        self.folio = aDecoder.decodeObject(forKey: "folio") as! String
        self.date = aDecoder.decodeObject(forKey: "date") as! Date
        self.imageURL = aDecoder.decodeObject(forKey: "imageUrl") as! String?
        self.voucherKey = aDecoder.decodeObject(forKey: "voucherKey") as! String
        super.init()
    }
}
