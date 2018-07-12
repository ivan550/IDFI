//
//  VoucherNavigationController.swift
//  IDFI
//
//  Created by IvánMS on 11/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit

class VoucherNavigationController: UINavigationController {
    let voucherStore = VoucherStore()
    let voucherImageStore = VoucherImageStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Se intancían los stores que guardarán los comprobantes que el alumno ingrese */
        let vvc = topViewController as! VoucherViewController
        vvc.voucherStore = voucherStore
        vvc.voucherImageStore = voucherImageStore
        
        /* Notification center ayudará a saber cuando entra en background y cuando esto suceda, los datos de los comprobantes que se estén registrando se guardarán en disco */
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func appMovedToBackground() {
        let success = voucherStore.saveChanges()
        if (success) {
            print("Se guardaron todos los comprobantes en disco")
        } else {
            print("No se han podido guardar los comprobantes en disco")
        }
    }

}
