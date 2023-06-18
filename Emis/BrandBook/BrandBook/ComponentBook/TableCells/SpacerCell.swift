//
//  SpacerCell.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 18.06.23.
//

import UIKit

public class SpacerCell: TableCell {
    
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
}

extension SpacerCell {
    public func bind(with data: any CellModel) {
        if let model = data as? SpacerCellModel {
            self.backgroundColor = model.backgroundColor
        }
    }
}

public class SpacerCellModel: CellModel {
    public typealias T = SpacerCell
    var backgroundColor: UIColor
    
    public init(backgroundColor: UIColor = BrandBookManager.Color.Theme.Background.canvas.uiColor) {
        self.backgroundColor = backgroundColor
    }
}
