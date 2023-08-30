//
//  StatusBanner.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 26.08.23.
//

import UIKit

public class StatusBanner: UIView {
    
    private lazy var label: LocalLabel = {
        let label = LocalLabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setAlignment(with: .center)
        return label
    }()

    public init() {
        super.init(frame: .zero)
        addSubviews()
        setUpUI()
        addConstraints()
    }
    
    public convenience init(model: StatusBannerViewModel) {
        self.init()
        bind(model: model)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func  addSubviews() {
        addSubview(label)
    }
    
    private func setUpUI() {
        isUserInteractionEnabled = false
    }
    
    private func addConstraints() {
        label.top(toView: self, constant: .M)
        label.bottom(toView: self, constant: .M)
        
        label.centerHorizontally(to: self)
        label.width(equalTo: UIScreen.main.bounds.size.width - .XL6)
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        roundCorners(by: .M)
    }
}

extension StatusBanner {
    
    public func bind(model: StatusBannerViewModel) {
        label.bind(with: .init(text: model.description,
                               color: BrandBookManager.Color.General.white.uiColor))
        backgroundColor = model.bannerType.backgroundColor
    }
}

public class StatusBannerViewModel {
    public var bannerType: StatusBannerType
    public var description: String
    
    public init(bannerType: StatusBannerType,
                description: String) {
        self.bannerType = bannerType
        self.description = description
    }
}

public enum StatusBannerType {
    case success
    case failure
    
    var backgroundColor: UIColor {
        switch self {
        case .success:
            return BrandBookManager.Color.General.green.uiColor
        case .failure:
            return BrandBookManager.Color.General.red.uiColor
        }
    }
}
