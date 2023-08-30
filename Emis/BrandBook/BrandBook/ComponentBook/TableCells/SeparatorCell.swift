//
//  SeparatorCell.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 30.08.23.
//



import UIKit

public class SeparatorCell: TableCell {
    
    private lazy var separator: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.height(equalTo: 1)
        separator.backgroundColor = BrandBookManager.Color.Theme.Component.tr200.uiColor.withAlphaComponent(0.5)
        return separator
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
        setUpUI()
        addSubviews()
        addConstraints()
    }
    
    private func setUpUI() {
        selectionStyle = .none
    }
    
    private func addSubviews() {
        contentView.addSubview(separator)
    }
    
    private func addConstraints() {
        separator.top(toView: contentView, constant: .M)
        separator.left(toView: contentView, constant: .XL3)
        separator.right(toView: contentView, constant: .XL)
        separator.bottom(toView: contentView)
    }
}

extension SeparatorCell {
    public func bind(with data: any CellModel) {
        if let model = data as? SeparatorCellModel {
            self.backgroundColor = model.backgroundColor
        }
    }
}

public class SeparatorCellModel: CellModel {
    public typealias T = SeparatorCell
    var backgroundColor: UIColor
    
    public init(backgroundColor: UIColor = BrandBookManager.Color.Theme.Background.layer.uiColor) {
        self.backgroundColor = backgroundColor
    }
}
