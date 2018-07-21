//
//  StudentFormViewController.swift
//  IDFI
//
//  Created by IvánMS on 04/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit
import FirebaseAuth
class StudentFormViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var profileTextField: UITextField!
    @IBOutlet weak var degreeOptionSwch: UISwitch!
    @IBOutlet weak var socialServiceSwch: UISwitch!
    @IBOutlet weak var languageSwch: UISwitch!
    
    /* Elementos que se mostrará dependiendo de lo que ingrese el alumno */
    @IBOutlet weak var degreeOptionStack: UIStackView!
    @IBOutlet weak var hiddenLbl: UILabel!
    @IBOutlet weak var dataComplementStack: UIStackView!
    @IBOutlet weak var basicFormStack: UIStackView!
    
    //    let student: Student!
    var selectedCert: Certificate!
    let myPickerData = [String](arrayLiteral: "Publico en general", "Alumno FI", "Comunidad UNAM")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Tap para desaparecer el teclado cuando se seleccione otro lugar de la vista */
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.delegate = self as? UIGestureRecognizerDelegate
        view.addGestureRecognizer(tap)
        degreeOptionSwch.addTarget(self, action:#selector(valueChange),for:UIControlEvents.valueChanged)
        createPicker()
        /* Eventos que cuando cambian los campos de textos se verifica si están vacíos, si no se habilita el botón para continuar */
        nameTextField.addTarget(self, action: #selector(isEmpty), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(isEmpty), for: .editingChanged)
        profileTextField.addTarget(self, action: #selector(isEmpty), for: .editingChanged)

        /* Cerrar sessión*/
        //         let firebaseAuth = Auth.auth()
        //        do {
        //            try firebaseAuth.signOut()
        //        } catch let signOutError as NSError {
        //            print ("Error signing out: %@", signOutError)
        //        }
        
        //        /* Borrar cuenta del auth */
        //        AuthService.shared.user?.delete(completion: { (error) in
        //            if error != nil {
        //                // An error happened.
        //                print("No se pudo crear la cuenta")
        //            } else {
        //                // Account deleted.
        //                print("Cuenta borrada del auth")
        //            }
        //        })
        //        print(AuthService.shared.user!.uid)
    }
    override func viewWillAppear(_ animated: Bool) {
//        welcomeLbl.text = "Bienvenido al diplomado: \(selectedCert.name)"
        isEmpty()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createPicker() {
        let picker = UIPickerView()
        picker.backgroundColor = .black
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        /* Se agrega el toolbar y el UIPicker al textField */
        profileTextField.inputView = picker
        profileTextField.inputAccessoryView = toolBar
        profileTextField.text = myPickerData.first!
    }
    let toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.backgroundColor = .black
        toolBar.tintColor = .red
        let doneButton = UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(visible))
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
        return myPickerData[0]
    }
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        profileTextField.text = myPickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        label.text = myPickerData[row]
        return label
    }
    
    /* Se oculta el teclado cada que se presione enter  o se presiona en otro lugar de la vista */
    @objc
    func handleTap() {
        view.endEditing(true)
    }
    @objc
    func visible() {
        view.endEditing(true) /* Desaparece el teclado */
        dataComplementStack.isHidden = true
        basicFormStack.distribution = .fillProportionally
        hiddenLbl.isHidden = false
        //        socialServiceSwch.isOn = false
        languageSwch.isOn = false
        /* Se depliega otro campo en los siguientes casos */
        if profileTextField.text == "Alumno FI" || profileTextField.text == "Comunidad UNAM"{
            degreeOptionStack.isHidden = false
            degreeOptionSwch.isOn = false
            return
        }
        degreeOptionStack.isHidden = true
        hiddenLbl.isHidden = false
    }
    @objc
    func valueChange(mySwitch: UISwitch) {
        let value = mySwitch.isOn
        guard value else{
            hiddenLbl.isHidden = false
            dataComplementStack.isHidden = true
            basicFormStack.distribution = .fillProportionally
            socialServiceSwch.isOn = false
            languageSwch.isOn = false
            return
        }
        hiddenLbl.isHidden = true
        dataComplementStack.isHidden = false
        basicFormStack.distribution = .equalSpacing
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func addVouchers(_ sender: UIBarButtonItem) {
        if let name = nameTextField.text,let lastName = lastNameTextField.text,let profile = profileTextField.text{
            let certId = selectedCert.id
            let prof = profile
            let language = languageSwch.isOn
            let socialService = socialServiceSwch.isOn
            let degreeOption = degreeOptionSwch.isOn
            let studentId = AuthService.shared.user?.uid
            /* Se creal al estudiante */
            let student = Student(name: name, lastName: lastName, language: language, socialService: socialService, profileAcadem: prof, certificateId: certId,id: studentId!,degreeOption: degreeOption)
            /* Se mandan datos al navigation bar que controlará cuando se agregén comprobantes y se presenta */
            let voucherNavBar = storyboard?.instantiateViewController(withIdentifier: "VoucherNavigationController") as! VoucherNavigationController
            voucherNavBar.student = student
            voucherNavBar.selectedCert = selectedCert
            present(voucherNavBar, animated: true, completion: nil)
        }
        
    }
    
    @objc
    func isEmpty() {
        if let name = nameTextField.text, !name.isEmpty,let lastName = lastNameTextField.text,!lastName.isEmpty,let profile = profileTextField.text,!profile.isEmpty{
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }else{
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
    }
    
}

