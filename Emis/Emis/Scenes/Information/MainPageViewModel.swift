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
                guard let self,
                      isLogged else { return }
                self.isLoading = true
                switch self.SSO.userType {
                case .student:
                    self.getStudentOptions()
                case .teacher:
                    self.getTeacherOptions()
                default:
                    self.isLoading = false
                }
            }.store(in: &subscriptions)
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
        studentDashboardOptions = .init(options: [.subjectCard, .subjectCard, .library, .subjectRegistration])
        draw()
        isLoading = false
//        @Injected var studentOptionsUseCase: StudentDashboardUseCase
//
//        studentOptionsUseCase.getStudentDashboardOptionsInfo(userId: SSO.userId?.description ?? "")
//            .sink { [weak self] completion in
//                switch completion {
//                case .failure(let error):
//                    self?.isLoading = false
//                case .finished:
//                    self?.draw()
//                    self?.isLoading = false
//                }
//            } receiveValue: { [weak self] model in
//                self?.studentDashboardOptions = model
//            }.store(in: &subscriptions)
    }
    
    private func getTeacherOptions() {
        teacherDashboardOptions = .init(options: [.library, .library, .subjectCard, .subjectHistory, .subjectCard, .none])
        draw()
        isLoading = false
//        @Injected var teacherOptionsUseCase: TeacherDashboardUseCase
//
//        teacherOptionsUseCase.getTeacherDashboardOptionsInfo(userId: SSO.userId?.description ?? "")
//            .sink { [weak self] completion in
//                switch completion {
//                case .failure(let error):
//                    self?.isLoading = false
//                case .finished:
//                    self?.draw()
//                    self?.isLoading = false
//                }
//            } receiveValue: { [weak self] model in
//                self?.teacherDashboardOptions = model
//            }.store(in: &subscriptions)
    }
}

extension MainPageViewModel {
    
    private func draw() {
        switch SSO.userType {
        case .student:
            handleStudentOptions()
        case .teacher:
            handleTeacherOptions()
        default:
           break
        }
    }
    
    private func handleStudentOptions() {
        studentBanners.map { listCells.append(contentsOf: $0) }
    }
    
    private func handleTeacherOptions() {
        teacherBanners.map { listCells.append(contentsOf: $0) }
    }
}

extension MainPageViewModel {
    
    private var studentBanners: [any CellModel]? {
        guard let studentDashboardOptions else { return nil }
        var rows: [any CellModel] = []
        studentDashboardOptions.userDashboardOptions.forEach { [weak self] type in
            guard let self else { return }
            rows.append(BannerCellModel(model:
                    .init(resourceType: .image(image: self.getStudentBannerImage(type: type)),
                          topLabelModel: .init(text: self.getStudentBannerTitle(type: type)),
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
        teacherDashboardOptions.userDashboardOptions.forEach { [weak self] type in
            guard let self else { return }
            rows.append(BannerCellModel(model:
                    .init(resourceType: .image(image: self.getTeacherBannerImage(type: type)),
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
    
    private func getStudentBannerImage(type: StudentDashboardOption) -> UIImage {
        switch type {
        case .subjectCard:
            return BrandBookManager.Images.tmp.image
        case .subjectRegistration:
            return BrandBookManager.Images.tmp.image
        case .library:
            return BrandBookManager.Images.tmp.image
        case .none:
            return BrandBookManager.Images.tmp.image
        }
    }
    
    private func handleStudentBannerNavigation(type: StudentDashboardOption) {
        switch type {
        case .subjectCard:
            break
        case .subjectRegistration:
            break
        case .library:
            break
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
    
    private func getTeacherBannerImage(type: TeacherDashboardOption) -> UIImage {
        switch type {
        case .subjectCard:
            return BrandBookManager.Images.tmp.image
        case .subjectHistory:
            return BrandBookManager.Images.tmp.image
        case .library:
            return BrandBookManager.Images.tmp.image
        case .none:
            return BrandBookManager.Images.tmp.image
        }
    }
    
    private func handleTeacherBannerNavigation(type: TeacherDashboardOption) {
        switch type {
        case .subjectCard:
            break
        case .subjectHistory:
            break
        case .library:
            break
        case .none:
            break
        }
    }
}
