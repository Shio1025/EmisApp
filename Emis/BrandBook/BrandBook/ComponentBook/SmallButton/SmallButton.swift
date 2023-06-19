//
//  SmallButton.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 19.06.23.
//

import UIKit
import Combine

public class SmallButton: UIView {
    
    private var tapAction: (() -> Void)?
    
    private lazy var resourceView: ResourceView = {
        let view = ResourceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.height(equalTo: .L)
        view.width(equalTo: .L)
        return view
    }()

    public init() {
        super.init(frame: .zero)
        addSubviews()
        setUpUI()
        addConstraints()
    }
    
    public convenience init(model: SmallButtonViewModel) {
        self.init()
        bind(model: model)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func  addSubviews() {
        self.addSubview(resourceView)
    }
    
    private func setUpUI() {
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        resourceView.top(toView: self)
        resourceView.bottom(toView: self)
        resourceView.left(toView: self)
        resourceView.right(toView: self)
    }
}

extension SmallButton {
    
    public func bind(model: SmallButtonViewModel) {
        resourceView.bind(with: model.resourceType)
        configureAction(action: model.action)
    }
    
    private func configureAction(action: @escaping () -> Void) {
        resourceView.isUserInteractionEnabled = true
        self.tapAction = action
        resourceView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
    }
    
    @objc private func didTap() {
        tapAction?()
    }
}
