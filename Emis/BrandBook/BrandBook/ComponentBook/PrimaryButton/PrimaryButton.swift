//
//  PrimaryButton.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 17.05.23.
//

import UIKit

public enum ButtonState {
    case enabled
    case disabled
    case loading
}

public class PrimaryButton: UIView {
    
    private var tapAction: (() -> Void)?
    
    private var state: ButtonState = .enabled {
        didSet {
            updateButtonAppearance()
        }
    }
    
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
        view.height(equalTo: .XL5)
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
        configure(with: model)
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
    
    public func setState(with state: ButtonState) {
        self.state = state
    }
    
    private func updateButtonAppearance() {
        switch state {
        case .enabled:
            mainView.backgroundColor = PrimaryButtonState.enabled.backgroundColor
            titleLabel.changeTextColor(with: PrimaryButtonState.enabled.textColor)
            mainView.isUserInteractionEnabled = true
            
        case .disabled:
            mainView.backgroundColor = PrimaryButtonState.disabled.backgroundColor
            titleLabel.changeTextColor(with: PrimaryButtonState.disabled.textColor)
            mainView.isUserInteractionEnabled = false
        case .loading:
            mainView.backgroundColor = PrimaryButtonState.loading.backgroundColor
            titleLabel.changeTextColor(with: PrimaryButtonState.loading.textColor)
            mainView.isUserInteractionEnabled = true
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
    
    public func configure(with model: PrimaryButtonModel) {
        titleLabel.configure(with: model.titleModel)
        addAction(action: model.action)
    }
}
