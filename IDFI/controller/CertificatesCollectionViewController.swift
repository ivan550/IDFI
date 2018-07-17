//
//  CertificatesCollectionViewController.swift
//  IDFI
//
//  Created by IvánMS on 05/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

private let reuseIdentifier = "CertificateCell"

class CertificatesCollectionViewController: UICollectionViewController {
    
    
    var certificates = [Certificate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPaddingToTop() /* Espacio en la parte superior para el collectionView */
        DatabaseService.shared.certificateRef.observeSingleEvent(of: .value) { (snapshot) in
            print("snapshot\(snapshot)")
            
            var temporal = [Certificate]()
            for certificate in snapshot.children.allObjects as! [DataSnapshot]{
                let data = certificate.value as? [String: AnyObject]
                let id = certificate.key
                
                if let name = data!["name"] as? String,
                    let places = data!["places"] as? Int,
                    let imageURL = data!["imageURL"] as? String{
                    temporal.append(Certificate(id: id,name: name, imageURL: imageURL,places: places))
                    
                }
            }
            self.certificates = temporal
            self.collectionView?.reloadData()
            
            /* Se le dá transparencia al navigation bar */
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /* Sí el segue disparado es editVoucher */
        switch segue.identifier {
        case "showSignup"?:
            /* Checamos que fila se seleccionó */
            if let indexPath = collectionView?.indexPathsForSelectedItems?.first {
                /* Tomamos el voucher selccionado y se lo pasamos al controlador que llenará los datos del comprobante */
                let certificate = certificates[indexPath.row]
                let signup = segue.destination as! SignupViewController
                signup.selectedCert = certificate
                dump(certificate)
            }
        default:
            preconditionFailure("Identificador de segue inesperado")
        }
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return certificates.count
    }
    /*Se castea la celda como la que se está personalizando */
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CertificateCollectionViewCell
        /* Se obtiene el diplomados y se actualiza en cada celda */
        let certificate = self.certificates[indexPath.row]
        cell.updateCertificate(certificate: certificate)
        return cell
    }
    func addPaddingToTop(){
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        collectionView?.contentInset = insets
        collectionView?.scrollIndicatorInsets = insets
    }
    
}
