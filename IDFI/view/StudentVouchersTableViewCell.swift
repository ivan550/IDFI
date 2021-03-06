//
//  StudentVouchersTableViewCell.swift
//  IDFI
//
//  Created by IvánMS on 20/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit
import FirebaseStorage

protocol StudentVouchersDelegate {
    func changedStatus(status: String,voucher: Voucher)
}

class StudentVouchersTableViewCell: UITableViewCell, UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var voucherImg: UIImageView!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var folioLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var noteText: UITextView!
    @IBOutlet weak var statusText: UITextView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let status: [String] = ["Sin verificar","Verificado","No válido","Validado por administrador"]
    let symbol = "$"
    var selectedStatus: String!
    var delegate: StudentVouchersDelegate?
    var selectedvoucher: Voucher!

    override func awakeFromNib() {
        super.awakeFromNib()

        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.backgroundColor = UIColor(named: "background")
        toolBar.tintColor = UIColor(named: "FI")
        let doneButton = UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(changedStatus))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton,doneButton], animated: false)
        
        toolBar.isUserInteractionEnabled = true
        
        let picker = UIPickerView()
        picker.backgroundColor = UIColor(named: "background")
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        /* Se agrega el toolbar y el UIPicker al textField */
        statusText.inputView = picker
        statusText.inputAccessoryView = toolBar
    }
    func styleImage() {
        self.spinner.startAnimating()
    }
    func updateImage(imageURL: String,voucher: Voucher) {
        let httpRef = Storage.storage().reference(forURL: imageURL)
        httpRef.getData(maxSize: 8*1024*1024, completion: { (data, error) in
            if error != nil{
                print(error!.localizedDescription)
                return
            }else{
                DispatchQueue.main.async(execute: {
                    voucher.image = UIImage(data: data!)
                    self.voucherImg.image = voucher.image
                    self.spinner.stopAnimating()
                    self.spinner.isHidden = true
                    
                })
            }
            
        })
    }
    func updateVoucher(_ voucher: Voucher)  {
        amountLbl.text = symbol+String(voucher.amount)
        folioLbl.text = voucher.folio
        dateLbl.text = voucher.date.toString()
        statusText.text = status[voucher.status!]
        noteText.text = voucher.note
        styleImage()
        updateImage(imageURL: voucher.imageURL!,voucher: voucher)
        /* Se recupera el voucher seleccionado */
        selectedvoucher = voucher
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return status.count
    }
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return status[0]
    }
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        statusText.text = status[row]
        selectedStatus = statusText.text
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textColor = UIColor(named: "first")
        label.textAlignment = .center
        label.text = status[row]
        return label
    }

    @objc
    func changedStatus(){
        /* La vista principal se encarga de desaparecer y hacer el cambio del estatus */
        delegate?.changedStatus(status: selectedStatus,voucher: selectedvoucher)
    }
}
