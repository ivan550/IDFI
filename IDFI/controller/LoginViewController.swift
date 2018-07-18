//
//  ViewController.swift
//  IDFI
//
//  Created by IvánMS on 24/06/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: DesignTextField!
    @IBOutlet weak var passwordTextField: DesignTextField!
    var selectedCert: Certificate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dump(selectedCert)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    /* Se oculta el teclado cada que se presione enter o se presiona en otro lugar de la vista*/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func loginPressed(_ sender: Any) {
        /* Se valida la existencia de los datos */
        if let email = self.emailTextField.text,
            let password = self.passwordTextField.text,
            (!email.isEmpty && !password.isEmpty){
            AuthService.shared.loginUser(email: email, password: password, onComplete: {(message,data) in
                guard message == nil else{
                    self.alert(title: "Error", message: message!)
                    return
                }
                dump(data!)
            })
        }else{
            let alert = UIAlertController(title: "Usuario y contraseña incorrectos", message: "Ingrese usuario y contraseña para continuar", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert,animated: true)
        }
    }
    func alert(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert,animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /* Sí el segue disparado es editVoucher */
        switch segue.identifier {
        case "showGenerations"?:
            /* Tomamos el voucher selccionado y se lo pasamos al controlador que llenará los datos del comprobante */
            let generationViewController = segue.destination as! GenerationsViewController
            generationViewController.selectedCert = self.selectedCert
        default:
            preconditionFailure("Identificador de segue inesperado")
        }
    }
    
    
}

