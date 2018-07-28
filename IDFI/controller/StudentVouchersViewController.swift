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
    var isStudent: Bool = false
    let status: [String] = ["Sin verificar","Verificado","No válido","Validado por administrador"]
    let noteText = "note"
    let statusText = "status"
    var noteTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = 140
        appearRightBtn(isStudent) /* Si es alumno muestra el btn para agregar comprobantes */
        DatabaseService.shared.voucherRef.observeSingleEvent(of: .value) { (snapshot) in
            /* Se crea un arreglo temporal que guardará los objetos de tipo voucher */
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
                    let note = data["note"] as? String,
                    let id = data["id"] as? String{
                    /* Se obtiene el comprobante del estudiante y se guarda en un array  */
                    temporal.append(Voucher(amount: Float(amount)!, folio: folio, date: date.toCustomDate, imageURL: imageURL, status: status,note: note,id: id))
                }
            }
            /* Se reasigna el arreglo temporal a la variable de la clase que se presentará en el table view*/
            self.vouchers = temporal
            self.tableView?.reloadData()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        fullNameLbl.text = selectedStudent.name + " " + selectedStudent.lastName
        self.tableView.reloadData()
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
        /* Si es estudiante no deja editar el status */
        if isStudent{
            cell.statusText.isEditable = false
            cell.statusText.isSelectable = false
        }
        return cell
    }

    func changedStatus(status: String,voucher: Voucher) {
        /* Desaparece el picker y muestra un alert para agregar una nota */
        view.endEditing(true)
        voucher.status = self.status.index(of: status)! /* Obtiene índice del array */
        alert("Estatus del comprobante", "Agregue una nota para describir el movimiento",voucher)
    }
    func alert(_ title: String,_ message: String,_ selectedVoucher: Voucher){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
            selectedVoucher.note = self.noteTextField.text!
            self.tableView?.reloadData()
            /* Se actualiza la nota en el voucher al que corresponde el id */
            let id = selectedVoucher.id
            let newNote = selectedVoucher.note
            let newStatus = selectedVoucher.status
            DatabaseService.shared.voucherRef.child(id).child(self.noteText).setValue(newNote)
            DatabaseService.shared.voucherRef.child(id).child(self.statusText).setValue(newStatus)

        }))
        alert.addTextField { (textField: UITextField) in
            self.noteTextField = textField
            self.noteTextField.placeholder = "Nota"
        }
        
        present(alert,animated: true)
    }
    
    @objc func addVouchers() {
        let voucherNavBar = storyboard?.instantiateViewController(withIdentifier:"VoucherNavigationController") as! VoucherNavigationController
        voucherNavBar.student = selectedStudent
        voucherNavBar.selectedCert = selectedCert
        present(voucherNavBar, animated: true, completion: nil)
    }
    
    
    @IBAction func back(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
    func appearRightBtn(_ isStudent: Bool) {
        let rightBtn: UIButton = {
            let btn = UIButton()
            btn.setImage(#imageLiteral(resourceName: "add_voucher"), for: .normal)
            btn.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
            return btn
        }()
        if isStudent{
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
            rightBtn.addTarget(self, action: #selector(addVouchers), for: .touchUpInside)
        }else{
            self.navigationItem.leftBarButtonItem?.image = UIImage(named: "back")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /* Si se desea hacer zoom se le pasa la imágen */
        switch segue.identifier {
        case "showZoom"?:
            /* Checamos que fila se seleccionó */
            if let row = tableView.indexPathForSelectedRow?.row {
                /* Tomamos el voucher selccionado y se le pasa la imagen */
                let voucher = vouchers[row]
                let zoomImageViewController = segue.destination as! ZoomImageViewController
                zoomImageViewController.selectedVoucher = voucher
            }
        default:
            preconditionFailure("Identificador de segue inesperado")
        }
    }
}
