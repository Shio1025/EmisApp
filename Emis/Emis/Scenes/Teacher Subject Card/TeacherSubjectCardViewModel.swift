//
//  TeacherSubjectCardViewModel.swift
//  Emis
//
//  Created by Shio Birbichadze on 02.09.23.
//

import BrandBook
import Combine
import Resolver
import SSO
import Core
import UIKit

enum TeacherSubjectCardRoute {
    case courseInfo(courseId: Int64,
                    name: String)
}

final class TeacherSubjectCardViewModel {
    
    @Published private var router: TeacherSubjectCardRoute?
    @Published private var listCells: [any CellModel] = []
    @Published private var isLoading: Bool = false
    @Published private var teacherSubjectCardInfo: [TeacherSubjectCard]?
    @Published private var statusBanner: StatusBannerViewModel?
    @Injected private var SSO: SSOManager
    
    var listCellModels: AnyPublisher<[any CellModel], Never> {
        $listCells.eraseToAnyPublisher()
    }
    
    var pageIsLoading: AnyPublisher<Bool, Never> {
        $isLoading.eraseToAnyPublisher()
    }
    
    var displayBannerPublisher: AnyPublisher<StatusBannerViewModel, Never> {
         $statusBanner
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        loadInfo()
    }
    
    private func loadInfo() {
        isLoading = true
        getCourses()
    }
}

extension TeacherSubjectCardViewModel {
    
    func getRouter() -> AnyPublisher<TeacherSubjectCardRoute?, Never> {
        $router.eraseToAnyPublisher()
    }
}

extension TeacherSubjectCardViewModel {
    
    private func getSpacerCell() -> SpacerCellModel {
        .init()
    }
    
    private func getRoundedFooterModel() -> RoundedFooterModel {
        .init()
    }
    
    private func getRoundedHeaderModel() -> RoundedHeaderModel {
        .init()
    }
}

extension TeacherSubjectCardViewModel {
    
    private func getCourses() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//            self.teacherSubjectCardInfo = [.init(courseId: 1, subjectCode: "AS129", subjectName: "ანთროპოლოგია")]
//            self.draw()
//            self.isLoading = false
//        }
        
        @Injected var getCoursesUseCase: TeacherSubjectCardUseCase

        getCoursesUseCase.getTeacherSubjectCardInfo(userId: SSO.userInfo?.userId?.description ?? "")
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    DispatchQueue.main.async {
                        self?.draw()
                        self?.isLoading = false
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.isLoading = false
                        self?.statusBanner = .init(bannerType: .failure,
                                                   description: "ბოდიშს გიხდით შეფერხებისთვის")
                    }
                }
            } receiveValue: { [weak self] model in
                self?.teacherSubjectCardInfo = model
            }.store(in: &subscriptions)
    }
}

extension TeacherSubjectCardViewModel {
    
    private func draw() {
        guard let teacherSubjectCardInfo else { return }
        
        var rows: [any CellModel] = []
        
        rows.append(getSpacerCell())
        teacherSubjectCardInfo.forEach { elem in
            rows.append(getRoundedHeaderModel())
            rows.append(RowItemCellModel(model:
                    .init(labels: .one(model:
                            .init(text: "\(elem.subjectCode) - \(elem.subjectName)",
                                  font: .systemFont(ofSize: .XL,
                                                    weight: .light))),
                          rightItem: .button(model:
                                .init(resourceType: .icon(icon: UIImage(systemName: "chevron.right")!,
                                                          tintColor: BrandBookManager.Color.Theme.Invert.tr500.uiColor.withAlphaComponent(0.9)),
                                      action: { [weak self] in
                self?.router = .courseInfo(courseId: elem.courseId,
                                           name: elem.subjectName)
            })),
                          tapAction: { [weak self] in
                self?.router = .courseInfo(courseId: elem.courseId,
                                           name: elem.subjectName)
            })))
            rows.append(getRoundedFooterModel())
            rows.append(getSpacerCell())
        }
        
        listCells = rows
    }
}


