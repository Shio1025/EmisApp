//
//  InfoCell.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 28.08.23.
//

import UIKit

public class InfoCell: TableCell {
    
    private lazy var topView: UIView = {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        return topView
    }()
    
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
    
    private lazy var separator: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.height(equalTo: 1)
        separator.backgroundColor = BrandBookManager.Color.Theme.Component.tr200.uiColor.withAlphaComponent(0.5)
        return separator
    }()
    
    private lazy var labelContainer: UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [topLabel,
                                                            bottomLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = .S
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
        contentView.addSubview(topView)
        topView.addSubview(labelContainer)
        topView.addSubview(button)
        contentView.addSubview(separator)
    }
    
    private func setUpUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        labelContainer.left(toView: topView, constant: .L)
        labelContainer.width(equalTo: 250)
        labelContainer.bottom(toView: topView)
        labelContainer.top(toView: topView, constant: .M)
        
        button.right(toView: topView, constant: .M)
        button.centerVertically(to: topView)
        
        topView.top(toView: contentView)
        topView.left(toView: contentView)
        topView.right(toView: contentView)
        topView.relativeBottom(toView: separator, constant: .M)
        
        separator.left(toView: contentView, constant: .XL3)
        separator.right(toView: contentView, constant: .XL)
        separator.bottom(toView: contentView)
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
            separator.isHidden = !model.isSeparatorNeeded
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
    var isSeparatorNeeded: Bool
    var backgroundColor: UIColor
    
    public init(topLabelModel: LocalLabelModel,
                bottomLabelModel: LocalLabelModel,
                buttonModel: SecondaryButtonModel? = nil,
                isSeparatorNeeded: Bool = false,
                backgroundColor: UIColor = BrandBookManager.Color.Theme.Background.layer.uiColor) {
        self.topLabelModel = topLabelModel
        self.bottomLabelModel = bottomLabelModel
        self.buttonModel = buttonModel
        self.isSeparatorNeeded = isSeparatorNeeded
        self.backgroundColor = backgroundColor
    }
}
