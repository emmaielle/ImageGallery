//
//  ViewController.swift
//  ImageGallery
//
//  Created by Owner on 1/22/19.
//  Copyright © 2019 Moira Lasserre. All rights reserved.
//

import UIKit

class ImageGalleryViewController: UICollectionViewController, UIDropInteractionDelegate, UICollectionViewDelegateFlowLayout {
    
    
    // Variable holds text from previous view until load
    var collectionLabelText = ""
    @IBOutlet weak var collectionLabel: UILabel!
//    var imageFetcher: ImageFetcher!

    var cellWidth: CGFloat = 0.0
  
    @IBOutlet var imageCollectionView: UICollectionView! {
      didSet {
        imageCollectionView.dataSource =  self
        imageCollectionView.delegate = self
      }
    }
  
    var images = [Image]()
//    var images = [UIImage]()
    
    @IBOutlet weak var dropZone: UIView! {
        didSet { dropZone.addInteraction(UIDropInteraction(delegate: self))
        }
    }
    
    // DROP
  
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

    // Handle drop & fetch images
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession)
    {
        // Add the fetched image to the images array
        // search for any loading/placeholder image and add it there
//        imageFetcher = ImageFetcher() {
//            (url, image) in
//
////            DispatchQueue.main.async {
////                self.fillEmptyImage(data: image)
//////                self.collectionView.insertItems(at: [IndexPath(index: session.items.count - 1)])
////            }
//        }
        
      session.loadObjects(ofClass: NSURL.self, completion: { nsurls in
        if let url = nsurls.first as? URL {
            var imageDownloaded: UIImage?
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                if let data = try? Data(contentsOf: url.imageURL) {
                    if self != nil {
                        // yes, it's ok to create a UIImage off the main thread
                        if let image = UIImage(data: data) {
                            imageDownloaded = image
                        }
                    }
                    else {
                        print("ImageFetcher: fetch returned but I've left the heap -- ignoring result.")
                    }
                }
                DispatchQueue.main.async {
                    if let img = imageDownloaded {
                        self?.fillEmptyImage(data: img)
                    }
                }
//            self.imageFetcher.fetch(url)
            }
            
        };
      })
        
      session.loadObjects(ofClass: UIImage.self, completion: { images in
        if let image = images.first as? UIImage {
            let img = Image(placeholder: image)
            img.exists = false;
            self.images.append(img)
            self.collectionView.reloadData()

        }
      })
        
    }
  
    // COLLECTION VIEW
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
      return self.images.count
    }
  
    
    // Loads further cells
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)

      if let imageCell = cell as? ImageCollectionViewCell{
        let imageObject = images[indexPath.item]
        if !imageObject.exists {
            print("here 2")
            imageCell.isLoading = true
            imageCell.image?.image = images[indexPath.item].data

        }
        else {
            imageCell.isLoading = false
            imageCell.image?.image = images[indexPath.item].data
            print("image cell loaded \(cell)")
        }
      }
      return cell;
    }
  
    // Determines cells ratios
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let image = images[indexPath.item]
      let imageAspectRatio = image.data.size.height / image.data.size.width
      let newHeight = cellWidth * imageAspectRatio

      return CGSize(width: cellWidth, height: newHeight)
    }
  
    // Collection view Drag
    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Reorder collectionview
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let originImage = images.remove(at: sourceIndexPath.item)
        images.insert(originImage, at: destinationIndexPath.item)
    }

    // LOADS
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    override func viewDidLayoutSubviews() {
      cellWidth = view.frame.width / 5
    }
    
    func fillEmptyImage(data: UIImage) -> Void {
        var hasLoadingImage = false
        for i in self.images {
            if !i.exists {
                hasLoadingImage = true
                i.data = data
                i.exists = true
                self.collectionView.reloadData()
                return
            }
        }
        if !hasLoadingImage {
            let newImage = Image(placeholder: data)
            newImage.data = data
            newImage.exists = true
            self.images.append(newImage)
            self.collectionView.reloadData()
        }
        return
    }
}
