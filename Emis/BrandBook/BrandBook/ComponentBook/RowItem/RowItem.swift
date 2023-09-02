//
//  RowItem.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 19.06.23.
//

import UIKit

public class RowItem: UIView {
    
    var tapAction: (() -> Void)?
    
    private lazy var resourceView: ResourceView = {
        let view = ResourceView()
        view.backgroundColor = .clear
        view.isHidden = true
        view.height(equalTo: .XL2)
        view.width(equalTo: .XL2)
        return view
    }()
    
    private lazy var topLabel: LocalLabel = {
        let label = LocalLabel()
        label.backgroundColor = .clear
        label.isHidden = true
        return label
    }()
    
    private lazy var bottomLabel: LocalLabel = {
        let label = LocalLabel()
        label.backgroundColor = .clear
        label.isHidden = true
        return label
    }()
    
    private lazy var labelsContainer: UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [topLabel,
                                                            bottomLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = .XS
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var ResourceAndLabelsContainer: UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [resourceView,
                                                            labelsContainer])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = .XS
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: .XL, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return stackView
    }()
    
    private lazy var rightLabel: LocalLabel = {
        let label = LocalLabel()
        label.backgroundColor = .clear
        label.isHidden = true
        label.setAlignment(with: .right)
        return label
    }()
    
    private lazy var labelContainer: UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [rightLabel])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var smallButton: SmallButton = {
        let button = SmallButton()
        button.backgroundColor = .clear
        button.isUserInteractionEnabled = true
        button.isHidden = true
        return button
    }()
    
    private lazy var rightContainer: UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [labelContainer,
                                                            smallButton])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = .S
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .L)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.setContentCompressionResistancePriority(.init(1000), for: .horizontal)
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var separator: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.height(equalTo: 1)
        separator.backgroundColor = BrandBookManager.Color.Theme.Component.tr200.uiColor.withAlphaComponent(0.5)
        return separator
    }()
    
    private lazy var containerStack: UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [ResourceAndLabelsContainer,
                                                            rightContainer])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = .S
        return stackView
    }()

    public init() {
        super.init(frame: .zero)
        addSubviews()
        setUpUI()
        addConstraints()
    }
    
    public convenience init(model: RowItemViewModel) {
        self.init()
        bind(model: model)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func  addSubviews() {
        addSubview(containerStack)
        
        addSubview(separator)
    }
    
    private func setUpUI() {
        isUserInteractionEnabled = false
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        containerStack.top(toView: self, constant: .M)
        containerStack.right(toView: self)
        containerStack.left(toView: self)
        containerStack.relativeBottom(toView: separator, constant: .M)
        
        separator.left(toView: self, constant: .XL3)
        separator.right(toView: self, constant: .XL)
        separator.bottom(toView: self)
    }
}

extension RowItem {
    
    public func bind(model: RowItemViewModel) {
        reset()
        
        if let type = model.leftItem {
            resourceView.isHidden = false
            resourceView.bind(with: type)
        }
        
        configureLabels(labels: model.labels)
        
        configureRightItem(rightItem: model.rightItem)
        
        configureSeparator(isSeparatorNeeded: model.isSeparatorNeeded)
        
        if let tapAction = model.tapAction { configureTapAction(action: tapAction) }
    }
    
    private func configureTapAction(action: @escaping () -> Void) {
        self.tapAction = action
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleItemTap)))
    }
    
    @objc
    private func handleItemTap() {
        tapAction?()
    }
    
    private func configureSeparator(isSeparatorNeeded: Bool) {
        separator.isHidden = !isSeparatorNeeded
    }
    
    private func configureLabels(labels: Labels?) {
        if let labels {
            switch labels {
            case .one(let model):
                topLabel.isHidden = false
                topLabel.bind(with: model)
            case .two(let topModel, let bottomModel):
                topLabel.isHidden = false
                bottomLabel.isHidden = false
                topLabel.bind(with: topModel)
                bottomLabel.bind(with: bottomModel)
            }
        }
    }
    
    private func configureRightItem(rightItem: Item?) {
        if let rightItem  {
            switch rightItem {
            case .label(let model):
                rightLabel.isHidden = false
                rightLabel.bind(with: model)
            case .button(let model):
                smallButton.isHidden = false
                smallButton.bind(model: model)
            case .labelAndButton(let labelModel, let  buttonModel):
                rightLabel.isHidden = false
                smallButton.isHidden = false
                rightLabel.bind(with: labelModel)
                smallButton.bind(model: buttonModel)
            }
        }
    }
    
    private func reset() {
        resourceView.isHidden = true
        topLabel.isHidden = true
        bottomLabel.isHidden = true
        rightLabel.isHidden = true
        smallButton.isHidden = true
        separator.isHidden = true
    }
}
