//
//  BackBarButtonItem.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 06.06.23.
//
import UIKit

public class BackBarButtonItem: UIBarButtonItem {
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = BrandBookManager.Color.General.black.uiColor
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backButtonTapped)))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = BrandBookManager.Color.Theme.Background.layer.uiColor
//        view.layer.borderWidth = 1
//        view.layer.borderColor = BrandBookManager.Color.Theme.Background.popup.cgColor
        return view
    }()
    
    var backButtonTappedAction: (() -> Void)?
    
    override init() {
        super.init()
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        addSubviews()
        setupConstraints()
    }
    
    private func setupConstraints() {
        button.top(toView: containerView)
        button.bottom(toView: containerView)
        button.left(toView: containerView)
        button.right(toView: containerView)
       
        containerView.width(equalTo: .XL4)
        containerView.height(equalTo: .XL4)
        containerView.layer.cornerRadius = .XL4 / 2
    }
    
    private func addSubviews() {
        containerView.addSubview(button)
        customView = containerView
    }
    
    @objc private func backButtonTapped() {
        backButtonTappedAction?()
    }
}
