//
//  TeacherSubjectDetailsViewModel.swift
//  Emis
//
//  Created by Shio Birbichadze on 02.09.23.
//

import BrandBook
import Combine
import Resolver
import Core
import UIKit

enum TeacherSubjectDetailsRoute {
    case studentGrades(courseId: Int64,
                       studentId: Int64,
                       studentNameAndSurname: String)
}

final class TeacherSubjectDetailsViewModel {
    
    @Published private var router: TeacherSubjectDetailsRoute?
    @Published private var listCells: [any CellModel] = []
    @Published private var isLoading: Bool = false
    @Published private var statusBanner: StatusBannerViewModel?
    @Published private var buttonState: ButtonState = .enabled
    @Published private var isStudentsVisible: Bool = false
    @Published private var courseInfo : (URL,String)?
    
    private var teacherCourseInfo: TeacherCourseInfo?
    
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
                                           students: [.init(id: 8, firstName: "qfd", lastName: "asd", email: "asd"),
                                                      .init(id: 8, firstName: "qfd", lastName: "asd", email: "asd"),
                                                      .init(id: 8, firstName: "qfd", lastName: "asd", email: "asd"),
                                                      .init(id: 8, firstName: "qfd", lastName: "asd", email: "asd"),
                                                      .init(id: 8, firstName: "qfd", lastName: "asd", email: "asd"),
                                                      .init(id: 8, firstName: "qfd", lastName: "asd", email: "asd"),
                                                      .init(id: 8, firstName: "qfd", lastName: "asd", email: "asd")])
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
        rows.append(contentsOf: getStudentsSection(students: teacherCourseInfo.students))
        
        
        listCells = rows
    }
    
    private var button: PrimaryButtonCellModel {
        PrimaryButtonCellModel(buttonModels: .init(titleModel: .init(text: "სილაბუსის გადმოწერა  ↓"),
                                                               state: state,
                                                               action: { [weak self] in
            guard let self,
                  let teacherCourseInfo = self.teacherCourseInfo else { return }
            
            let url = self.urlProvider.getURL(path: "/emis/api/course/syllabus",
                                              params: ["courseId": self.courseId.description])
            if let url {
                self.courseInfo = (url, teacherCourseInfo.course.subjectDescription )
            }
            
        }))
    }
    
    func getStudentsSection(students: [Student]) -> [any CellModel] {
        var rows: [any CellModel] = []
        
        rows.append(getRoundedHeaderModel())
        let icon = isStudentsVisible
            ? UIImage(systemName: "chevron.up")!
            : UIImage(systemName: "chevron.down")!
        
        rows.append(RowItemCellModel(model:
                .init(labels: .one(model: .init(text: "სტუდენტები",
                                                font: .systemFont(ofSize: .XL))),
                      rightItem: .button(model:
                            .init(resourceType: .icon(icon: icon,
                                                      tintColor: BrandBookManager.Color.Theme.Invert.tr500.uiColor.withAlphaComponent(0.95)),
                                  action: { [weak self] in
            
            self?.isStudentsVisible.toggle()
            self?.draw()
        })),
                                                  tapAction: { [weak self] in
            self?.isStudentsVisible.toggle()
            self?.draw()
        })))
        
        if isStudentsVisible {
            rows.append(contentsOf: getStudentRows(students: students))
        }
        
        rows.append(getRoundedFooterModel())
        rows.append(getSpacerCell())
        
        return rows
    }
    
    func getStudentRows(students: [Student]) ->  [any CellModel] {
        students.enumerated().map { index, model in
            RowItemCellModel(model: .init(labels: .one(model: .init(text: "\(model.firstName) \(model.lastName) - \(model.email)")),
                                          rightItem: .button(model: .init(resourceType: .icon(icon: BrandBookManager.Icon.reminders.template,
                                                                                              tintColor: BrandBookManager.Color.Theme.Component.solid500.uiColor.withAlphaComponent(0.95)),
                                                                          action: { [weak self] in
                guard let self else { return }
                self.router = .studentGrades(courseId: self.courseId,
                                             studentId: model.id,
                                             studentNameAndSurname: "\(model.firstName) \(model.lastName)")
            })),
                                          tapAction: { [weak self] in
                guard let self else { return }
                self.router = .studentGrades(courseId: self.courseId,
                                             studentId: model.id,
                                             studentNameAndSurname: "\(model.firstName) \(model.lastName)")
            },
                                          isSeparatorNeeded: index != (students.count - 1)))
        }
    }
}
