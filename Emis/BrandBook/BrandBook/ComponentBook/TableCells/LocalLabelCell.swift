//
//  LocalLabelCell.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 17.06.23.
//

import UIKit
import Combine

public class LocalLabelCell: TableCell {
    
    private lazy var label: LocalLabel = {
        let label = LocalLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    private func  addSubviews() {
        self.addSubview(label)
    }
    
    private func setUpUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        label.top(toView: self)
        label.bottom(toView: self)
        label.left(toView: self, constant: .M)
        label.right(toView: self)
    }
}

extension LocalLabelCell {
    public func bind(with data: any CellModel) {
        if let model = data as? LocalLabelCellModel {
            self.backgroundColor = model.backgroundColor
            label.configure(with: model.localLabelmodel)
        }
    }
}

public class LocalLabelCellModel: CellModel {
    public typealias T = LocalLabelCell
    var localLabelmodel: LocalLabelModel
    var backgroundColor: UIColor
    
    public init(model: LocalLabelModel,
                backgroundColor: UIColor) {
        self.localLabelmodel = model
        self.backgroundColor = backgroundColor
    }
}

