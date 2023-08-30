//
//  SecondaryButtonsCell.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 29.08.23.
//

import UIKit

public class SecondaryButtonsCell: TableCell {
    
    private lazy var containerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = .M
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = .init(top: 0,
                                                   leading: .M,
                                                   bottom: 0,
                                                   trailing: .M)
        return stackView
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
        contentView.addSubview(containerStack)
    }
    
    private func setUpUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        containerStack.top(toView: contentView)
        containerStack.bottom(toView: contentView)
        containerStack.left(toView: contentView)
        containerStack.right(toView: contentView)
    }
}

extension SecondaryButtonsCell {
    public func bind(with data: any CellModel) {
        if let model = data as? SecondaryButtonsCellModel {
            reset()
            self.backgroundColor = model.backgroundColor
            addButtons(buttonModels: model.buttonModels)
        }
    }
    
    private func reset() {
        for subview in containerStack.arrangedSubviews {
            subview.removeFromSuperview()
        }
    }
    
    private func addButtons(buttonModels: [SecondaryButtonModel]) {
        buttonModels.forEach { model in
            let button = SecondaryButton()
            button.bind(with: model)
            containerStack.addArrangedSubview(button)
        }
    }
}

public class SecondaryButtonsCellModel: CellModel {
    public typealias T = SecondaryButtonsCell
    var buttonModels: [SecondaryButtonModel]
    var backgroundColor: UIColor
    
    public init(buttonModels: [SecondaryButtonModel],
                backgroundColor: UIColor = BrandBookManager.Color.Theme.Background.layer.uiColor) {
        self.buttonModels = buttonModels
        self.backgroundColor = backgroundColor
    }
}


