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
        dump(selectedCert)
        // Do any additional setup after loading the view.
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
    @IBAction func cancelRegister(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func registerUser(_ sender: UIButton) {
        continueRegister()
        //        performSegue(withIdentifier: "showStudentForm", sender: continueRegister())
    }
    @IBAction func pressedLogin(_ sender: UIButton) {
        //        performSegue(withIdentifier: "showLogin", sender: nil)
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /* Sí el segue disparado es editVoucher */
        switch segue.identifier {
        case "showStudentForm"?:
            let studentForm = segue.destination as! StudentFormViewController
            studentForm.selectedCert = selectedCert
        case "showLogin"?:
            let login = segue.destination as! LoginViewController
            login.selectedCert = selectedCert
        default:
            preconditionFailure("Identificador de segue inesperado")
        }
    }
    func continueRegister() {
        /* Se valida la existencia de los datos */
        if let email = self.emailTextField.text,
            let password = self.passwordTextField.text,
            (!email.isEmpty && !password.isEmpty){
            AuthService.shared.registerUser(email: email, password: password,onComplete: {(message,data) in
                guard message == nil else{
                    self.alert(title: "Error", message: message!)
                    return
                }
                print(data!)
                
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
