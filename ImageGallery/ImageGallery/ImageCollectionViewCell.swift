//
//  ImageCollectionViewCell.swift
//  ImageGallery
//
//  Created by Moira Lasserre on 2/23/19.
//  Copyright © 2019 LittlePanda. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
 
  @IBOutlet var image: UIImageView!
  
    var vSpinner: UIView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var isLoading = true {
        didSet {
            if isLoading {
                self.showSpinner(onView: self)
            } else {
                self.removeSpinner()
            }

        }
    }
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .gray)
        ai.startAnimating()
        ai.center = spinnerView.center

        print("subview \(ai.center)")
        print("subview \(onView.bounds)")
        spinnerView.addSubview(ai)
        onView.addSubview(spinnerView)

        vSpinner = spinnerView
    }

    func removeSpinner() {
        self.vSpinner?.removeFromSuperview()
        self.vSpinner = nil
    }

//    override func prepareForReuse() {
//        super.prepareForReuse()
//        image.image = nil
//        isLoading = true
//    }
    
}
