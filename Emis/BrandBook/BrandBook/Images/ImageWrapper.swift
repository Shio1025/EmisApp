//
//  ImageWrapper.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 03.05.23.
//

import UIKit

public struct ImageWrapper: ResourceWrappable {
    private let name: String
    
    public init(name: String) { self.name = name }
    
    var designSystemName: String {
        return self.name
    }
    
    static var bundle: Bundle? = Bundle(identifier: "Shio.BrandBook")

    // UIImage  of selected image
    public var image: UIImage {
        return UIImage(named: name, in: Self.bundle, compatibleWith: nil)!
    }

    // UIImage with template rendering mode
    public var template: UIImage {
        return image.withRenderingMode(.alwaysTemplate)
    }
}

public extension UIImage {
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let scaleFactor = min(widthRatio, heightRatio)
        let newSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
