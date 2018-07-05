//
//  StudentFormViewController.swift
//  IDFI
//
//  Created by IvánMS on 04/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit

class StudentFormViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    let studentForm: StudenFormView  = {
        let view = StudenFormView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.delegate = self as? UIGestureRecognizerDelegate
        view.addGestureRecognizer(tap)
        view.addSubview(studentForm)
        textFieldDelagates()
        NSLayoutConstraint.activate([
            studentForm.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            studentForm.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            studentForm.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            studentForm.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            ])
        createPicker()
        studentForm.getSendBtn().addTarget(self, action: #selector(sendData), for: .touchUpInside)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    let myPickerData = [String](arrayLiteral: "Publico en general", "Alumno FI", "Comuniddad UNAM")
    func createPicker() {
        let picker = UIPickerView()
        picker.backgroundColor = .black
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        /* Se agrega el toolbar y el UIPicker al textField */
        studentForm.getFieldPicker().inputView = picker
        studentForm.getFieldPicker().inputAccessoryView = toolBar
    }
    let toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.backgroundColor = .black
        toolBar.tintColor = .red
        let doneButton = UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(StudenFormView.handleTap))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }()
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData.count
    }
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerData[row]
    }
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        studentForm.getFieldPicker().text = myPickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        label.text = myPickerData[row]
        return label
    }
    
    /* Se oculta el teclado cada que se presione enter  o se presiona en otro lugar de la vista*/
    @objc
    func handleTap() {
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        studentForm.getNameField().resignFirstResponder()
        studentForm.getLastNameField().resignFirstResponder()
        return true
    }
    func textFieldDelagates() {
        studentForm.getNameField().delegate = self
        studentForm.getLastNameField().delegate = self
    }
    @objc func sendData() {
        print("Send data")
        
    }
    
}

