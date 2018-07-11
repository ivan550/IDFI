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
        let nav = topViewController as! VoucherViewController
        nav.voucherStore = voucherStore
        nav.voucherImageStore = voucherImageStore
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func appMovedToBackground() {
        print("App moved to background!")
        let success = voucherStore.saveChanges()
        if (success) {
            print("Se guardaron todos los comprobantes")
        } else {
            print("No se han podido guardar los comprobantes ")
        }
    }

}
