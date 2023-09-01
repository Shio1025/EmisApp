//
//  PrimaryButton.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 17.05.23.
//

import UIKit
import Combine

public enum ButtonState {
    case enabled
    case disabled
    case loading
}

public class PrimaryButton: UIView {
    
    private var tapAction: (() -> Void)?
    
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.style = .medium
        loader.isHidden = true
        return loader
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.height(equalTo: .XL6)
        return view
    }()
    
    private lazy var titleLabel: LocalLabel = {
        let view = LocalLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    public init() {
        super.init(frame: .zero)
        addSubviews()
        setUpUI()
        addConstraints()
    }
    
    public convenience init(model: PrimaryButtonModel) {
        self.init()
        bind(with: model)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func  addSubviews() {
        mainView.addSubview(titleLabel)
        mainView.addSubview(loadingIndicator)
        addSubview(mainView)
    }
    
    private func setUpUI() {
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        titleLabel.centerVertically(to: mainView)
        titleLabel.centerHorizontally(to: mainView)
        
        loadingIndicator.right(toView: mainView, constant: .M)
        loadingIndicator.centerVertically(to: mainView)
        
        mainView.top(toView: self, constant: .S)
        mainView.bottom(toView: self, constant: .S)
        mainView.left(toView: self, constant: .XL3)
        mainView.right(toView: self, constant: .XL3)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        mainView.layer.cornerRadius = .M
        mainView.clipsToBounds = true
    }
}

extension PrimaryButton {
    
    private func updateButtonState(with state: ButtonState) {
        switch state {
        case .enabled:
            mainView.backgroundColor = PrimaryButtonState.enabled.backgroundColor
            titleLabel.changeTextColor(with: PrimaryButtonState.enabled.textColor)
            mainView.isUserInteractionEnabled = true
            loadingIndicator.stopAnimating()
            loadingIndicator.isHidden = true
        case .disabled:
            mainView.backgroundColor = PrimaryButtonState.disabled.backgroundColor
            titleLabel.changeTextColor(with: PrimaryButtonState.disabled.textColor)
            mainView.isUserInteractionEnabled = false
            loadingIndicator.stopAnimating()
            loadingIndicator.isHidden = true
        case .loading:
            mainView.backgroundColor = PrimaryButtonState.loading.backgroundColor
            titleLabel.changeTextColor(with: PrimaryButtonState.loading.textColor)
            mainView.isUserInteractionEnabled = false
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
        }
    }
    
    private func addAction(action: @escaping () -> Void) {
        tapAction = action
        mainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(viewDidTapped)))
    }
    
    @objc func viewDidTapped() {
        tapAction?()
    }
}

extension PrimaryButton {
    
    public func bind(with model: PrimaryButtonModel) {
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
