//
//  SignupViewController.swift
//  IDFI
//
//  Created by IvánMS on 04/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var selectedCert: Certificate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        passwordTextField.text = ""
        emailTextField.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /* Se oculta el teclado cada que se presione enter  o se presiona en otro lugar de la vista*/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func registerUser(_ sender: UIButton) {
        continueRegister()
    }
    @IBAction func pressedLogin(_ sender: UIButton) {
        
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /* Sí el segue disparado es editVoucher */
        switch segue.identifier {
        case "showLogin"?:
            let login = segue.destination as! LoginViewController
            login.selectedCert = selectedCert
        default:
            preconditionFailure("Identificador de segue inesperado")
        }
    }
    func continueRegister(){
        /* Se valida la existencia de los datos */
        if let email = self.emailTextField.text,
            let password = self.passwordTextField.text,
            (!email.isEmpty && !password.isEmpty){
            AuthService.shared.registerUser(email: email, password: password,onComplete: {(message,data) in
                guard message == nil else{
                    self.alert(title: "Error", message: message!)
                    return
                }
                /* Si todo sale bien se pasa a la siguiente vista */
                let studentForm = self.storyboard?.instantiateViewController(withIdentifier: "StudentFormViewController")  as! StudentFormViewController
                studentForm.selectedCert = self.selectedCert
                self.present(studentForm, animated: true, completion: nil)
            })
        }else{
            alert(title:"Usuario y contraseña incorrectos", message: "Ingrese usuario y contraseña para continuar")
        }
    }
    func alert(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert,animated: true)
    }
    
}
