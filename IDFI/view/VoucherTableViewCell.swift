//
//  VoucherTableViewCell.swift
//  IDFI
//
//  Created by IvánMS on 09/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit

class VoucherTableViewCell: UITableViewCell {
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var folioLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        amountLbl.adjustsFontForContentSizeCategory = true
        folioLbl.adjustsFontForContentSizeCategory = true
        dateLbl.adjustsFontForContentSizeCategory = true
        self.accessoryView = UIImageView(image: #imageLiteral(resourceName: "edit"))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    /* Actualizará los campos en cada celda del tableview */
    func updateVoucher(_ voucher: Voucher,_ image: UIImage?){
        self.amountLbl.text = String(voucher.amount)
        self.folioLbl.text = voucher.folio
        self.dateLbl.text = voucher.date.toString()
        self.img.image = image ?? UIImage(named: "voucher")
    }
    
}
