//
//  TeacherSubjectDetailsViewModel.swift
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

enum TeacherSubjectDetailsRoute {
    
}

final class TeacherSubjectDetailsViewModel {
    
    @Published private var router: TeacherSubjectDetailsRoute?
    @Published private var listCells: [any CellModel] = []
    @Published private var isLoading: Bool = false
    @Published private var statusBanner: StatusBannerViewModel?
    @Published private var buttonState: ButtonState = .enabled
    
    private var teacherCourseInfo: TeacherCourseInfo?
    
    var listCellModels: AnyPublisher<[any CellModel], Never> {
        $listCells.eraseToAnyPublisher()
    }
    
    var pageIsLoading: AnyPublisher<Bool, Never> {
        $isLoading.eraseToAnyPublisher()
    }
    
    var state: AnyPublisher<ButtonState, Never> {
        return $buttonState
            .eraseToAnyPublisher()
    }
    
    var displayBannerPublisher: AnyPublisher<StatusBannerViewModel, Never> {
         $statusBanner
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    private var subscriptions = Set<AnyCancellable>()
    private let courseId: Int64
    let name: String
    
    init(courseId: Int64,
         name: String) {
        self.courseId = courseId
        self.name = name
        loadInfo()
    }
    
    private func loadInfo() {
        isLoading = true
        getCourseDetails()
    }
}

extension TeacherSubjectDetailsViewModel {
    
    func getRouter() -> AnyPublisher<TeacherSubjectDetailsRoute?, Never> {
        $router.eraseToAnyPublisher()
    }
}

extension TeacherSubjectDetailsViewModel {
    
    private func getSpacerCell() -> SpacerCellModel {
        .init()
    }
    
    private func getRoundedFooterModel() -> RoundedFooterModel {
        .init()
    }
    
    private func getRoundedHeaderModel() -> RoundedHeaderModel {
        .init()
    }
    
    private func getRoundedHeaderWithTitle(title: String) -> RoundedHeaderWithTitleModel {
        .init(headerTitle: title)
    }
}

extension TeacherSubjectDetailsViewModel {
    
    private func getCourseDetails() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.teacherCourseInfo = .init(course: .init(id: 1,
                                                         subjectDescription: "sdjbcvjsbcdjbsihdvsbdvbsidcijsjcbljnsxakjlc nkjasnkxjc sdfawdfasdasdvcsdvcsdvcsdv",
                                                         credits: 23,
                                                         studentsLimit: 23,
                                                         studentsRegistered: 19),
                                           students: [])
            self.draw()
            self.isLoading = false
        }
        
//        @Injected var teacherCourseInfoUseCase: TeacherCourseInfoUseCase
//
//        teacherCourseInfoUseCase.getTeacherCourseInfo(courseId: courseId.description)
//            .sink { [weak self] completion in
//                switch completion {
//                case .finished:
//                    DispatchQueue.main.async {
//                        self?.isLoading = false
//                        self?.draw()
//                    }
//                case .failure(_):
//                    DispatchQueue.main.async {
//                        self?.isLoading = false
//                        self?.statusBanner = .init(bannerType: .failure,
//                                                   description: "ბოდიშს გიხდით შეფერხებისთვის")
//                    }
//                }
//            } receiveValue: { [weak self] model in
//                self?.teacherCourseInfo = model
//            }.store(in: &subscriptions)
    }
}

extension TeacherSubjectDetailsViewModel {
    
    private func draw() {
        guard let teacherCourseInfo else { return }
        var rows: [any CellModel] = []
        
        //description
        rows.append(getRoundedHeaderWithTitle(title: "აღწერა"))
        rows.append(LocalLabelCellModel(model: .init(text: teacherCourseInfo.course.subjectDescription)))
        rows.append(getRoundedFooterModel())
        rows.append(getSpacerCell())
        
        //registered/limited students and credits
        rows.append(getRoundedHeaderModel())
        rows.append(RowItemCellModel(model:
                .init(labels: .one(model:
                        .init(text: "კრედიტები")),
                      rightItem: .label(model:
                            .init(text: teacherCourseInfo.course.credits.description)),
                      isSeparatorNeeded: true)))
        rows.append(RowItemCellModel(model:
                .init(labels: .one(model:
                        .init(text: "დარეგისტრირებული სტუდენტები")),
                      rightItem: .label(model:
                            .init(text: teacherCourseInfo.course.studentsRegistered.description)),
                      isSeparatorNeeded: true)))
        rows.append(RowItemCellModel(model:
                .init(labels: .one(model:
                        .init(text: "სტუდენტების ლიმიტი")),
                      rightItem: .label(model:
                            .init(text: teacherCourseInfo.course.studentsLimit.description)))))
        rows.append(getRoundedFooterModel())
        rows.append(getSpacerCell())
        
        //button
        rows.append(button)
        rows.append(getSpacerCell())
        
        //Students
        
        
        listCells = rows
    }
    
    private var button: PrimaryButtonCellModel {
        PrimaryButtonCellModel(buttonModels: .init(titleModel: .init(text: "სილაბუსის გადმოწერა  ↓"),
                                                               state: state,
                                                               action: {
            
        }))
    }
}
