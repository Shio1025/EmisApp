//
//  GpaBannerCell.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 03.09.23.
//

import UIKit
import Lottie

public class GpaBannerCell: TableCell {
    
    private lazy var topLabel: LocalLabel = {
        let label = LocalLabel()
        label.backgroundColor = .clear
        label.setAlignment(with: .center)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let animationView: AnimationView = {
        let animation = AnimationView()
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.backgroundBehavior = .pauseAndRestore
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .loop
        animation.width(equalTo: 150)
        animation.height(equalTo: 150)
        return animation
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        addSubviews()
        setUpUI()
        addConstraints()
    }
    
    private func  addSubviews() {
        contentView.addSubview(topLabel)
        contentView.addSubview(animationView)
    }
    
    private func setUpUI() {
        selectionStyle = .none
        backgroundColor = BrandBookManager.Color.Theme.Background.layer.uiColor
    }
    
    private func addConstraints() {
        topLabel.centerHorizontally(to: contentView)
        topLabel.top(toView: contentView, constant: .S)
        topLabel.relativeBottom(toView: animationView)
        
        animationView.bottom(toView: contentView)
        animationView.left(toView: contentView)
        animationView.right(toView: contentView)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(by: .M)
    }
}

extension GpaBannerCell {
    public func bind(with data: any CellModel) {
        if let model = data as? GpaBannerCellModel {
            self.topLabel.bind(with: model.text)
            animationView.animation = .named(model.lottie.animationName,
                                             bundle: model.lottie.bundle)
            animationView.loopMode = model.lottie.loopMode
            animationView.play()
        }
    }
}

public class GpaBannerCellModel: CellModel {
    public typealias T = GpaBannerCell
    var text: LocalLabelModel
    var lottie: LottieModel
    
    public init(text: LocalLabelModel,
                lottie: LottieModel) {
        self.text = text
        self.lottie = lottie
    }
}

