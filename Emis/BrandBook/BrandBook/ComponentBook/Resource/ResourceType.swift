//
//  ResourceType.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 19.06.23.
//

import UIKit
import Lottie

public enum ResourceType {
    case image(image: UIImage)
    case url(imageURL: URL?)
    case animation(model: LottieModel)
    case ovalIcon(ovalIconModel: OvalIconModel)
}

public struct LottieModel {
    var animationName: String
    var bundle: Bundle
    var loopMode: LottieLoopMode
    
    public init(animationName: String,
                bundle: Bundle,
                loopMode: LottieLoopMode = .loop) {
        self.animationName = animationName
        self.bundle = bundle
        self.loopMode = loopMode
    }
}

public struct OvalIconModel {
    var icon: UIImage
    var tintColor: UIColor
    var backgroundColor: UIColor
    var borderIsNeeded: Bool = false
    
    public init(icon: UIImage,
                tintColor: UIColor,
                backgroundColor: UIColor,
                borderIsNeeded: Bool) {
        self.icon = icon
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        self.borderIsNeeded = borderIsNeeded
    }
}
