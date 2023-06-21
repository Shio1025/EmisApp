//
//  ResourceView.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 19.06.23.
//

import Lottie
import UIKit
import SDWebImage

public class ResourceView: UIView {
    
    let imageView : UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.isHidden = true
        return image
    }()
    
    let ovalImage : UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.isHidden = true
        return image
    }()
    
    let animationView: AnimationView = {
        let view = AnimationView()
        view.isHidden = true
        view.contentMode = .scaleAspectFit
        view.backgroundBehavior = .pauseAndRestore
        return view
    }()
    
    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView.init(
            arrangedSubviews: [
                imageView,
                animationView,
                ovalImage
            ])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    public init() {
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    public required init?(coder : NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        setupUI()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        self.addSubview(containerStackView)
    }
    
    private func setupUI() {
        backgroundColor = .clear
    }
    
    private func setupConstraints() {
        containerStackView.top(toView: self)
        containerStackView.bottom(toView: self)
        containerStackView.right(toView: self)
        containerStackView.left(toView: self)
    }
    
    public func bind(with imageType: ResourceType) {
        reset()
        switch imageType {
        case .image(let image):
            configureImage(withImage: image)
        case .url(let imageURL):
            configureImage(withUrl: imageURL)
        case .animation(let model):
            configureAnimation(withAnimationModel: model)
        case .ovalIcon(let iconModel):
            configureOvalIcon(with: iconModel)
        case .icon(let icon, let tintColor):
            configureIcon(withIcon: icon, tintColor: tintColor)
        }
    }
    
    private func reset() {
        imageView.isHidden = true
        animationView.isHidden = true
        ovalImage.isHidden = true
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        ovalImage.roundCorners(by: ovalImage.bounds.height/2)
        
        ovalImage.layer.borderColor = BrandBookManager.Color.Theme.Invert.tr300.cgColor
    }
}

extension ResourceView {
    
    private func configureImage(withImage image: UIImage) {
        imageView.isHidden = false
        imageView.image = image
    }
    
    private func configureIcon(withIcon icon: UIImage, tintColor: UIColor) {
        imageView.isHidden = false
        imageView.image = icon
        imageView.tintColor = tintColor
    }
    
    private func configureImage(withUrl url: URL?) {
        imageView.isHidden = false
        imageView.sd_setImage(with: url) { image, _, _, _ in
            self.imageView.image = image ?? BrandBookManager.Icon.mortarboard.image
        }
    }
    
    private func configureAnimation(withAnimationModel animation: LottieModel) {
        animationView.isHidden = false
        
        animationView.animation = .named(animation.animationName,
                                         bundle: animation.bundle)
        animationView.loopMode = animation.loopMode
        animationView.play()
    }
    
    private func configureOvalIcon(with iconModel: OvalIconModel) {
        ovalImage.isHidden = false
        ovalImage.image = iconModel.icon
        ovalImage.tintColor = iconModel.tintColor
        ovalImage.layer.borderWidth = iconModel.borderIsNeeded ? 1 : 0
    }
}
