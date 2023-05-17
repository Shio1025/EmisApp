//
//  LocalLabel.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 16.05.23.
//

import UIKit

public class LocalLabel: UIView {
    
    private var tapAction: (() -> Void)?
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isUserInteractionEnabled = false
        return label
    }()
    
    public init() {
        super.init(frame: .zero)
        addSubviews()
        setUpUI()
        addConstraints()
    }
    
    public convenience init(model: LocalLabelModel) {
        self.init()
        addSubviews()
        setUpUI()
        addConstraints()
        configure(with: model)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func  addSubviews() {
        self.addSubview(label)
    }
    
    private func setUpUI() {
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        label.top(toView: self)
        label.bottom(toView: self)
        label.left(toView: self)
        label.right(toView: self)
    }
}

extension LocalLabel {
    
    public func configure(with model: LocalLabelModel) {
        label.text = model.text
        label.textColor = model.color
        label.font = model.font
        if let action = model.action { configureAction(action: action) }
    }
    
    private func configureAction(action: @escaping () -> Void) {
        label.isUserInteractionEnabled = true
        self.tapAction = action
        label.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(didTap)))
    }
    
    @objc private func didTap() {
        tapAction?()
    }
    
    public func changeTextColor(with color: UIColor) {
        label.textColor = color
    }
}
