//
//  Image.swift
//  ImageGallery
//
//  Created by Moira Lasserre on 3/24/19.
//  Copyright © 2019 LittlePanda. All rights reserved.
//

import UIKit
import Foundation

class Image {
    
    var data: UIImage
    var exists = false
    var imageIndex: Int?
    static var index = 0
    
    init(placeholder: UIImage) {
        Image.index += 1
        self.imageIndex = Image.index
        self.data = UIImage(color: .red, size: CGSize(width: placeholder.size.width, height: placeholder.size.height))!
    }

}


public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

//    func fetch(_ url: URL){
//        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
//            if let data = try? Data(contentsOf: url.imageURL) {
//                if self != nil {
//                    // yes, it's ok to create a UIImage off the main thread
//                    if let image = UIImage(data: data) {
//                        self?.data = image
//                        self?.exists = true
//                    } else {
//                        self?.data = nil
//                        self?.exists = false
//                    }
//                } else {
//                    print("ImageFetcher: fetch returned but I've left the heap -- ignoring result.")
//                }
//            } else {
//                self?.exists = false
//            }
//        }
//    }
//}
//
//// I always retrieve the current last index of an image
//
//extension UIImage
//{
//    private static let localImagesDirectory = "UIImage.storeLocallyAsJPEG"
//
//    static func urlToStoreLocallyAsJPEG(named: String) -> URL? {
//        var name = named
//        let pathComponents = named.components(separatedBy: "/")
//        if pathComponents.count > 1 {
//            if pathComponents[pathComponents.count-2] == localImagesDirectory {
//                name = pathComponents.last!
//            } else {
//                return nil
//            }
//        }
//        if var url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
//            url = url.appendingPathComponent(localImagesDirectory)
//            do {
//                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
//                url = url.appendingPathComponent(name)
//                if url.pathExtension != "jpg" {
//                    url = url.appendingPathExtension("jpg")
//                }
//                return url
//            } catch let error {
//                print("UIImage.urlToStoreLocallyAsJPEG \(error)")
//            }
//        }
//        return nil
//    }
//}
//
//extension URL {
//    var imageURL: URL {
//        if let url = UIImage.urlToStoreLocallyAsJPEG(named: self.path) {
//            // this was created using UIImage.storeLocallyAsJPEG
//            return url
//        } else {
//            // check to see if there is an embedded imgurl reference
//            for query in query?.components(separatedBy: "&") ?? [] {
//                let queryComponents = query.components(separatedBy: "=")
//                if queryComponents.count == 2 {
//                    if queryComponents[0] == "imgurl", let url = URL(string: queryComponents[1].removingPercentEncoding ?? "") {
//                        return url
//                    }
//                }
//            }
//            return self.baseURL ?? self
//        }
//    }
//}
