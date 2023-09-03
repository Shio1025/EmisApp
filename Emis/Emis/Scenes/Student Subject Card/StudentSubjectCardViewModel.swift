//
//  StudentSubjectCardViewModel.swift
//  Emis
//
//  Created by Shio Birbichadze on 01.09.23.
//

import BrandBook
import UIKit
import Combine
import Resolver
import SSO
import Core

enum StudentSubjectCardRoute {
    case courseInfo(courseId: Int64,
                    studentId: Int64,
                    name: String)
}

final class StudentSubjectCardViewModel {
    
    @Published private var router: StudentSubjectCardRoute?
    @Published private var listCells: [any CellModel] = []
    @Published private var isLoading: Bool = true
    @Published private var statusBanner: StatusBannerViewModel?
    @Injected private var SSO: SSOManager
    
    private var subjectCard: StudentSubjectCard?
    
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
        loadSubjects()
    }
}

extension StudentSubjectCardViewModel {
    
    func getRouter() -> AnyPublisher<StudentSubjectCardRoute?, Never> {
        $router.eraseToAnyPublisher()
    }
}

extension StudentSubjectCardViewModel {
    
    private func getSpacerCell() -> SpacerCellModel {
        .init()
    }
    
    private func getRoundedHeaderWithTitle(title: String) -> RoundedHeaderWithTitleModel {
        .init(headerTitle: title)
    }
    
    private func getRoundedFooterModel() -> RoundedFooterModel {
        .init()
    }
}

extension StudentSubjectCardViewModel {
    
    private func loadSubjects() {
        subjectCard = .init(subjectsBySemester: [[
            .init(studentId: 1,
                  courseName: "პროგრამირების მეთოდოლოგიები", courseId: 3,
                  subjectCode: "CS102A",
                  grade: "A",
                  markInSubject: 96.4,
                  description: ""),
            .init(studentId: 1,
                  courseName: "ანთროპოლოგია", courseId: 3,
                  subjectCode: "DS391",
                  grade: "D",
                  markInSubject: 62.1,
                  description: ""),
            .init(studentId: 1,
                  courseName: "დისკრეტული მათემატიკა", courseId: 3,
                  subjectCode: "CS290C",
                  grade: "B",
                  markInSubject: 88.3,
                  description: ""),
            .init(studentId: 1,
                  courseName: "ლოგიკა", courseId: 3,
                  subjectCode: "KD120A",
                  grade: "A",
                  markInSubject: 100,
                  description: "")],
                                                 [],
                                                 [.init(studentId: 1,
                                                        courseName: "პროგრამირების აბსტრაქციები", courseId: 43,
                                                        subjectCode: "CS123S",
                                                        grade: "B",
                                                        markInSubject: 84.2,
                                                        description: ""),
                                                  .init(studentId: 1,
                                                        courseName: "თეორიული ინფორმატიკა", courseId: 32,
                                                        subjectCode: "CS231B",
                                                        grade: "E",
                                                        markInSubject: 57.4,
                                                        description: "")]])
        isLoading = false
        draw()
        
        
//        @Injected var studentSubjectCardUseCase: StudentSubjectCardUseCase
//
//        studentSubjectCardUseCase.getStudentSubjectCardInfo(userId: SSO.userInfo?.userId?.description ?? "")
//            .sink { [weak self] completion in
//                guard let self else { return }
//                switch completion {
//                case .finished:
//                    self.draw()
//                    self.isLoading = false
//                case .failure(let error):
//                    self.isLoading = false
//                    self.statusBanner = .init(bannerType: .failure,
//                                              description: error.localizedDescription)
//                }
//            } receiveValue: { [weak self] model in
//                self?.subjectCard = model
//            }.store(in: &subscriptions)
    }
}

extension StudentSubjectCardViewModel {
    
    private func draw() {
        getSubjects().map { listCells = $0 }
    }
    
    func getSubjects() -> [any CellModel]? {
        guard let subjectCard else { return nil }
        var rows: [any CellModel] = []
        
        subjectCard.reversedSubjectsList.enumerated().forEach { index, subjects in
            rows.append(contentsOf: getSubjectsBySemester(index: subjectCard.reversedSubjectsList.count - index,
                                                          subjects: subjects))
        }
        
        return rows
    }
    
    func getSubjectsBySemester(index: Int,
                               subjects: [SubjectInfo]) -> [any CellModel] {
        var rows: [any CellModel] = []
        rows.append(getSpacerCell())
        let subjectsRows: [any CellModel] = subjects.enumerated().map { index, subject in
            let row = RowItemCellModel(model: .init(leftItem: .icon(icon: BrandBookManager.Icon.subjectCard.template,
                                                                    tintColor: BrandBookManager.Color.Theme.Component.solid500.uiColor.withAlphaComponent(0.8)),
                                                    labels: .two(top: .init(text: "\(subject.courseName)",
                                                                            font: .systemFont(ofSize: .M)),
                                                                 bottom: .init(text: subject.subjectCode.description,
                                                                               font: .systemFont(ofSize: .M,
                                                                                                 weight: .light))),
                                                    rightItem: .label(model: .init(text: "\(Formatter.formatNumber(number: subject.markInSubject)) - \(subject.grade)")),
                                                    tapAction: { [weak self] in
                guard let self else { return }
                self.router = .courseInfo(courseId: subject.courseId,
                                          studentId: subject.studentId,
                                          name: subject.courseName)
            },
                                                    isSeparatorNeeded: index != (subjects.count - 1)))
            return row
        }
        
        rows.append(getRoundedHeaderWithTitle(title: "სემესტრი \(index)"))
        if subjectsRows.isEmpty {
            rows.append(PageDescriptionCellModel(model:
                    .init(resourceType: .animation(model: .init(animationName: BrandBookManager.Lottie.lazy,
                                                                bundle: Bundle(identifier: "Shio.BrandBook")!)),
                          description: .init(text: "როგორც ჩანს ისვენებდი 🏖️"))))
        } else {
            rows.append(contentsOf: subjectsRows)
        }
        rows.append(getRoundedFooterModel())
        rows.append(getSpacerCell())
        
        return rows
    }
}
