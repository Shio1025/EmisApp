//
//  TextFieldCell.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 18.06.23.
//

import UIKit

public class TextFieldCell: TableCell {
    
    private lazy var textField: TextFieldView = {
        let textField = TextFieldView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = true
        return textField
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
        contentView.addSubview(textField)
    }
    
    private func setUpUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        textField.top(toView: contentView, constant: .XS)
        textField.bottom(toView: contentView, constant: .XS)
        textField.left(toView: contentView, constant: .L)
        textField.right(toView: contentView, constant: .L)
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        textField.resetSubscriptions()
    }
}

extension TextFieldCell {
    public func bind(with data: any CellModel) {
        if let model = data as? TextFieldCellModel {
            self.backgroundColor = model.backgroundColor
            textField.bind(model: model.textFieldModel)
        }
    }
}

public class TextFieldCellModel: CellModel {
    public typealias T = TextFieldCell
    var textFieldModel: TextFieldViewModel
    var backgroundColor: UIColor
    
    public init(model: TextFieldViewModel,
                backgroundColor: UIColor = BrandBookManager.Color.Theme.Background.layer.uiColor) {
        self.textFieldModel = model
        self.backgroundColor = backgroundColor
    }
}
