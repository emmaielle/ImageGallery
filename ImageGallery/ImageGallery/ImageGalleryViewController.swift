//
//  ViewController.swift
//  ImageGallery
//
//  Created by Owner on 1/22/19.
//  Copyright © 2019 Moira Lasserre. All rights reserved.
//

import UIKit

class ImageGalleryViewController: UICollectionViewController, UIDropInteractionDelegate    {

//     Variable holds text from previous view until load
    var collectionLabelText = ""
    @IBOutlet weak var collectionLabel: UILabel!
  
    var imageFetcher: ImageFetcher!

  @IBOutlet var imageCollectionView: UICollectionView! {
    didSet {
      imageCollectionView.dataSource =  self
      imageCollectionView.delegate = self
    }
  }
  
  var images = [UIImage]()
//  var imageViews = [ImageView]()

   @IBOutlet weak var dropZone: UIView! {
        didSet { dropZone.addInteraction(UIDropInteraction(delegate: self))
        }
    }

    //   func draginteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem]

    // Indicate which types of items we will accept
    // i want only drags that have an image and the url for that image
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool
    {
        return session.canLoadObjects(ofClass: UIImage.self) && session.canLoadObjects(ofClass: NSURL.self)
    }

    // return our drop proposal.
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal
    {
      // always going to be dragged from outside our app in this case
        return UIDropProposal(operation: .copy)
    }

    // Handle drop
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession)
    {
      imageFetcher = ImageFetcher() {
        (url, image) in
        DispatchQueue.main.async {
          self.images.append(image)
          self.collectionView.reloadData()
          
        }
      }
      session.loadObjects(ofClass: NSURL.self, completion: { nsurls in
        if let url = nsurls.first as? URL {
          self.imageFetcher.fetch(url)
        }
      })
      session.loadObjects(ofClass: UIImage.self, completion: { images in
        if let image = images.first as? UIImage {
          self.imageFetcher.backup = image
        }
      })
    }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)

    if let imageCell = cell as? ImageCollectionViewCell{
      imageCell.image?.image = images[indexPath.item]
    }

    return cell;
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
