//
//  InlineFeedbackCell.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 29.08.23.
//

import UIKit

public class InlineFeedbackCell: TableCell {
    
    private lazy var inlineFeedback: InlineFeedback = {
        let inlineFeedback = InlineFeedback()
        inlineFeedback.translatesAutoresizingMaskIntoConstraints = false
        return inlineFeedback
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        addSubviews()
        setUpUI()
        addConstraints()
    }
    
    private func  addSubviews() {
        contentView.addSubview(inlineFeedback)
    }
    
    private func setUpUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        inlineFeedback.top(toView: contentView, constant: .S)
        inlineFeedback.bottom(toView: contentView, constant: .S)
        inlineFeedback.left(toView: contentView, constant: .S)
        inlineFeedback.right(toView: contentView, constant: .S)
    }
}

extension InlineFeedbackCell {
    public func bind(with data: any CellModel) {
        if let model = data as? InlineFeedbackCellModel {
            self.backgroundColor = model.backgroundColor
            inlineFeedback.bind(with: model.inlineFeedbackModel)
        }
    }
}

public class InlineFeedbackCellModel: CellModel {
    public typealias T = InlineFeedbackCell
    var inlineFeedbackModel: InlineFeedbackModel
    var backgroundColor: UIColor
    
    public init(model: InlineFeedbackModel,
                backgroundColor: UIColor = BrandBookManager.Color.Theme.Component.tr100.uiColor) {
        self.inlineFeedbackModel = model
        self.backgroundColor = backgroundColor
    }
}


