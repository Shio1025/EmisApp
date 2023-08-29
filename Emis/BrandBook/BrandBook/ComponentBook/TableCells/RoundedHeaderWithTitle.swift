//
//  RoundedHeaderWithTitle.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 18.06.23.
//

import UIKit
import Combine

public class RoundedHeaderWithTitle: TableCell {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = BrandBookManager.Color.General.black.uiColor
        label.font = .systemFont(ofSize: .XL2, weight: .bold)
        return label
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
    
    private func addSubviews() {
        contentView.addSubview(label)
    }
    
    private func setUpUI() {
        selectionStyle = .none
    }
    
    private func addConstraints() {
        label.top(toView: contentView, constant: .M)
        label.bottom(toView: contentView, constant: .XS)
        label.left(toView: contentView, constant: .L)
        label.right(toView: contentView, constant: .M)
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        roundCorners(by: .M, corners: [.topLeft, .topRight])
    }
}

extension RoundedHeaderWithTitle {
    public func bind(with data: any CellModel) {
        if let model = data as? RoundedHeaderWithTitleModel {
            label.text = model.headerTitle
            self.backgroundColor = model.backgroundColor
        }
    }
}

public class RoundedHeaderWithTitleModel: CellModel {
    public typealias T = RoundedHeaderWithTitle
    var backgroundColor: UIColor
    var headerTitle: String
    
    public init(headerTitle: String,
                backgroundColor: UIColor = BrandBookManager.Color.Theme.Background.layer.uiColor) {
        self.backgroundColor = backgroundColor
        self.headerTitle = headerTitle
    }
}
