//
//  PrimaryButtonCell.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 02.09.23.
//

import UIKit

public class PrimaryButtonCell: TableCell {
    
    private lazy var button: PrimaryButton = {
        let button = PrimaryButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        contentView.addSubview(button)
    }
    
    private func setUpUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        button.top(toView: contentView)
        button.bottom(toView: contentView)
        button.left(toView: contentView)
        button.right(toView: contentView)
    }
}

extension PrimaryButtonCell {
    public func bind(with data: any CellModel) {
        if let model = data as? PrimaryButtonCellModel {
            self.backgroundColor = model.backgroundColor
            button.bind(with: model.buttonModel)
        }
    }
}

public class PrimaryButtonCellModel: CellModel {
    public typealias T = PrimaryButtonCell
    var buttonModel: PrimaryButtonModel
    var backgroundColor: UIColor
    
    public init(buttonModels: PrimaryButtonModel,
                backgroundColor: UIColor = .clear) {
        self.buttonModel = buttonModels
        self.backgroundColor = backgroundColor
    }
}
