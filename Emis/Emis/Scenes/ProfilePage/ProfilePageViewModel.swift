//
//  ProfilePageViewModel.swift
//  Emis
//
//  Created by Shio Birbichadze on 17.06.23.
//

import BrandBook
import Combine
import Resolver
import SSO
import Core
import UIKit

enum ProfilePageRoute {
    
}

final class ProfilePageViewModel {
    
    @Published private var router: ProfilePageRoute?
    @Published private var listCells: [any CellModel] = []
    @Injected private var SSO: SSOManager
    
    var listCellModels: AnyPublisher<[any CellModel], Never> {
        $listCells.eraseToAnyPublisher()
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        headerSection.map { listCells.append(contentsOf: $0) }
        personalInfoSection.map { listCells.append(contentsOf: $0) }
        educationalInfoSection.map { listCells.append(contentsOf: $0) }
        financeInfoSection.map { listCells.append(contentsOf: $0) }
    }
    
}

extension ProfilePageViewModel {
    
    func getRouter() -> AnyPublisher<ProfilePageRoute?, Never> {
        $router.eraseToAnyPublisher()
    }
}

extension ProfilePageViewModel {
    
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

extension ProfilePageViewModel {
    
    var headerSection: [any CellModel]? {
        guard let userInfo = SSO.user else { return nil }
        let header = PageDescriptionCellModel(model: .init(resourceType: .image(image: BrandBookManager.Icon.mortarboard.image),
                                                           description: .init(text: "\(userInfo.name) \(userInfo.surname)")))
        return [getRoundedHeaderModel(), header, getRoundedFooterModel(), getSpacerCell()]
    }
    
    var personalInfoSection: [any CellModel]? {
        guard let userInfo = SSO.user else { return nil }
        _ = RowItemCellModel(model: .init(labels: .one(model: .init(text: "დაბადების თარიღი")),
                                                      rightItem: .label(model: .init(text: userInfo.birthDate))))
        let phoneNumber = RowItemCellModel(model: .init(labels: .one(model: .init(text: "ტელეფონის ნომერი")),
                                                        rightItem: .label(model: .init(text: userInfo.phoneNumber))))
        return [getRoundedHeaderWithTitle(title: "პერსონალური მონაცემები"),
                phoneNumber,
                getRoundedFooterModel(),
                getSpacerCell()]
    }
    
    var educationalInfoSection: [any CellModel]? {
        guard let userInfo = SSO.user else { return nil }
        let speciality = RowItemCellModel(model: .init(labels: .one(model: .init(text: "სპეციალობა")),
                                                       rightItem: .label(model: .init(text: userInfo.speciality))))
        let term = RowItemCellModel(model: .init(labels: .one(model: .init(text: "მიმდინარე სემესტრი")),
                                                 rightItem: .label(model: .init(text: userInfo.currentTerm.description))))
        let credits = RowItemCellModel(model: .init(labels: .one(model: .init(text: "სულ კრედიტები")),
                                                    rightItem: .label(model: .init(text: userInfo.totalCredits.description))))
        let gpa = RowItemCellModel(model: .init(labels: .one(model: .init(text: "GPA")),
                                                rightItem: .label(model: .init(text: Formatter.formatNumber(number: userInfo.GPA)))))
        let status = RowItemCellModel(model: .init(labels: .one(model: .init(text: "სტატუსი")),
                                                    rightItem: .label(model: .init(text: userInfo.status.desc,
                                                                                   color: BrandBookManager.Color.General.green.uiColor,
                                                                                   font: .systemFont(ofSize: .M,
                                                                                                     weight: .regular)))))
        let gradesBook = RowItemCellModel(model: .init(labels: .one(model: .init(text: "ნიშნების ფურცელი")),
                                                       rightItem: .button(model:
                                                            .init(resourceType: .icon(icon: UIImage(systemName: "arrow.down.to.line")!,
                                                                                      tintColor: BrandBookManager.Color.Theme.Invert.tr500.uiColor), action: {
            
        }))))
        
        
        return [getRoundedHeaderWithTitle(title: "განათლება"),
                status,
                speciality,
                term,
                credits,
                gpa,
                gradesBook,
                getRoundedFooterModel(),
                getSpacerCell()]
    }
    
    var financeInfoSection: [any CellModel]? {
        guard let userInfo = SSO.user else { return nil }
        
        var statusText = "გადასახდელია"
        var statusColor = BrandBookManager.Color.General.red.uiColor
        if userInfo.finances.debt >= 0 {
            statusText = "გადახდილია"
            statusColor = BrandBookManager.Color.General.green.uiColor
        }
        
        let financies = RowItemCellModel(model: .init(labels: .one(model: .init(text: "ფინანსები")),
                                                      rightItem: .labelAndButton(labelModel: .init(text: statusText,
                                                                                                  color: statusColor),
                                                                                 buttonModel: .init(resourceType: .icon(icon: UIImage(systemName: "chevron.right")!,
                                                                                                                        tintColor: BrandBookManager.Color.Theme.Invert.tr500.uiColor), action: {
            
        }))))
        
        return [getRoundedHeaderModel(),
                financies,
                getRoundedFooterModel(),
                getSpacerCell()]
    }
}



