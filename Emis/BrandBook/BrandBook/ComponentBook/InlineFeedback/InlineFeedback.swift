//
//  InlineFeedback.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 29.08.23.
//

import UIKit
import Combine

public class InlineFeedback: UIView {
    
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
    
    public convenience init(model: InlineFeedbackModel) {
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
        backgroundColor = BrandBookManager.Color.Theme.Background.layer.uiColor
        
    }
    
    private func addConstraints() {
        titleLabel.centerHorizontally(to: self)
        titleLabel.width(equalTo: 300)
        
        titleLabel.top(toView: self, constant: .M)
        titleLabel.bottom(toView: self, constant: .M)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(by: .M, borderColor: BrandBookManager.Color.Theme.Invert.tr400.uiColor, borderWidth: 1)
    }
}

extension InlineFeedback {
    
    public func bind(with model: InlineFeedbackModel) {
        titleLabel.bind(with: model.titleModel)
    }
}

public struct InlineFeedbackModel {
    let titleModel: LocalLabelModel
    
    public init(titleModel: LocalLabelModel) {
        self.titleModel = titleModel
    }
}
