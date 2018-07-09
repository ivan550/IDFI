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
    var selectedCert: [String:Certificate] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatabaseService.shared.certificateRef.observeSingleEvent(of: .value) { (snapshot) in
            print("snapshot\(snapshot)")
            
            var temporal = [Certificate]()
            for user in snapshot.children.allObjects as! [DataSnapshot]{
                let data = user.value as? [String: AnyObject]
            
                if let name = data!["name"] as? String,
                    let places = data!["places"] as? Int,
                    let imageURL = data!["imageURL"] as? String{
                    temporal.append(Certificate(name: name, imageURL: imageURL,places: places))

                }
            }
            self.certificates = temporal
            self.collectionView?.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
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
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Diplomado seleccionado")
        performSegue(withIdentifier: "showRegister", sender: nil)
    }
    
    func downloadCertificateInfo()  {
        
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
