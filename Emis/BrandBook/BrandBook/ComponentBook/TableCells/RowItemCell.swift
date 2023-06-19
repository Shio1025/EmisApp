//
//  RowItemCell.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 19.06.23.
//

import UIKit

public class RowItemCell: TableCell {
    
    private lazy var rowItem: RowItem = {
        let rowItem = RowItem()
        rowItem.translatesAutoresizingMaskIntoConstraints = false
        rowItem.isUserInteractionEnabled = true
        return rowItem
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
        contentView.addSubview(rowItem)
    }
    
    private func setUpUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        rowItem.top(toView: contentView)
        rowItem.bottom(toView: contentView)
        rowItem.left(toView: contentView)
        rowItem.right(toView: contentView)
    }
}

extension RowItemCell {
    public func bind(with data: any CellModel) {
        if let model = data as? RowItemCellModel {
            self.backgroundColor = model.backgroundColor
            rowItem.bind(model: model.rowItemModel)
        }
    }
}

public class RowItemCellModel: CellModel {
    public typealias T = RowItemCell
    var rowItemModel: RowItemViewModel
    var backgroundColor: UIColor
    
    public init(model: RowItemViewModel,
                backgroundColor: UIColor = BrandBookManager.Color.Theme.Background.layer.uiColor) {
        self.rowItemModel = model
        self.backgroundColor = backgroundColor
    }
}
