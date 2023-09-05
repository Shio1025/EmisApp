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
    
    private var studentCourseInfo: StudentCourseInfo?
    
    @Injected var urlProvider: ApiURLProvider
    @Injected var studentCourseInfoUseCase: StudentCourseInfoUseCase
    
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
    private let studentId: Int64
    private let courseId: Int64
    let name: String
    
    init(courseId: Int64,
         studentId: Int64,
         name: String) {
        self.courseId = courseId
        self.studentId = studentId
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
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.studentCourseInfo = .init(course: .init(id: 123, subjectDescription: "მეცნიერება ადამიანის წარმოშობისა და ევოლუციის, ადამიანთა რასებისა და ადამიანის ფიზიკური აღნაგობის ნორმალური ვარიაციების შესახებ, შეისწავლის პირველყოფილი, ტრადიციული და თანამედროვე საზოგადოებების კულტურას და ადამიანის მოღვაწეობის მრავალგვარ ფორმებს", credits: 4, studentsLimit: 300, studentsRegistered: 289),
//                                           studentGradeInfo: [.init(id: 11,
//                                                                    gradeComponentName: "I ქვიზი",
//                                                                    totalPoints: 15,
//                                                                    currentPoints: 12),
//                                                              .init(id: 11,
//                                                                                       gradeComponentName: "II ქვიზი",
//                                                                                       totalPoints: 15,
//                                                                                       currentPoints: 9),
//                                                              .init(id: 11,
//                                                                                       gradeComponentName: "შუალედური",
//                                                                                       totalPoints: 20,
//                                                                                       currentPoints: 10),
//                                                              .init(id: 11,
//                                                                                       gradeComponentName: "დავალებები",
//                                                                                       totalPoints: 20,
//                                                                                       currentPoints: 18),
//                                                              .init(id: 11,
//                                                                                       gradeComponentName: "ფინალური",
//                                                                                       totalPoints: 30,
//                                                                                       currentPoints: 0)])
//            self.draw()
//            self.isLoading = false
//        }
        

        studentCourseInfoUseCase.getStudentCourseInfo(courseId: courseId.description,
                                                      studentId: studentId.description)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    DispatchQueue.main.async {
                        self?.isLoading = false
                        self?.draw()
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self?.isLoading = false
                        self?.statusBanner = .init(bannerType: .failure,
                                                   description: "ბოდიშს გიხდით შეფერხებისთვის")
                    }
                }
            } receiveValue: { [weak self] model in
                self?.studentCourseInfo = model
            }.store(in: &subscriptions)
    }
}

extension StudentCourseDetailsViewModel {
    
    private func draw() {
        guard let studentCourseInfo else { return }
        var rows: [any CellModel] = []
        
        rows.append(getSpacerCell())
        
        //description
        rows.append(getRoundedHeaderWithTitle(title: "აღწერა"))
        rows.append(LocalLabelCellModel(model: .init(text: studentCourseInfo.course.subjectDescription)))
        rows.append(getRoundedFooterModel())
        rows.append(getSpacerCell())

        //registered/limited students and credits
        rows.append(getRoundedHeaderModel())
        rows.append(RowItemCellModel(model:
                .init(labels: .one(model:
                        .init(text: "კრედიტები")),
                      rightItem: .label(model:
                            .init(text: studentCourseInfo.course.credits.description)),
                      isSeparatorNeeded: true)))
        rows.append(RowItemCellModel(model:
                .init(labels: .one(model:
                        .init(text: "დარეგისტრირებული სტუდენტები")),
                      rightItem: .label(model:
                            .init(text: studentCourseInfo.course.studentsRegistered.description)),
                      isSeparatorNeeded: true)))
        rows.append(RowItemCellModel(model:
                .init(labels: .one(model:
                        .init(text: "სტუდენტების ლიმიტი")),
                      rightItem: .label(model:
                            .init(text: studentCourseInfo.course.studentsLimit.description)))))
        rows.append(getRoundedFooterModel())
        rows.append(getSpacerCell())

        //button
        rows.append(button)
        rows.append(getSpacerCell())
        
        //Grades
        rows.append(contentsOf: getGradesSection(grades: studentCourseInfo.studentGradeInfo))
        
        
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
                self.courseInfo = (url, "syllabus")
            }
            
        }))
    }
    
    func getGradesSection(grades: [StudentGrade]) -> [any CellModel] {
        var rows: [any CellModel] = []
        
        rows.append(getRoundedHeaderWithTitle(title: "შეფასება"))
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
