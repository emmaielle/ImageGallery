//
//  ViewController.swift
//  ImageGallery
//
//  Created by Owner on 1/22/19.
//  Copyright © 2019 LittlePanda. All rights reserved.
//

import UIKit

class ImageGalleryViewController: UIViewController, UIDropInteractionDelegate, UICollectionViewDelegate, UICollectionViewDropDelegate, UICollectionViewDataSource   {
  
  // Variable holds text from previous view until load
  var collectionLabelText = ""
  @IBOutlet weak var collectionLabel: UILabel!
  
  
  @IBOutlet var imageCollectionView: UICollectionView! {
    didSet {
      imageCollectionView.dataSource =  self
      imageCollectionView.delegate = self
//      imageCollectionView.dragDelegate = self
      imageCollectionView.dropDelegate = self
      imageCollectionView.dragInteractionEnabled = false
    }
  }
  
  var imageFiles = [String]()
  var images = [UIImage]()
  var imageViews = [ImageView]()
  
//  var imageCollection =
  
  @IBOutlet weak var imageView: ImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
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
//    session.loadObjects(ofClass: NSURL.self) { nsurls in
//      if let url = nsurls.first as? URL {
//        self.imageFetcher.fetchNoBackup(url.imageURL)
//      }
//    }
//
//    imageFetcher = ImageFetcher() { (url, image) in
//      print("Fetching...")
//      DispatchQueue.main.async {
//        print("Main")
//        let cell = self.imageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: IndexPath(row: 0, section: 0))
//
//        if let imageCell = cell as? ImageCollectionViewCell
//        {
//          let newImage = ImageView()
//          newImage.backgroundImage = image
//          self.imageViews.append(newImage)
//          self.imageViews[0].sizeThatFits(image.size)
//
//          imageCell.sizeThatFits(image.size)
//          imageCell.imageView = newImage
//        }
//      }
//    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
  canHandle session: UIDropSession) -> Bool {
    return true;
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageViews.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
//
//    if let imageCell = cell as? ImageCollectionViewCell{
//      imageCell.imageURL = imageCollection[indexPath.item].url
//    }
//
//    return cell;
  }
  
  func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
    
    if let imageCell = cell as? ImageCollectionViewCell{
      imageCell.imageURL = [indexPath.item].url
    }
    
    return cell;
    
  }

//  func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//    <#code#>
//  }
  
  func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
      var destinationIndexPath: IndexPath
      if let indexPath = coordinator.destinationIndexPath
      {
        destinationIndexPath = indexPath
      }
      else
      {
        // Get last index path of collection view.
        let section = collectionView.numberOfSections - 1
        let row = collectionView.numberOfItems(inSection: section)
        destinationIndexPath = IndexPath(row: row, section: section)
      }
    
      switch coordinator.proposal.operation
      {
      case .move:
        //Add the code to reorder items
        break
        
      case .copy:
            coordinator.session.loadObjects(ofClass: NSURL.self) { nsurls in
              if let url = nsurls.first as? URL {
                self.imageFetcher.fetchNoBackup(url.imageURL)
              }
            }
        
            imageFetcher = ImageFetcher() { (url, image) in
              print("Fetching...")
              DispatchQueue.main.async {
                print("Main")
                let cell = self.imageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: IndexPath(row: 0, section: 0))
        
                if let imageCell = cell as? ImageCollectionViewCell
                {
                  let newImage = ImageView()
                  newImage.backgroundImage = image
                  self.imageViews.append(newImage)
                  self.imageViews[0].sizeThatFits(image.size)
        
                  imageCell.sizeThatFits(image.size)
                  imageCell.imageView = newImage
                }
              }
            }
        break
        
      default:
        return
      }
  }
  
  
  
  // move items in collection view
  func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let item = images.remove(at: sourceIndexPath.item)
    images.insert(item, at: destinationIndexPath.item)
    
  }
  
}
