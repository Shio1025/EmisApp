//
//  RoundedFooter.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 18.06.23.
//

import UIKit

public class RoundedFooter: TableCell {
    
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
        addConstraints()
    }
    
    private func setUpUI() {
        selectionStyle = .none
    }
    
    private func addConstraints() {
        height(equalTo: .L)
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        roundCorners(by: .M, corners: [.bottomLeft, .bottomRight])
    }
}

extension RoundedFooter {
    public func bind(with data: any CellModel) {
        if let model = data as? RoundedFooterModel {
            self.backgroundColor = model.backgroundColor
        }
    }
}

public class RoundedFooterModel: CellModel {
    public typealias T = RoundedFooter
    var backgroundColor: UIColor
    
    public init(backgroundColor: UIColor = BrandBookManager.Color.Theme.Background.layer.uiColor) {
        self.backgroundColor = backgroundColor
    }
}
