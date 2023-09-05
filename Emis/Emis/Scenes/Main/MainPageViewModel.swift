//
//  MainPageViewModel.swift
//  Emis
//
//  Created by Shio Birbichadze on 29.08.23.
//

import BrandBook
import Combine
import Resolver
import SSO
import Core
import UIKit

enum MainPageRoute {
    case studentSubjectCard
    case teacherSubjectCard
    case studentSubjectRegistration
    case teacherSubjectsHistory
    case library
}

final class MainPageViewModel {
    
    @Published private var router: MainPageRoute?
    @Published private var listCells: [any CellModel] = []
    @Published private var isLoading: Bool = false
    private var studentDashboardOptions: StudentDashboardOptions?
    var teacherDashboardOptions: TeacherDashboardOptions?
    @Injected private var SSO: SSOManager
    
    @Published private var statusBanner: StatusBannerViewModel?
    
    var displayBannerPublisher: AnyPublisher<StatusBannerViewModel, Never> {
         $statusBanner
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    var listCellModels: AnyPublisher<[any CellModel], Never> {
        $listCells.eraseToAnyPublisher()
    }
    
    var pageIsLoading: AnyPublisher<Bool, Never> {
        $isLoading.eraseToAnyPublisher()
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        SSO.isUserLoggedPublisher
            .sink { [weak self] isLogged in
                guard let self else { return }
                guard isLogged else {
                    self.listCells = [self.getInlineFeedbackCell(text: "იმისთვის რომ შეძლო მოცემულ გვერდზე შენი ციფრული სერვისებით სარგებლობა, გაიარე ავტორიზაცია")]
                    return
                }
                self.loadInfo()
            }.store(in: &subscriptions)
    }
    
    private func loadInfo() {
        isLoading = true
        listCells = []
        switch SSO.userInfo?.userType {
        case .student:
            getStudentOptions()
        case .teacher:
            getTeacherOptions()
        default:
            isLoading = false
        }
    }
}

extension MainPageViewModel {
    
    func getRouter() -> AnyPublisher<MainPageRoute?, Never> {
        $router.eraseToAnyPublisher()
    }
}

extension MainPageViewModel {
    
    private func getSpacerCell() -> SpacerCellModel {
        .init()
    }
}

extension MainPageViewModel {
    
    private func getStudentOptions() {
//        studentDashboardOptions = .init(options: [ .library, .subjectCard, .subjectRegistration])
//        draw()
//        isLoading = false
        @Injected var studentOptionsUseCase: StudentDashboardUseCase

        studentOptionsUseCase.getStudentDashboardOptionsInfo(userId: SSO.userInfo?.generalID?.description ?? "")
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.isLoading = false
                case .finished:
                    self?.draw()
                    self?.isLoading = false
                }
            } receiveValue: { [weak self] model in
                self?.studentDashboardOptions = model
            }.store(in: &subscriptions)
    }
    
    private func getTeacherOptions() {
//        teacherDashboardOptions = .init(options: [.library, .library, .subjectCard, .subjectCard, .none])
//        draw()
//        isLoading = false
        @Injected var teacherOptionsUseCase: TeacherDashboardUseCase

        teacherOptionsUseCase.getTeacherDashboardOptionsInfo(userId: SSO.userInfo?.generalID?.description ?? "")
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.isLoading = false
                case .finished:
                    self?.draw()
                    self?.isLoading = false
                }
            } receiveValue: { [weak self] model in
                self?.teacherDashboardOptions = model
            }.store(in: &subscriptions)
    }
}

extension MainPageViewModel {
    
    private func draw() {
        switch SSO.userInfo?.userType {
        case .student:
            handleStudentOptions()
        case .teacher:
            handleTeacherOptions()
        default:
           break
        }
    }
    
    private func handleStudentOptions() {
        studentBanners.map { listCells = $0 }
        if let studentDashboardOptions,
           !studentDashboardOptions.userDashboardOptions.contains(where: { $0 == .subjectRegistration }) {
            listCells.append(getInlineFeedbackCell(text: "აკადემიური რეგისტრაცია ჯერ არ არის ხელმისაწვდომი, გახსნის შემთხვევაში გამოგიჩნდებათ ბანერების სივრცეში"))
        }
    }
    
