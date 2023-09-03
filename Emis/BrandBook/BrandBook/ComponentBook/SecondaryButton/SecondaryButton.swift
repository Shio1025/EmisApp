//
//  SecondaryButton.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 28.08.23.
//

import UIKit
import Combine

public class SecondaryButton: UIView {
    
    private var tapAction: (() -> Void)?
    
    private lazy var titleLabel: LocalLabel = {
        let view = LocalLabel()
        view.backgroundColor = .clear
        view.setAlignment(with: .center)
        return view
    }()
    
    private lazy var resourceView: ResourceView = {
        let view = ResourceView()
        view.backgroundColor = .clear
        view.isHidden = true
        return view
    }()
    
    private lazy var container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = .XS
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    public init() {
        super.init(frame: .zero)
        addSubviews()
        setUpUI()
        addConstraints()
    }
    
    public convenience init(model: SecondaryButtonModel) {
        self.init()
        bind(with: model)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func  addSubviews() {
        container.addArrangedSubview(resourceView)
        container.addArrangedSubview(titleLabel)
        addSubview(container)
    }
    
    private func setUpUI() {
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        container.top(toView: self, constant: .S)
        container.bottom(toView: self, constant: .S)
        container.left(toView: self, constant: .S)
        container.right(toView: self, constant: .S)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(by: .M)
    }
}

extension SecondaryButton {
    
    private func addAction(action: @escaping () -> Void) {
        isUserInteractionEnabled = true
        tapAction = action
        addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(viewDidTapped)))
    }
    
    @objc func viewDidTapped() {
        tapAction?()
    }
}

extension SecondaryButton {
    
    public func bind(with model: SecondaryButtonModel) {
        resourceView.isHidden = true
        titleLabel.isHidden = true
        if let titleModel = model.titleModel {
            titleLabel.bind(with: titleModel)
            titleLabel.changeTextColor(with: model.textColor)
            titleLabel.isHidden = false
        }
        
        addAction(action: model.action)
        backgroundColor = model.backgroundColor
        
        
        if let resourceModel = model.resourceType {
            resourceView.height(equalTo: .XL6)
            resourceView.width(equalTo: .XL6)
            resourceView.isHidden = false
            resourceView.bind(with: resourceModel)
        }
    }
}

public struct SecondaryButtonModel {
    let titleModel: LocalLabelModel?
    let backgroundColor: UIColor
    let textColor: UIColor
    let resourceType: ResourceType?
    let action: (() -> Void)
    
    public init(titleModel: LocalLabelModel? = nil,
                backgroundColor: UIColor = BrandBookManager.Color.Theme.Component.solid500.uiColor,
                textColor: UIColor = BrandBookManager.Color.General.white.uiColor,
                resourceType: ResourceType? = nil,
                action: @escaping (() -> Void)) {
        self.titleModel = titleModel
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.resourceType = resourceType
        self.action = action
    }
}
