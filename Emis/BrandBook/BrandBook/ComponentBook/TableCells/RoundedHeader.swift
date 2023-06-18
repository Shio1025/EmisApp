//
//  RoundedHeader.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 18.06.23.
//

import UIKit
import Combine

public class RoundedHeader: TableCell {
    
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
        height(equalTo: .XL)
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        roundCorners(by: .M, corners: [.topLeft, .topRight])
    }
}

extension RoundedHeader {
    public func bind(with data: any CellModel) {
        if let model = data as? RoundedHeaderModel {
            self.backgroundColor = model.backgroundColor
        }
    }
}

public class RoundedHeaderModel: CellModel {
    public typealias T = RoundedHeader
    var backgroundColor: UIColor
    
    public init(backgroundColor: UIColor = BrandBookManager.Color.Theme.Background.layer.uiColor) {
        self.backgroundColor = backgroundColor
    }
}