    private func handleTeacherOptions() {
        teacherBanners.map { listCells = $0 }
    }
}

extension MainPageViewModel {
    
    private var studentBanners: [any CellModel]? {
        guard let studentDashboardOptions else { return nil }
        var rows: [any CellModel] = []
        rows.append(getSpacerCell())
        studentDashboardOptions.userDashboardOptions.forEach { [weak self] type in
            guard let self else { return }
            rows.append(BannerCellModel(model:
                    .init(resourceType: self.getStudentBannerResourceModel(type: type),
                          topLabelModel: .init(text: self.getStudentBannerTitle(type: type),
                                               font: .systemFont(ofSize: .XL)),
                          isChevronNeeded: true,
                          action: { [weak self] in
                self?.handleStudentBannerNavigation(type: type)
            })))
            rows.append(getSpacerCell())
        }
        return rows
    }
    
    private var teacherBanners: [any CellModel]? {
        guard let teacherDashboardOptions else { return nil }
        var rows: [any CellModel] = []
        rows.append(getSpacerCell())
        teacherDashboardOptions.userDashboardOptions.forEach { [weak self] type in
            guard let self else { return }
            rows.append(BannerCellModel(model:
                    .init(resourceType: self.getTeacherBannerResourceModel(type: type),
                          topLabelModel: .init(text: self.getTeacherBannerTitle(type: type)),
                          isChevronNeeded: true,
                          action: { [weak self] in
                self?.handleTeacherBannerNavigation(type: type)
            })))
            rows.append(getSpacerCell())
        }
        return rows
    }
}


//For Student Banners
extension MainPageViewModel {
    private func getStudentBannerTitle(type: StudentDashboardOption) -> String {
        switch type {
        case .subjectCard:
            return "სასწავლო ბარათი"
        case .subjectRegistration:
            return "აკადემიური რეგისტრაცია"
        case .library:
            return "ბიბლიოთეკა"
        case .none:
            return ""
        }
    }
    
    private func getStudentBannerResourceModel(type: StudentDashboardOption) -> ResourceType {
        switch type {
        case .subjectCard:
            return .animation(model: .init(animationName: BrandBookManager.Lottie.cards))
        case .subjectRegistration:
            return .animation(model: .init(animationName: BrandBookManager.Lottie.registration))
        case .library:
            return .animation(model: .init(animationName: BrandBookManager.Lottie.library))
        case .none:
            return .animation(model: .init(animationName: BrandBookManager.Lottie.library))
        }
    }
    
    private func handleStudentBannerNavigation(type: StudentDashboardOption) {
        switch type {
        case .subjectCard:
            router = .studentSubjectCard
        case .subjectRegistration:
            router = .studentSubjectRegistration
        case .library:
            router = .library
        case .none:
            break
        }
    }
}

//For Teacher Banners
extension MainPageViewModel {
    private func getTeacherBannerTitle(type: TeacherDashboardOption) -> String {
        switch type {
        case .subjectCard:
            return "სასწავლო ბარათი"
        case .subjectHistory:
            return "საგნების ისტორია"
        case .library:
            return "ბიბლიოთეკა"
        case .none:
            return ""
        }
    }
    
    private func getTeacherBannerResourceModel(type: TeacherDashboardOption) -> ResourceType {
        switch type {
        case .subjectCard:
            return .animation(model: .init(animationName: BrandBookManager.Lottie.subjects))
        case .subjectHistory:
            return .animation(model: .init(animationName: BrandBookManager.Lottie.library))
        case .library:
            return .animation(model: .init(animationName: BrandBookManager.Lottie.library))
        case .none:
            return .animation(model: .init(animationName: BrandBookManager.Lottie.library))
        }
    }
    
    private func handleTeacherBannerNavigation(type: TeacherDashboardOption) {
        switch type {
        case .subjectCard:
            router = .teacherSubjectCard
        case .subjectHistory:
            break
        case .library:
            router = .library
        case .none:
            break
        }
    }
}

//Inline FeedBack
extension MainPageViewModel {
    
    private func getInlineFeedbackCell(text: String) -> InlineFeedbackCellModel {
        .init(model: .init(titleModel: .init(text: text)))
    }
}
