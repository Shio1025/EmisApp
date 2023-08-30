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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.setAlignment(with: .center)
        return view
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
        addSubview(titleLabel)
    }
    
    private func setUpUI() {
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        titleLabel.top(toView: self, constant: .S)
        titleLabel.bottom(toView: self, constant: .S)
        titleLabel.left(toView: self, constant: .S)
        titleLabel.right(toView: self, constant: .S)
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
        titleLabel.bind(with: model.titleModel)
        addAction(action: model.action)
    
        backgroundColor = model.backgroundColor
        titleLabel.changeTextColor(with: model.textColor)
        
    }
}

public struct SecondaryButtonModel {
    let titleModel: LocalLabelModel
    let backgroundColor: UIColor
    let textColor: UIColor
    let action: (() -> Void)
    
    public init(titleModel: LocalLabelModel,
                backgroundColor: UIColor = BrandBookManager.Color.Theme.Component.solid500.uiColor,
                textColor: UIColor = BrandBookManager.Color.General.white.uiColor,
                action: @escaping (() -> Void)) {
        self.titleModel = titleModel
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.action = action
    }
}
