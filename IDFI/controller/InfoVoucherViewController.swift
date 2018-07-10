//
//  InfoCertificateViewController.swift
//  IDFI
//
//  Created by IvánMS on 09/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit

class InfoVoucherViewController: UIViewController {
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var folioTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    var voucher: Voucher!

    
//    override func viewDidLoad() {
//        <#code#>
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        amountTextField.text = "\(voucher.amount)"
        folioTextField.text = voucher.folio
        dateTextField.text = voucher.date.toString(dateFormat: "yyyy/MMM/dd HH:mm:ss")
        
    }

    
    

}
