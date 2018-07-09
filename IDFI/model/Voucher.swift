//
//  Voucher.swift
//  IDFI
//
//  Created by IvánMS on 09/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import Foundation
class Voucher: NSObject {
    var name: String
    var amount: Float
    var folio: String
    let date: Date
    var imageURL: String?
    
    
    init(name: String, amount: Float, folio: String,date: Date,imageURL: String) {
        self.name = name
        self.amount = amount
        self.folio = folio
        self.date = Date()
        self.imageURL = imageURL
        
        super.init()
    }
    convenience init(random: Bool = false) {
        if random {
            self.init(name: "nombre", amount: 10.0,folio: "folio", date: Date(), imageURL: "url")
        } else {
            self.init(name: "", amount: 0.0,folio: "folio", date: Date(), imageURL: "")
            
        }
    }
}
