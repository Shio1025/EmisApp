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

enum ProfilePageRoute {
    
}

final class ProfilePageViewModel {
    
    @Published private var router: ProfilePageRoute?
    @Published private var listCells: [any CellModel] = []
    @Published private var isLoading: Bool = true
    @Published private var phoneNumberChangeButton: ButtonState = .enabled
    private var studentInfo: StudentInfo?
    @Injected private var SSO: SSOManager
    
    var listCellModels: AnyPublisher<[any CellModel], Never> {
        $listCells.eraseToAnyPublisher()
    }
    
    var pageIsLoading: AnyPublisher<Bool, Never> {
        $isLoading.eraseToAnyPublisher()
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        switch SSO.userType {
        case .student:
            getStudentInfo()
        case .teacher:
            getTeacherInfo()
        default:
           isLoading = false
        }
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
    
    private func getStudentInfo() {
        studentInfo = .init(firstName: "shi", lastName: "ddd", birthDate: "ddd", email: "sdfdsd", address: "sdcsdc", phoneNumber: "59959595", status: .active, degreeLevel: .bachelor, credits: 201, gpa: 3.99)
        draw()
        isLoading = false
//        @Injected var studentInfoUseCase: StudentInfoUseCase
//
//        studentInfoUseCase.getStudentInfo(userId: SSO.userId?.description ?? "")
//            .sink { [weak self] completion in
//                switch completion {
//                case .failure(let error):
//                    self?.isLoading = false
//                case .finished:
//                    self?.draw()
//                    self?.isLoading = false
//                }
//            } receiveValue: { [weak self] model in
//                self?.studentInfo = model
//            }.store(in: &subscriptions)
    }
    
    private func getTeacherInfo() {
      
    }
}

extension ProfilePageViewModel {
    
    private func draw() {
        switch SSO.userType {
        case .student:
            handleStudentProfile()
        case .teacher:
            handleTeacherProfile()
        default:
           break
        }
    }
    
    private func handleStudentProfile() {
        headerSection.map { listCells.append(contentsOf: $0) }
        educationalInfoSection.map { listCells.append(contentsOf: $0) }
        financeInfoSection.map { listCells.append(contentsOf: $0) }
        personalInfoSection.map { listCells.append(contentsOf: $0) }
    }
    
    private func handleTeacherProfile() {
        
    }
}

extension ProfilePageViewModel {
    
    var headerSection: [any CellModel]? {
        guard let name = studentInfo?.firstName,
              let surname = studentInfo?.lastName
        else { return nil }
        let header = PageDescriptionCellModel(model: .init(resourceType: .image(image: BrandBookManager.Images.tmp.image),
                                                           description: .init(text: "\(name) \(surname)",
                                                                              font: .boldSystemFont(ofSize: .L))))
        return [getRoundedHeaderModel(), header, getRoundedFooterModel(), getSpacerCell()]
    }

    var personalInfoSection: [any CellModel]? {
        guard let userInfo = studentInfo else { return nil }
        var rows: [any CellModel] = []
        rows.append(getRoundedHeaderWithTitle(title: "პერსონალური მონაცემები"))
        
        let phoneNumberRow = InfoCellModel(topLabelModel: .init(text: "მობილურის ნომერი"),
                                           bottomLabelModel: .init(text: userInfo.phoneNumber),
                                           buttonModel: .init(titleModel: .init(text: "შეცვლა"),
                                                              state: $phoneNumberChangeButton.eraseToAnyPublisher(),
                                                              action: {
            
        }))
        rows.append(phoneNumberRow)
        
        let addressRow = InfoCellModel(topLabelModel: .init(text: "მისამართი"),
                                       bottomLabelModel: .init(text: userInfo.address))
        rows.append(addressRow)
        
        let emailRow = InfoCellModel(topLabelModel: .init(text: "ელ-ფოსტა"),
                                       bottomLabelModel: .init(text: userInfo.email))
        rows.append(emailRow)
        
        rows.append(getRoundedFooterModel())
        rows.append(getSpacerCell())
        return rows
    }

    var educationalInfoSection: [any CellModel]? {
        guard let userInfo = studentInfo else { return nil }
        let degree = RowItemCellModel(model: .init(labels: .one(model: .init(text: "ხარისხი")),
                                                       rightItem: .label(model: .init(text: userInfo.degreeLevel.rawValue))))
        let credits = RowItemCellModel(model: .init(labels: .one(model: .init(text: "სულ კრედიტები")),
                                                    rightItem: .label(model: .init(text: userInfo.credits.description))))
        let gpa = RowItemCellModel(model: .init(labels: .one(model: .init(text: "GPA")),
                                                rightItem: .label(model: .init(text: Formatter.formatNumber(number: userInfo.gpa)))))
        let status = RowItemCellModel(model: .init(labels: .one(model: .init(text: "სტატუსი")),
                                                   rightItem: .label(model: .init(text: userInfo.status.rawValue,
                                                                                   color: BrandBookManager.Color.General.green.uiColor,
                                                                                   font: .systemFont(ofSize: .M,
                                                                                                     weight: .regular)))))
//        let gradesBook = RowItemCellModel(model: .init(labels: .one(model: .init(text: "ნიშნების ფურცელი")),
//                                                       rightItem: .button(model:
//                                                            .init(resourceType: .icon(icon: UIImage(systemName: "arrow.down.to.line")!,
//                                                                                      tintColor: BrandBookManager.Color.Theme.Invert.tr500.uiColor), action: {
//
//        }))))


        return [getRoundedHeaderWithTitle(title: "განათლება"),
                degree,
                credits,
                gpa,
                status,
                getRoundedFooterModel(),
                getSpacerCell()]
    }
    
    var financeInfoSection: [any CellModel]? {
        guard let userInfo = studentInfo else { return nil }
        
        let financesBanner = BannerCellModel(model:
                .init(resourceType: .animation(model: .init(animationName: BrandBookManager.Lottie.finances,
                                                            bundle: Bundle(identifier: "Shio.BrandBook")!)),
                      topLabelModel: .init(text: "ჩემი ფინანსები"),
                      isChevronNeeded: true,
                      action: {
            
        }))
        
        return [financesBanner,
                getSpacerCell()]
    }
}



