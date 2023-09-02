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

final class StudentSubjectCardViewModel {
    
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
        subjectCard = .init(subjectsBySemester: [[.init(studentId: 1,
                                                        courseName: "petre", courseId: 43,
                                                        subjectCode: "sldnvs",
                                                        grade: "A",
                                                        markInSubject: 97,
                                                        description: "sjdnvsj"),
                                                  .init(studentId: 1,
                                                        courseName: "petre", courseId: 32,
                                                        subjectCode: "sldnvs",
                                                        grade: "A",
                                                        markInSubject: 97,
                                                        description: "sjdnvsj"),
                                                  .init(studentId: 1,
                                                        courseName: "petre", courseId: 3333,
                                                        subjectCode: "sldnvs",
                                                        grade: "A",
                                                        markInSubject: 97,
                                                        description: "sjdnvsj"),
                                                  .init(studentId: 1,
                                                        courseName: "petre", courseId: 33,
                                                        subjectCode: "sldnvs",
                                                        grade: "A",
                                                        markInSubject: 97,
                                                        description: "sjdnvsj"),
                                                  .init(studentId: 1,
                                                        courseName: "petre", courseId: 333,
                                                        subjectCode: "sldnvs",
                                                        grade: "A",
                                                        markInSubject: 97,
                                                        description: "sjdnvsj")],
                                                 [
                                                  .init(studentId: 1,
                                                        courseName: "petre", courseId: 33,
                                                        subjectCode: "sldnvs",
                                                        grade: "A",
                                                        markInSubject: 97,
                                                        description: "sjdnvsj")],
                                                 [.init(studentId: 1,
                                                        courseName: "petre", courseId: 233,
                                                        subjectCode: "sldnvs",
                                                        grade: "A",
                                                        markInSubject: 97,
                                                        description: "sjdnvsj")],
                                                 [
                                                  .init(studentId: 1,
                                                        courseName: "petre", courseId: 3,
                                                        subjectCode: "sldnvs",
                                                        grade: "A",
                                                        markInSubject: 97,
                                                        description: "sjdnvsj"),
                                                  .init(studentId: 1,
                                                        courseName: "petre", courseId: 3,
                                                        subjectCode: "sldnvs",
                                                        grade: "A",
                                                        markInSubject: 97,
                                                        description: "sjdnvsj"),
                                                  .init(studentId: 1,
                                                        courseName: "petre", courseId: 3,
                                                        subjectCode: "sldnvs",
                                                        grade: "A",
                                                        markInSubject: 97,
                                                        description: "sjdnvsj"),
                                                  .init(studentId: 1,
                                                        courseName: "petre", courseId: 3,
                                                        subjectCode: "sldnvs",
                                                        grade: "A",
                                                        markInSubject: 97,
                                                        description: "sjdnvsj")],
                                                []])
        isLoading = false
        draw()
        //courseId
        //subjectName
        //subjectCode
        
        
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
        
        let subjectsRows: [any CellModel] = subjects.enumerated().map { index, subject in
            let row = RowItemCellModel(model: .init(leftItem: .icon(icon: UIImage(systemName: "chevron.left")!,
                                                                    tintColor: BrandBookManager.Color.Theme.Component.solid500.uiColor.withAlphaComponent(0.8)),
                                                    labels: .two(top: .init(text: "\(subject.subjectCode) - \(subject.courseName)",
                                                                            font: .systemFont(ofSize: .L)),
                                                                 bottom: .init(text: subject.description,
                                                                               font: .systemFont(ofSize: .M,
                                                                                                 weight: .light))),
                                                    rightItem: .label(model: .init(text: "\(Formatter.formatNumber(number: subject.markInSubject)) - \(subject.grade)")),
                                                    tapAction: {
                
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
