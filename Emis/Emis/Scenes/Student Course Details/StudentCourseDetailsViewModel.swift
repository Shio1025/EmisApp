//
//  StudentCourseDetailsViewModel.swift
//  Emis
//
//  Created by Shio Birbichadze on 03.09.23.
//

import BrandBook
import Combine
import Resolver
import Core
import UIKit

final class StudentCourseDetailsViewModel {
    
    @Published private var listCells: [any CellModel] = []
    @Published private var isLoading: Bool = false
    @Published private var statusBanner: StatusBannerViewModel?
    @Published private var buttonState: ButtonState = .enabled
    @Published private var isStudentsVisible: Bool = false
    @Published private var courseInfo : (URL,String)?
    
    @Injected var urlProvider: ApiURLProvider
    
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
    
    var pdfURL: AnyPublisher <(URL, String), Never> {
        return $courseInfo
            .drop(while: { elems in
                elems == nil
            })
            .map { elems in
                return (elems!.0, elems!.1)
            }.eraseToAnyPublisher()
    }
    
    private var subscriptions = Set<AnyCancellable>()
    private let courseId: Int64
    let name: String
    
    init(courseId: Int64,
         studentId: Int64,
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

extension StudentCourseDetailsViewModel {
    
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

extension StudentCourseDetailsViewModel {
    
    private func getCourseDetails() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
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

extension StudentCourseDetailsViewModel {
    
    private func draw() {
        var rows: [any CellModel] = []
        
//        //description
//        rows.append(getRoundedHeaderWithTitle(title: "აღწერა"))
//        rows.append(LocalLabelCellModel(model: .init(text: teacherCourseInfo.course.subjectDescription)))
//        rows.append(getRoundedFooterModel())
//        rows.append(getSpacerCell())
//
//        //registered/limited students and credits
//        rows.append(getRoundedHeaderModel())
//        rows.append(RowItemCellModel(model:
//                .init(labels: .one(model:
//                        .init(text: "კრედიტები")),
//                      rightItem: .label(model:
//                            .init(text: teacherCourseInfo.course.credits.description)),
//                      isSeparatorNeeded: true)))
//        rows.append(RowItemCellModel(model:
//                .init(labels: .one(model:
//                        .init(text: "დარეგისტრირებული სტუდენტები")),
//                      rightItem: .label(model:
//                            .init(text: teacherCourseInfo.course.studentsRegistered.description)),
//                      isSeparatorNeeded: true)))
//        rows.append(RowItemCellModel(model:
//                .init(labels: .one(model:
//                        .init(text: "სტუდენტების ლიმიტი")),
//                      rightItem: .label(model:
//                            .init(text: teacherCourseInfo.course.studentsLimit.description)))))
//        rows.append(getRoundedFooterModel())
//        rows.append(getSpacerCell())
//
//        //button
//        rows.append(button)
//        rows.append(getSpacerCell())
        
        //Grades
//        rows.append(contentsOf: getGradesSection(students: teacherCourseInfo.students))
        
        
        listCells = rows
    }
    
    private var button: PrimaryButtonCellModel {
        PrimaryButtonCellModel(buttonModels: .init(titleModel: .init(text: "სილაბუსის გადმოწერა  ↓"),
                                                   state: state,
                                                   action: { [weak self] in
            guard let self else { return }
            
            let url = self.urlProvider.getURL(path: "/emis/api/course/syllabus",
                                              params: ["courseId": self.courseId.description])
            if let url {
                self.courseInfo = (url, "")
            }
            
        }))
    }
    
    func getGradesSection(grades: [StudentGrade]) -> [any CellModel] {
        var rows: [any CellModel] = []
        
        rows.append(getRoundedHeaderModel())
        rows.append(contentsOf: getGradesRows(grades: grades))
        rows.append(getRoundedFooterModel())
        rows.append(getSpacerCell())
        
        return rows
    }
    
    func getGradesRows(grades: [StudentGrade]) ->  [any CellModel] {
        grades.enumerated().map { index, model in
            RowItemCellModel(model:
                    .init(labels: .one(model: .init(text: "\(model.gradeComponentName)")),
                          rightItem: .label(model: .init(text: "\(Formatter.formatNumber(number: model.currentPoints)) / \(Formatter.formatNumber(number: model.totalPoints))")),
                          isSeparatorNeeded: index != (grades.count - 1)))
        }
    }
}
