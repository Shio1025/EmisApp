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
        label.setAlignment(with: .center)
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
        contentView.addSubview(label)
    }
    
    private func setUpUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        label.top(toView: contentView, constant: .XS)
        label.bottom(toView: contentView, constant: .XS)
        label.left(toView: contentView, constant: .M)
        label.right(toView: contentView)
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        label.resetSubscriptions()
    }
}

extension LocalLabelCell {
    public func bind(with data: any CellModel) {
        if let model = data as? LocalLabelCellModel {
            self.backgroundColor = model.backgroundColor
            label.bind(with: model.localLabelmodel)
        }
    }
}

public class LocalLabelCellModel: CellModel {
    public typealias T = LocalLabelCell
    var localLabelmodel: LocalLabelModel
    var backgroundColor: UIColor
    
    public init(model: LocalLabelModel,
                backgroundColor: UIColor = BrandBookManager.Color.Theme.Background.layer.uiColor) {
        self.localLabelmodel = model
        self.backgroundColor = backgroundColor
    }
}

