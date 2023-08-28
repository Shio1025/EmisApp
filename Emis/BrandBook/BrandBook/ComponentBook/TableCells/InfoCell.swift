//
//  InfoCell.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 28.08.23.
//

import UIKit

public class InfoCell: TableCell {
    
    private lazy var topLabel: LocalLabel = {
        let label = LocalLabel()
        label.backgroundColor = .clear
        label.setAlignment(with: .left)
        return label
    }()
    
    private lazy var button: SecondaryButton = {
        let view = SecondaryButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomLabel: LocalLabel = {
        let label = LocalLabel()
        label.backgroundColor = .clear
        label.setAlignment(with: .left)
        return label
    }()
    
    private lazy var labelContainer: UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [topLabel,
                                                            bottomLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        contentView.addSubview(labelContainer)
        contentView.addSubview(button)
    }
    
    private func setUpUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        labelContainer.left(toView: contentView, constant: .S)
        labelContainer.width(equalTo: 250)
        labelContainer.centerVertically(to: contentView)
        
        button.right(toView: contentView, constant: .M)
        button.centerVertically(to: contentView)
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        button.resetSubscriptions()
    }
}

extension InfoCell {
    public func bind(with data: any CellModel) {
        if let model = data as? InfoCellModel {
            button.isHidden = true
            self.backgroundColor = model.backgroundColor
            topLabel.bind(with: model.topLabelModel)
            bottomLabel.bind(with: model.bottomLabelModel)
            if let buttonModel = model.buttonModel {
                button.isHidden = false
                button.bind(with: buttonModel)
            }
        }
    }
}

public class InfoCellModel: CellModel {
    public typealias T = InfoCell
    var topLabelModel: LocalLabelModel
    var bottomLabelModel: LocalLabelModel
    var buttonModel: SecondaryButtonModel?
    var backgroundColor: UIColor
    
    public init(topLabelModel: LocalLabelModel,
                bottomLabelModel: LocalLabelModel,
                buttonModel: SecondaryButtonModel? = nil,
                backgroundColor: UIColor = BrandBookManager.Color.Theme.Background.layer.uiColor) {
        self.topLabelModel = topLabelModel
        self.bottomLabelModel = bottomLabelModel
        self.buttonModel = buttonModel
        self.backgroundColor = backgroundColor
    }
}
