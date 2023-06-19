//
//  PageDescription.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 19.06.23.
//

import UIKit
import Combine

public class PageDescription: UIView {
    
    private lazy var resourceView: ResourceView = {
        let view = ResourceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.height(equalTo: 160)
        view.width(equalTo: 160)
        return view
    }()
    
    private lazy var headerLabel: LocalLabel = {
        let label = LocalLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var descLabel: LocalLabel = {
        let label = LocalLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [resourceView,
                                                            headerLabel,
                                                            descLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = .S
        return stackView
    }()

    public init() {
        super.init(frame: .zero)
        addSubviews()
        setUpUI()
        addConstraints()
    }
    
    public convenience init(model: PageDescriptionViewModel) {
        self.init()
        bind(model: model)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func  addSubviews() {
        self.addSubview(stackView)
    }
    
    private func setUpUI() {
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        stackView.top(toView: self, constant: .XS)
        stackView.bottom(toView: self, constant: .S)
        stackView.left(toView: self)
        stackView.right(toView: self)
    }
}

extension PageDescription {
    
    public func bind(model: PageDescriptionViewModel) {
        if let resourceType = model.resourceType {
            resourceView.bind(with: resourceType)
        }
        
        descLabel.bind(with: model.description)
        
        if let header = model.header {
            headerLabel.bind(with: header)
        }
    }
}
