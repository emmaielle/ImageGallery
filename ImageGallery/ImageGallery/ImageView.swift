//
//  ImageView.swift
//  ImageGallery
//
//  Created by Moira Lasserre on 2/23/19.
//  Copyright © 2019 LittlePanda. All rights reserved.
//

import UIKit

class ImageView: UIImageView {

    var backgroundImage: UIImage? { didSet { setNeedsDisplay() } }
  
    override func draw(_ rect: CGRect) {
      print("drawing ")
      backgroundImage?.draw(in: bounds)
    }
}
