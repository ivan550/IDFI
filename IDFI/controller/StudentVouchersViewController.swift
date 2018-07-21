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

class StudentVouchersViewController: UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet weak var fullNameLbl: UILabel!
    
    var vouchers = [Voucher]()
    var selectedStudent: Student!
    let status: [String] = ["Sin verificar","Verificado","No válido","Validado por administrador"]
    var selectedPicker: IndexPath!
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
                    let status = data["status"] as? Int8,
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
        let picker = UIPickerView()
        picker.backgroundColor = .black
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        /* Se agrega el toolbar y el UIPicker al textField */
        cell.statusText.inputView = picker
        cell.statusText.inputAccessoryView = toolBar
        selectedPicker = indexPath
        
        
        return cell
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation
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
        /* Se recupera la celda seleccionada y se cambia en el texto seleccionado */
        let cl = tableView.cellForRow(at: selectedPicker) as! StudentVouchersTableViewCell
        cl.statusText.text = status[row]
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        label.text = status[row]
        return label
    }
    @objc
    func visible() {
        view.endEditing(true) /* Desaparece el teclado */
    }

}
