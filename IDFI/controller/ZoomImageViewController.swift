//
//  ZoomImageViewController.swift
//  IDFI
//
//  Created by IvánMS on 26/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit

class ZoomImageViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedVoucher: Voucher!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        imageView.image = selectedVoucher.image!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    

}
