//
//  BannerCell.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 25.08.23.
//

import UIKit

public class BannerCell: TableCell {
    
    private lazy var banner: BannerView = {
        let banner = BannerView()
        banner.translatesAutoresizingMaskIntoConstraints = false
        return banner
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
        contentView.addSubview(banner)
    }
    
    private func setUpUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        banner.top(toView: contentView, constant: .S)
        banner.bottom(toView: contentView, constant: .S)
        banner.left(toView: contentView, constant: .M)
        banner.right(toView: contentView, constant: .M)
    }
}

extension BannerCell {
    public func bind(with data: any CellModel) {
        if let model = data as? BannerCellModel {
            self.backgroundColor = model.backgroundColor
            banner.bind(model: model.bannerModel)
        }
    }
}

public class BannerCellModel: CellModel {
    public typealias T = BannerCell
    var bannerModel: BannerViewModel
    var backgroundColor: UIColor
    
    public init(model: BannerViewModel,
                backgroundColor: UIColor = BrandBookManager.Color.Theme.Background.canvas.uiColor) {
        self.bannerModel = model
        self.backgroundColor = backgroundColor
    }
}

