//
//  StudentVouchersTableViewCell.swift
//  IDFI
//
//  Created by IvánMS on 20/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit
import FirebaseStorage

class StudentVouchersTableViewCell: UITableViewCell {

    @IBOutlet weak var voucherImg: UIImageView!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var folioLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var noteText: UITextView!
    @IBOutlet weak var statusText: UITextView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let status: [String] = ["Sin verificar","Verificado","No válido","Validado por administrador"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func styleImage() {
        self.spinner.startAnimating()
//        voucherImg.translatesAutoresizingMaskIntoConstraints = false
//        voucherImg.layer.cornerRadius = 20
//        voucherImg.layer.masksToBounds = true
    }
    func updateImage(imageURL: String) {
        let httpRef = Storage.storage().reference(forURL: imageURL)
        httpRef.getData(maxSize: 8*1024*1024, completion: { (data, error) in
            if error != nil{
                print(error!.localizedDescription)
                return
            }else{
                DispatchQueue.main.async(execute: {
                    self.voucherImg?.image = UIImage(data: data!)
                    self.spinner.stopAnimating()
                    self.spinner.isHidden = true
                })
            }
            
        })
    }
    func updateVoucher(_ voucher: Voucher)  {
        amountLbl.text = String(voucher.amount)
        folioLbl.text = voucher.folio
        dateLbl.text = voucher.date.toString()
        statusText.text = status[Int(voucher.status!)]
        styleImage()
        updateImage(imageURL: voucher.imageURL!)
    }

}
