//
//  VoucherViewController.swift
//  IDFI
//
//  Created by IvánMS on 09/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit
import FirebaseStorage

class VoucherViewController: UITableViewController{
    var voucherStore: VoucherStore!
    var voucherImageStore: VoucherImageStore!
    var student: Student!
    var selectedCert: Certificate!
    let typeImages = "image/jpeg"
    let finishTitle = "¡Registro completo!"
    let finishMessage = "Gracias por registrarse, recibirá una notificación cuando sus datos hayan sido verificados"
    let errorTitle = "Hubo un error"
    let leftBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPaddingToTop() /* Espacio en la parte superior para el collectionView */
        /* Se le dá transparencia al navigation bar */
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        /* Se introduce un botón personalizado para regresar */
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        leftBtn.addTarget(self, action: #selector(dissmissView), for: .touchUpInside)
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
        /* Se crea la celda de tipo personalizada, recuperamos los datos de la celda y los actualizamos */
        let cell = tableView.dequeueReusableCell(withIdentifier: "voucherCell", for: indexPath) as! VoucherTableViewCell
        let voucher = voucherStore.allIVouchers[indexPath.row]
        let image = voucherImageStore.image(forKey: voucher.voucherKey)
        cell.updateVoucher(voucher,image)
        
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
    @IBAction func addNewItem(_ sender: UIButton) {
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
            }
        default:
            preconditionFailure("Identificador de segue inesperado")
        }
    }
    @IBAction func sendData(_ sender: UIBarButtonItem) {
        
        print("Enviando datos ")
        let alert = sendingDataAlert()
        /*Se recuperan los comprobantes agregados y la referencia al storage donde se subirán las imégenes */
        let ref = DatabaseService.shared.mainStorageRef
        let vouchers = voucherStore.allIVouchers
        
        /*  Se incluye el tipo de dato que se subirá */
        let metaData = StorageMetadata()
        metaData.contentType = typeImages
        
        for voucher in vouchers{
            let refVouchers = ref.child("vouchers/\(UUID().uuidString).jpg")
            
            /* Se recupera la imagen */
            if let img = voucherImageStore.image(forKey: voucher.voucherKey),
                let imageData = UIImageJPEGRepresentation(img, CGFloat(0.05)){
                
                /* Se sube la imágen*/
                _ = refVouchers.putData(imageData, metadata: metaData) { (metadata, error) in
                    guard let _ = metadata else {
                        self.alert(self.errorTitle,error!.localizedDescription)
                        return
                    }
                    /* Se obtiene la url de la imagen para descargar */
                    refVouchers.downloadURL { (url, error) in
                        guard url != nil else {
                            self.alert(self.errorTitle,error!.localizedDescription)
                            return
                        }
                        voucher.imageURL = url!.absoluteString
                        let genKey = self.calculateGeneration(self.selectedCert.id)
                        let studentId = AuthService.shared.user?.uid
                        let student = self.student
                        let certId = self.selectedCert.id
                        DatabaseService.shared.sendVouchers(voucher)
                        DatabaseService.shared.saveStudent(student!,certId)
                        DatabaseService.shared.saveGeneration(genKey.first!, genKey.last!, certId, studentId!)
                        /* Cuando se terminan la acción se oculta el alert de procesando y aparece un msj final al usuario */
                        alert.dismiss(animated: true, completion: nil)
                        self.alert(self.finishTitle,self.finishMessage)
                        self.voucherStore.removeAll()
                        /* Se regresa a la vista de los diplomados */
                    }
                    
                }
                
            }
            
            
        }
    }
    func calculateGeneration(_ certKey: String) -> [String] {
        /* Se construye una clave para la generación actual en la que se registrará */
        let gen = "gen"
        let date = Date()
        let calendar = Calendar.current
        /* Extrae las iniciales del diplomado seleccionado */
        let indexStartOfText = certKey.index(certKey.startIndex, offsetBy: 11)
        let sub = certKey[indexStartOfText...]
        /* Se obtiene el año y el ciclo escolar */
        var year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let cycle = month >= 7 ? 1 : 2
        year = month >= 7 ? year+1 : year
        
        let genKey = "\(gen)\(sub)\(year)-\(cycle)" //genDAM2018-2
        let name = "Generación \(year)-\(cycle)"
        return [genKey,name]
    }
    func sendingDataAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Registrando", message: "Por favor espera...", preferredStyle: .alert)
        alert.view.tintColor = .black
        let  activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 15, width: 50, height: 50))
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.startAnimating()
        alert.view.addSubview(activityIndicator)
        present(alert,animated: true)
        return alert
    }

    func alert(_ title: String,_ message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert,animated: true)
    }
    @objc
    func dissmissView() {
        /* Si se regresa a la vista anterior se guardan los comprobantes ingresados */
        self.dismiss(animated: true, completion: nil)
        let success = voucherStore.saveChanges()
        if (success) {
            print("Se guardaron todos los comprobantes en disco")
        } else {
            print("No se han podido guardar los comprobantes en disco")
        }
    }
    
    
}
