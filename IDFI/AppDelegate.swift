//
//  AppDelegate.swift
//  IDFI
//
//  Created by IvánMS on 24/06/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit
import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
//    let voucherStore = VoucherStore()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        /* Se crean los stores */
//        let voucherImageStore = VoucherImageStore()
        /* Indica al NavController que la vista top será será VVC por el comento */
//        let vouchersController = window!.rootViewController as! VoucherViewController
//        let navController = window!.rootViewController as! UINavigationController
//        let vouchersController = navController.topViewController as! VoucherViewController
//        vouchersController.voucherStore = voucherStore
//        vouchersController.voucherImageStore = voucherImageStore
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
//        let success = voucherStore.saveChanges()
//        if (success) {
//            print("Se guardaron todos los comprobantes")
//        } else {
//            print("No se han podido guardar los comprobantes ")
//        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

