//
//  BannerView.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 25.08.23.
//

import UIKit

public class BannerView: UIView {
    
    private var tapAction: (() -> Void)?
    
    private lazy var resourceView: ResourceView = {
        let view = ResourceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.height(equalTo: .XL6 + .XL6 + .L)
        view.width(equalTo: .XL6 + .XL5)
        return view
    }()
    
    private lazy var topLabel: LocalLabel = {
        let label = LocalLabel()
        label.backgroundColor = .clear
        label.setAlignment(with: .left)
        return label
    }()
    
    private lazy var chevronItem: ResourceView = {
        let view = ResourceView()
        view.bind(with: .icon(icon: UIImage(systemName: "chevron.right")!,
                              tintColor: BrandBookManager.Color.Theme.Invert.tr500.uiColor))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.height(equalTo: .XL2)
        view.width(equalTo: .XL2)
        return view
    }()
    
    private lazy var bottomLabel: LocalLabel = {
        let label = LocalLabel()
        label.backgroundColor = .clear
        label.setAlignment(with: .left)
        return label
    }()
    
    private lazy var labelContainer: UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [topLabel,
                                                            bottomLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    public init() {
        super.init(frame: .zero)
        addSubviews()
        setUpUI()
        addConstraints()
    }
    
    public convenience init(model: BannerViewModel) {
        self.init()
        bind(model: model)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func  addSubviews() {
        addSubview(resourceView)
        addSubview(labelContainer)
        addSubview(chevronItem)
    }
    
    private func setUpUI() {
        isUserInteractionEnabled = true
        backgroundColor = BrandBookManager.Color.Theme.Background.layer.uiColor
    }
    
    private func addConstraints() {
        resourceView.top(toView: self)
        resourceView.bottom(toView: self)
        resourceView.left(toView: self, constant: .M)
        
        labelContainer.relativeLeft(toView: resourceView, constant: .S)
        labelContainer.width(equalTo: 200)
        labelContainer.centerVertically(to: self)
        
        chevronItem.right(toView: self, constant: .M)
        chevronItem.centerVertically(to: self)
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        roundCorners(by: .M)
    }
}

extension BannerView {
    
    public func bind(model: BannerViewModel) {
        reset()
        addAction(action: model.action)
        
        resourceView.bind(with: model.resourceType)
        topLabel.bind(with: model.topLabelModel)
        
        if let bottomLabelModel = model.bottomLabelModel {
            bottomLabel.bind(with: bottomLabelModel)
            bottomLabel.isHidden = false
        }
        
        chevronItem.isHidden = !model.isChevronNeeded
    }
    
    private func reset() {
        bottomLabel.isHidden = true
    }
    
    private func addAction(action: @escaping () -> Void) {
        tapAction = action
        addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(viewDidTapped)))
    }
    
    @objc func viewDidTapped() {
        tapAction?()
    }
}

