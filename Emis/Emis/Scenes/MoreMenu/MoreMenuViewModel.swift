//
//  MoreMenuViewModel.swift
//  Emis
//
//  Created by Shio Birbichadze on 20.06.23.
//

import BrandBook
import Combine
import Resolver
import SSO
import Core
import UIKit

enum MoreMenuRoute {
    case loginPage
}

final class MoreMenuViewModel {
    
    @Published private var router: MoreMenuRoute?
    @Published private var listCells: [any CellModel] = []
    @Injected private var SSO: SSOManager
    
    var listCellModels: AnyPublisher<[any CellModel], Never> {
        $listCells.eraseToAnyPublisher()
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        listCells.append(contentsOf: logOutSection)
    }
}

extension MoreMenuViewModel {
    
    func getRouter() -> AnyPublisher<MoreMenuRoute?, Never> {
        $router.eraseToAnyPublisher()
    }
}

extension MoreMenuViewModel {
    
    private func getRoundedFooterModel() -> RoundedFooterModel {
        .init()
    }
    
    private func getRoundedHeaderModel() -> RoundedHeaderModel {
        .init()
    }
    
    private func getRoundedHeaderWithTitle(title: String) -> RoundedHeaderWithTitleModel {
        .init(headerTitle: title)
    }
    
    private func getSpacerCell() -> SpacerCellModel {
        .init()
    }
    
}

extension MoreMenuViewModel {
    
    var logOutSection: [any CellModel] {
        let logOut = RowItemCellModel(model: .init(labels: .one(model: .init(text: "გასვლა")),
                                                       rightItem: .button(model:
                                                            .init(resourceType: .icon(icon: UIImage(systemName: "arrow.down.to.line")!,
                                                                                      tintColor: BrandBookManager.Color.Theme.Invert.tr500.uiColor), action: {
            self.SSO.logOutUser()
            self.router = .loginPage
        }))))
        
        
        return [getRoundedHeaderModel(),
                logOut,
                getRoundedFooterModel(),
                getSpacerCell()]
    }
}
