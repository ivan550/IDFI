//
//  extensions.swift
//  IDFI
//
//  Created by IvánMS on 09/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit
let locale = Locale(identifier: "es_MX")

extension Date{
    func toString() -> String
    {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = "dd/MMM/yyyy"
        return dateFormatter.string(from: self)
    }
}
extension String {
    var toCustomDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: self)!
    }
}
