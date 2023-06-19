//
//  PageDescriptionCell.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 19.06.23.
//

import UIKit

public class PageDescriptionCell: TableCell {
    
    private lazy var pageDescription: PageDescription = {
        let pageDescription = PageDescription()
        pageDescription.translatesAutoresizingMaskIntoConstraints = false
        pageDescription.isUserInteractionEnabled = true
        return pageDescription
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
        contentView.addSubview(pageDescription)
    }
    
    private func setUpUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        pageDescription.top(toView: contentView, constant: .XS)
        pageDescription.bottom(toView: contentView, constant: .XS)
        pageDescription.left(toView: contentView, constant: .L)
        pageDescription.right(toView: contentView, constant: .L)
    }
}

extension PageDescriptionCell {
    public func bind(with data: any CellModel) {
        if let model = data as? PageDescriptionCellModel {
            self.backgroundColor = model.backgroundColor
            pageDescription.bind(model: model.pageDescriptionModel)
        }
    }
}

public class PageDescriptionCellModel: CellModel {
    public typealias T = PageDescriptionCell
    var pageDescriptionModel: PageDescriptionViewModel
    var backgroundColor: UIColor
    
    public init(model: PageDescriptionViewModel,
                backgroundColor: UIColor = BrandBookManager.Color.Theme.Background.layer.uiColor) {
        self.pageDescriptionModel = model
        self.backgroundColor = backgroundColor
    }
}
