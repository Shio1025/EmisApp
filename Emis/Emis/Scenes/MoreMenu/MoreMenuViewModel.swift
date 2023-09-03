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
    case changePassword
    case GPACalculator
    case logOut
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
        SSO.isUserLoggedPublisher
            .sink { [weak self] isLogged in
                guard let self else { return }
                self.draw(with: self.handleMoreMenuItems(isLogged: isLogged))
            }.store(in: &subscriptions)
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
    
    private func draw(with items: [MoreMenuItem]) {
        listCells = MoreMenuItemsSection(items: items)
    }
    
    private func MoreMenuItemsSection(items: [MoreMenuItem]) -> [any CellModel] {
        var rows: [any CellModel] = []
        
        rows.append(getSpacerCell())
        rows.append(getRoundedHeaderModel())
        
        items.enumerated().forEach { index, item in
            let itemRow = RowItemCellModel(
                model:
                        .init(labels: .one(model: .init(text: item.title,
                                                        color: item.textColor,
                                                        font: .systemFont(ofSize: .L))),
                              rightItem: .button(model:
                                    .init(resourceType: .icon(icon: UIImage(systemName: "chevron.right")!,
                                                              tintColor: BrandBookManager.Color.Theme.Invert.tr500.uiColor),
                                          action: { [weak self] in
                                              self?.handleMoreMenuItemsNavigation(with: item)
                                          })),
                              tapAction: { [weak self] in
                                  self?.handleMoreMenuItemsNavigation(with: item)
                              },
                              isSeparatorNeeded: index != (items.count - 1)))
            rows.append(itemRow)
        }
        
        
        rows.append(getRoundedFooterModel())
        return rows
    }
}

extension MoreMenuViewModel {
    
    private func handleMoreMenuItems(isLogged: Bool) -> [MoreMenuItem] {
        guard isLogged else { return [.GPACalculator] }
        switch SSO.userInfo?.userType {
        case .student:
            return  [.changePassword, .GPACalculator, .logOut]
        case .teacher:
            return [.changePassword, .logOut]
        default:
            return []
        }
    }
}

//Handle Navigation
extension MoreMenuViewModel {
    
    private func handleMoreMenuItemsNavigation(with item: MoreMenuItem) {
        switch item {
        case .changePassword:
            router = .changePassword
        case .GPACalculator:
            router = .GPACalculator
        case .logOut:
            SSO.logOutUser()
            router = .logOut
        }
    }
}
