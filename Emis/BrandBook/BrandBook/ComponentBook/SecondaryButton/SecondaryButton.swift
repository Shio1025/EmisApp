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
    
    private var subscriptions = Set<AnyCancellable>()
    
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
    
    private func updateButtonState(with state: ButtonState) {
        switch state {
        case .enabled:
            backgroundColor = PrimaryButtonState.enabled.backgroundColor
            titleLabel.changeTextColor(with: PrimaryButtonState.enabled.textColor)
            isUserInteractionEnabled = true
        case .disabled:
            backgroundColor = PrimaryButtonState.disabled.backgroundColor
            titleLabel.changeTextColor(with: PrimaryButtonState.disabled.textColor)
            isUserInteractionEnabled = false
        case .loading:
            backgroundColor = PrimaryButtonState.loading.backgroundColor
            titleLabel.changeTextColor(with: PrimaryButtonState.loading.textColor)
            isUserInteractionEnabled = false
        }
    }
    
    private func addAction(action: @escaping () -> Void) {
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
        
        //subscribe state
        model.state.sink { [weak self] state in
            self?.updateButtonState(with: state)
        }.store(in: &subscriptions)
    }
    
    public func resetSubscriptions() {
        subscriptions = Set<AnyCancellable>()
    }
}

public struct SecondaryButtonModel {
    let titleModel: LocalLabelModel
    var state: AnyPublisher<ButtonState, Never>
    let action: (() -> Void)
    
    public init(titleModel: LocalLabelModel,
                state: AnyPublisher<ButtonState, Never>,
                action: @escaping (() -> Void)) {
        self.titleModel = titleModel
        self.state = state
        self.action = action
    }
}
