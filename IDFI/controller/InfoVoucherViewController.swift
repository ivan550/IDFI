//
//  InfoCertificateViewController.swift
//  IDFI
//
//  Created by IvánMS on 09/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit

class InfoVoucherViewController: UIViewController,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var folioTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    var voucherStore: VoucherStore!
    var voucherImageStore: VoucherImageStore!
    var voucherNum: Int?
    
    var voucher: Voucher!
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true) /* Desaparece el teclado en caso de que se esté usando */
        /* Se guardan los campos introducidos */
        voucher.folio = folioTextField.text ?? ""
        voucher.date = dateTextField.text!.toCustomDate
        if let amount = amountTextField.text, let value = Float(amount){
            voucher.amount = value
        } else {
            voucher.amount = 0.00
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let voucherNum = voucherNum{
            navigationItem.title = "Comprobante: \(voucherNum+1)"
        }
        setData()
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String: Any]) {
        /* Se toma la imágen que se seleccionó */
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        /* Cuando se toma la foto se quita la cámara y la coloca en la vista y la almacena */
        imageView.image = image
        voucherImageStore.setImage(image, forKey: voucher.voucherKey)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func takePicture(_ sender: UIButton) {
        /* Si se puede acceder a la cámara se abre sino se elije una existente */
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self /* Se debe indicar que su delegado será este controlador */
        /* Se presenta de forma modal la cámara */
        present(imagePicker, animated: true, completion: nil)
    }
    /* Funciones para desaparecer el teclado cuando se pulse intro u otro lugar de la vista */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        amountTextField.resignFirstResponder()
        folioTextField.resignFirstResponder()
        return true
    }
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    func setData(){
        /* Coloca los datos cuando aparecerá la vista */
        amountTextField.text = "\(voucher.amount)"
        folioTextField.text = voucher.folio
        dateTextField.text = voucher.date.toString()
        let key = voucher.voucherKey
        /* Si se tiene una imágen asociada la coloca */
        if let imageToDisplay = voucherImageStore.image(forKey: key){
            imageView.image = imageToDisplay
        }
    }
    func showDatePicker(){
        /* Formato al datePicker */
        let loc = Locale(identifier: "es_MX")
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = UIColor(named: "background")
        datePicker.setValue(UIColor(named: "first"), forKeyPath: "textColor")
        datePicker.locale = loc
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(donedatePicker));
        doneButton.tintColor = UIColor(named: "FI")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([spaceButton,doneButton], animated: false)
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
}
