//
//  StudentVouchersViewController.swift
//  IDFI
//
//  Created by IvánMS on 20/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit
import FirebaseDatabase

private let reuseIdentifier = "studentVoucherCell"

class StudentVouchersViewController: UITableViewController, StudentVouchersDelegate{
    
    @IBOutlet weak var fullNameLbl: UILabel!
    
    var vouchers = [Voucher]()
    var selectedStudent: Student!
    var selectedCert: Certificate!
    let status: [String] = ["Sin verificar","Verificado","No válido","Validado por administrador"]
    var noteTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = 140
        
        DatabaseService.shared.voucherRef.observeSingleEvent(of: .value) { (snapshot) in
            /* Se crea un arreglo temporal que guardará los objetos de tipo generación */
            var temporal = [Voucher]()
            for voucher in snapshot.children.allObjects as! [DataSnapshot]{
                /* Sí el identificador del voucher no le pertence al estudiante no lo agrega al array */
                if let data = voucher.value as? [String: AnyObject],
                    let studentId = data["studentId"] as? String, studentId != self.selectedStudent.id{
                    continue
                }
                if let data = voucher.value as? [String: AnyObject],
                    let amount = data["amount"] as? String,
                    let date = data["date"] as? String,
                let folio = data["folio"] as? String,
                    let imageURL = data["imageURL"] as? String,
                    let status = data["status"] as? Int,
                    let note = data["note"] as? String{
                    /* Se obtiene el comprobante del estudiante y se guarda en un array  */
                    temporal.append(Voucher(amount: Float(amount)!, folio: folio, date: date.toCustomDate, imageURL: imageURL, status: status,note: note))
                }
            }
            /* Se reasigna el arreglo temporal a la variable de la clase que se presentará en el table view*/
            self.vouchers = temporal
            self.tableView?.reloadData()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        fullNameLbl.text = selectedStudent.name + " " + selectedStudent.lastName
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vouchers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! StudentVouchersTableViewCell
        let voucher = vouchers[indexPath.row]
        cell.updateVoucher(voucher)
        // Configure the cell...
        cell.delegate = self
        
        
        return cell
    }

    func changedStatus(status: String,voucher: Voucher) {
        /* Desaparece el picker y muestra un alert para agregar una nota */
        view.endEditing(true)
        voucher.status = self.status.index(of: status)! /* Obtiene índice del array */
        alert("Estatus del comprobante", "Agregue una nota para describir el movimiento",voucher)
    }
    func alert(_ title: String,_ message: String,_ voucher: Voucher){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
            voucher.note = self.noteTextField.text!
            self.tableView?.reloadData()
        }))
        alert.addTextField { (textField: UITextField) in
            self.noteTextField = textField
            self.noteTextField.placeholder = "Nota"
        }
        
        present(alert,animated: true)
    }
    func noteText(textField: UITextField!) {
        noteTextField = textField
        noteTextField.placeholder = "note"
        
    }
    
    
    @IBAction func addVouchers(_ sender: Any) {
        let voucherNavBar = storyboard?.instantiateViewController(withIdentifier:"VoucherNavigationController") as! VoucherNavigationController
        voucherNavBar.student = selectedStudent
        voucherNavBar.selectedCert = selectedCert
        present(voucherNavBar, animated: true, completion: nil)
    }
    
    
    @IBAction func back(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
}
