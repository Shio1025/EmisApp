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
    case finances
}

final class ProfilePageViewModel {
    
    @Published private var router: ProfilePageRoute?
    @Published private var listCells: [any CellModel] = []
    @Published private var isLoading: Bool = true
    @Published private var isPhoneNumberChanging: Bool = false {
        didSet {
            newPhoneNumber = ""
        }
    }
    @Published private var newPhoneNumber: String = ""
    @Published private var phoneNumberChangeButton: ButtonState = .enabled
    @Published private var statusBanner: StatusBannerViewModel?
    
    var displayBannerPublisher: AnyPublisher<StatusBannerViewModel, Never> {
         $statusBanner
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    private var studentInfo: StudentInfo?
    private var teacherInfo: TeacherInfo?
    
    @Injected private var SSO: SSOManager
    
    var listCellModels: AnyPublisher<[any CellModel], Never> {
        $listCells.eraseToAnyPublisher()
    }
    
    var pageIsLoading: AnyPublisher<Bool, Never> {
        $isLoading.eraseToAnyPublisher()
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        load()
    }
    
    private func load() {
        switch SSO.userInfo?.userType {
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
        studentInfo = .init(firstName: "Dato", lastName: "Dvali", birthDate: "28-12-2000", email: "ddval19@freeuni.edu.ge", address: "თბილისი, ისანი, ბერი გაბრიელ სალოსის ქუჩა", phoneNumber: "591902952", status: .active, degreeLevel: .bachelor, credits: 210, gpa: 3.34)
        draw()
        isLoading = false
//        @Injected var studentInfoUseCase: StudentInfoUseCase
//
//        studentInfoUseCase.getStudentInfo(userId: SSO.userInfo?.userId?.description ?? "")
//            .sink { [weak self] completion in
//                switch completion {
//                case .failure(let error):
//                    self?.isLoading = false
//                    self?.statusBanner = .init(bannerType: .failure,
//                                               description: error.localizedDescription)
//                case .finished:
//                    self?.isLoading = false
//                    self?.draw()
//                }
//            } receiveValue: { [weak self] model in
//                self?.studentInfo = model
//            }.store(in: &subscriptions)
    }
    
    private func getTeacherInfo() {
        teacherInfo = .init(firstName: "Dato", lastName: "Dvali", birthDate: "28-12-2000", email: "ddval19@freeuni.edu.ge", address: "თბილისი, ისანი, ბერი გაბრიელ სალოსის ქუჩა", phoneNumber: "591902952", position: "sdcds", status: "Active")
        draw()
        isLoading = false
//        @Injected var teacherInfoUseCase: TeacherInfoUseCase
//
//        teacherInfoUseCase.getTeacherInfo(userId: SSO.userInfo?.userId?.description ?? "")
//            .sink { [weak self] completion in
//                switch completion {
//                case .finished:
//                    self?.isLoading = false
//                    self?.draw()
//                case .failure(let error):
//                    self?.isLoading = false
//                    self?.statusBanner = .init(bannerType: .failure,
//                                               description: error.localizedDescription)
//                }
//            } receiveValue: { [weak self] model in
//                self?.teacherInfo = model
//            }.store(in: &subscriptions)
    }
}

extension ProfilePageViewModel {
    
    private func draw() {
        switch SSO.userInfo?.userType {
        case .student:
            handleStudentProfile()
        case .teacher:
            handleTeacherProfile()
        default:
           break
        }
    }
    
    private func handleStudentProfile() {
        var rows: [any CellModel] = []
        
        getHeaderSection(name: studentInfo?.firstName,
                         surname: studentInfo?.lastName).map { rows.append(contentsOf: $0) }
        studentEducationalInfoSection.map { rows.append(contentsOf: $0) }
        financeInfoSection.map { rows.append(contentsOf: $0) }
        studentPersonalInfoSection.map { rows.append(contentsOf: $0) }
        
        listCells = rows
    }
    
    private func handleTeacherProfile() {
        var rows: [any CellModel] = []
        
        getHeaderSection(name: teacherInfo?.firstName,
                         surname: teacherInfo?.lastName).map { rows.append(contentsOf: $0) }
        teacherEducationalInfoSection.map { rows.append(contentsOf: $0) }
        teacherPersonalInfoSection.map { rows.append(contentsOf: $0) }
        
        listCells = rows
    }
}

//Student
extension ProfilePageViewModel {
    
    private func getHeaderSection(name: String?,
                                  surname: String?) -> [any CellModel]? {
        guard let name,
              let surname
        else { return nil }
        let header = PageDescriptionCellModel(model: .init(resourceType: .image(image: BrandBookManager.Image.person.image),
                                                           description: .init(text: "\(name) \(surname)",
                                                                              font: .systemFont(ofSize: .XL2,
                                                                                                weight: .light))))
        return [getRoundedHeaderModel(), header, getRoundedFooterModel(), getSpacerCell()]
    }

    private var studentPersonalInfoSection: [any CellModel]? {
        guard let userInfo = studentInfo else { return nil }
        var rows: [any CellModel] = []
        rows.append(getRoundedHeaderWithTitle(title: "პირადი მონაცემები"))
        
        rows.append(contentsOf: getPhoneNumberSections(phoneNumber: userInfo.phoneNumber))
        
        let addressRow = InfoCellModel(topLabelModel: .init(text: "მისამართი",
                                                            color: BrandBookManager.Color.Theme.Invert.tr400.uiColor),
                                       bottomLabelModel: .init(text: userInfo.address,
                                                               font: .systemFont(ofSize: .L,
                                                                                 weight: .regular)),
                                       isSeparatorNeeded: true)
        rows.append(addressRow)
        
        let emailRow = InfoCellModel(topLabelModel: .init(text: "ელ-ფოსტა",
                                                          color: BrandBookManager.Color.Theme.Invert.tr400.uiColor),
                                     bottomLabelModel: .init(text: userInfo.email,
                                                             font: .systemFont(ofSize: .L,
                                                                               weight: .regular)))
        rows.append(emailRow)
        
        rows.append(getRoundedFooterModel())
        rows.append(getSpacerCell())
        return rows
    }
    
    
    private func getPhoneNumberSections(phoneNumber: String) -> [any CellModel] {
        var rows: [any CellModel] = []
        
        let buttonModel = isPhoneNumberChanging
            ? nil
            : SecondaryButtonModel(titleModel: .init(text: "შეცვლა"),
                                   action: { [weak self] in
                guard let self else { return }
                self.isPhoneNumberChanging.toggle()
                self.draw()
            })
        let phoneNumberRow = InfoCellModel(topLabelModel: .init(text: "მობილურის ნომერი",
                                                                color: BrandBookManager.Color.Theme.Invert.tr400.uiColor),
                                           bottomLabelModel: .init(text: phoneNumber,
                                                                   font: .systemFont(ofSize: .L)),
                                           buttonModel: buttonModel,
                                           isSeparatorNeeded: !isPhoneNumberChanging)
        rows.append(phoneNumberRow)
        
        if isPhoneNumberChanging {
            rows.append(TextFieldCellModel(model: .init(placeholder: "შეიყვანეთ ახალი ტელ. ნომერი",
                                                        keyboardType: .phonePad,
                                                        onEditingDidEnd: { [weak self] phoneNumber in
                self?.newPhoneNumber = phoneNumber
            })))
            
            let editButton = SecondaryButtonModel(titleModel: .init(text: "დამახსოვრება")) { [weak self] in
                self?.handlePhoneNumberChangeAction()
            }
            
            let cancelButton = SecondaryButtonModel(titleModel: .init(text: "გაუქმება"),
                                                    backgroundColor: BrandBookManager.Color.Theme.Invert.tr50.uiColor.withAlphaComponent(0.5),
                                                    textColor: BrandBookManager.Color.General.black.uiColor) { [weak self] in
                self?.isPhoneNumberChanging.toggle()
                self?.draw()
            }
            
            rows.append(SecondaryButtonsCellModel(buttonModels: [editButton, cancelButton]))
            rows.append(SeparatorCellModel())
        }
        
        return rows
    }
    
    private var studentEducationalInfoSection: [any CellModel]? {
        guard let userInfo = studentInfo else { return nil }
        let degree = RowItemCellModel(model:
                .init(labels: .one(model: .init(text: "ხარისხი")),
                      rightItem: .label(model: .init(text: userInfo.degreeLevel.rawValue,
                                                     font: .systemFont(ofSize: .L,
                                                                       weight: .semibold))),
                      isSeparatorNeeded: true))
        let credits = RowItemCellModel(model:
                .init(labels: .one(model: .init(text: "სულ კრედიტები")),
                      rightItem: .label(model: .init(text: userInfo.credits.description,
                                                     font: .systemFont(ofSize: .L,
                                                                       weight: .semibold))),
                      isSeparatorNeeded: true))
        let gpa = RowItemCellModel(model:
                .init(labels: .one(model: .init(text: "GPA")),
                      rightItem: .label(model: .init(text: Formatter.formatNumber(number: userInfo.gpa),
                                                     font: .systemFont(ofSize: .L,
                                                                       weight: .semibold))),
                      isSeparatorNeeded: true))
        let status = RowItemCellModel(model:
                .init(labels: .one(model: .init(text: "სტატუსი")),
                      rightItem: .label(model: .init(text: userInfo.status.rawValue,
                                                     color: BrandBookManager.Color.General.green.uiColor,
                                                     font: .systemFont(ofSize: .L,
                                                                       weight: .regular)))))
        return [getRoundedHeaderWithTitle(title: "განათლება"),
                degree,
                credits,
                gpa,
                status,
                getRoundedFooterModel(),
                getSpacerCell()]
    }
    
    private var financeInfoSection: [any CellModel]? {
        guard let userInfo = studentInfo else { return nil }
        
        let financesBanner = BannerCellModel(model:
                .init(resourceType: .animation(model: .init(animationName: BrandBookManager.Lottie.finances,
                                                            bundle: Bundle(identifier: "Shio.BrandBook")!)),
                      topLabelModel: .init(text: "ჩემი ფინანსები",
                                           font: .systemFont(ofSize: .L)),
                      isChevronNeeded: true,
                      action: {
            self.router = .finances
        }))
        
        return [financesBanner,
                getSpacerCell()]
    }
}

//Teacher
extension ProfilePageViewModel {
    
    private var teacherPersonalInfoSection: [any CellModel]? {
        guard let userInfo = teacherInfo else { return nil }
        
        var rows: [any CellModel] = []
        rows.append(getRoundedHeaderWithTitle(title: "პერსონალური მონაცემები"))
        
        rows.append(contentsOf: getPhoneNumberSections(phoneNumber: userInfo.phoneNumber))
        
        let emailRow = InfoCellModel(topLabelModel: .init(text: "ელ-ფოსტა",
                                                          color: BrandBookManager.Color.Theme.Invert.tr400.uiColor),
                                     bottomLabelModel: .init(text: userInfo.email,
                                                             font: .systemFont(ofSize: .L,
                                                                               weight: .regular)),
                                     isSeparatorNeeded: true)
        rows.append(emailRow)
        
        let addressRow = InfoCellModel(topLabelModel: .init(text: "მისამართი",
                                                            color: BrandBookManager.Color.Theme.Invert.tr400.uiColor),
                                       bottomLabelModel: .init(text: userInfo.address,
                                                               font: .systemFont(ofSize: .L,
                                                                                 weight: .regular)))
        rows.append(addressRow)
        rows.append(getRoundedFooterModel())
        rows.append(getSpacerCell())
        
        return rows
    }
    
    private var teacherEducationalInfoSection: [any CellModel]? {
        guard let userInfo = teacherInfo else { return nil }
        let position = RowItemCellModel(model:
                .init(labels: .one(model: .init(text: "პოზიცია")),
                      rightItem: .label(model: .init(text: userInfo.position,
                                                     font: .systemFont(ofSize: .L,
                                                                       weight: .semibold))),
                      isSeparatorNeeded: true))
        
        let status = RowItemCellModel(model:
                .init(labels: .one(model: .init(text: "სტატუსი")),
                      rightItem: .label(model: .init(text: userInfo.status,
                                                     color: BrandBookManager.Color.General.green.uiColor,
                                                     font: .systemFont(ofSize: .L,
                                                                       weight: .regular)))))
        return [getRoundedHeaderWithTitle(title: "განათლება"),
                position,
                status,
                getRoundedFooterModel(),
                getSpacerCell()]
    }
}



//Update Phone Number
extension ProfilePageViewModel {
    
    private func handlePhoneNumberChangeAction() {
        statusBanner = .init(bannerType: .success,
                                   description: "ნომერი წარმატებით განახლდა!")
        isPhoneNumberChanging = false
        load()
//        @Injected var updatePhoneNumberUseCase: UpdatePhoneNumberUseCase
//
//        updatePhoneNumberUseCase.updateStudentPhoneNumber(userId: SSO.userInfo?.generalID?.description ?? "",
//                                                          phoneNumber: newPhoneNumber)
//        .sink { [weak self] completion in
//            switch completion {
//            case .finished:
//                self?.isPhoneNumberChanging = false
//                self?.statusBanner = .init(bannerType: .success,
//                                           description: "ნომერი წარმატებით განახლდა !")
//                self?.load()
//            case .failure(let error):
//                self?.statusBanner = .init(bannerType: .failure,
//                                           description: error.localizedDescription)
//            }
//        } receiveValue: { _ in
//
//        }.store(in: &subscriptions)
    }
}
