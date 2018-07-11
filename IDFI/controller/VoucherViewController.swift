//
//  VoucherViewController.swift
//  IDFI
//
//  Created by IvánMS on 09/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit

class VoucherViewController: UITableViewController{
    var voucherStore: VoucherStore!
    var voucherImageStore: VoucherImageStore!
    
    /* Coloca el item en el navigation controller para poder editar algún renglón */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
        editButtonItem.title = "Borrar"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addPaddingToTop() /* Espacio en la parte superior para el collectionView */
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 117
        /* Se le dá transparencia al navigation bar */
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return voucherStore.allIVouchers.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "voucherCell", for: indexPath) as! VoucherTableViewCell
        let voucher = voucherStore.allIVouchers[indexPath.row]
        cell.updateVoucher(voucher)
        
        // Configure the cell...
        
        return cell
    }
    override func tableView(_ tableView: UITableView,commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        /* Si se selecciona eliminar, se recupera el índice del row seleccionado */
        if editingStyle == .delete {
            let voucher = voucherStore.allIVouchers[indexPath.row]
            
            /* Antes de eliminar manda un alert */
            let title = "¿Eliminar Comprobante?"
            let message = "¿Estàs seguro que deseas eliminar el comprobante?"
            let alert = UIAlertController(title: title,message: message,preferredStyle: .actionSheet)
            
            /* Asigna las acciones dependiendo de la seleccionada */
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            let deleteAction = UIAlertAction(title: "Eliminar", style: .destructive, handler: { (action) -> Void in
                /* Se elemina tanto del store como de la tabla */
                self.voucherStore.removeVoucher(voucher)
                self.voucherImageStore.deleteImage(forKey: voucher.voucherKey)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            alert.addAction(deleteAction)
            present(alert, animated: true, completion: nil)
        }
    }
    override func tableView(_ tableView: UITableView,moveRowAt sourceIndexPath: IndexPath,to destinationIndexPath: IndexPath) {
        /* Actualiza en el store */
        voucherStore.moveVoucher(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
//    @IBAction func addNewItem(_ sender: UIButton) {
   @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        /* Se crea primero el voucher y se agrega al store */
        let newVoucher = voucherStore.createVoucher()
        /* Se buscado dónde está tal elemento en el array */
        if let index = voucherStore.allIVouchers.index(of: newVoucher) {
            let indexPath = IndexPath(row: index, section: 0)
            /* Agrega el nuevo renglón a la tabla */
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        // If you are currently in editing mode...
        if isEditing {
            /* Cambia el texto del botón para informar al usuario el estado */
            sender.setTitle("Borrar", for: .normal)
            setEditing(false, animated: true) /* Termina el modo edición */
        } else {
            /* Cambia el texto del botón para informar al usuario el estado */
            sender.setTitle("Ok", for: .normal)
            setEditing(true, animated: true) /* Cambia a modo edición */
        }
    }
    
    func addPaddingToTop() {
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /* Sí el segue disparado es editVoucher */
        switch segue.identifier {
        case "editVoucher"?:
            /* Checamos que fila se seleccionó */
            if let row = tableView.indexPathForSelectedRow?.row {
                /* Tomamos el voucher selccionado y se lo pasamos al controlador que llenará los datos del comprobante */
                let voucher = voucherStore.allIVouchers[row]
                let infoVoucherViewController = segue.destination as! InfoVoucherViewController
                infoVoucherViewController.voucher = voucher
                infoVoucherViewController.voucherImageStore = voucherImageStore
                infoVoucherViewController.voucherNum = row
                print(row)
            }
        default:
            preconditionFailure("Identificador de segue inesperado")
        }
    }
    
}
