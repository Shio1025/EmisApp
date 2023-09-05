//
//  StudentGradesEditorViewModel.swift
//  Emis
//
//  Created by Shio Birbichadze on 02.09.23.
//

import BrandBook
import Combine
import Resolver
import Core
import UIKit

final class StudentGradesEditorViewModel {
    
    @Published private var listCells: [any CellModel] = []
    @Published private var isLoading: Bool = false
    @Published private var statusBanner: StatusBannerViewModel?
    @Published private var isStudentsVisible: Bool = false
    @Published private var editModeIndex: Int? = nil
    private var grade: Double?
    
    private var grades: [StudentGrade]?
    
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
    private let courseId: Int64
    private let studentId: Int64
    let studentNameAndSurname: String
    
    init(courseId: Int64,
         studentId: Int64,
         studentNameAndSurname: String) {
        self.courseId = courseId
        self.studentNameAndSurname = studentNameAndSurname
        self.studentId = studentId
        loadInfo()
    }
    
    private func loadInfo() {
        isLoading = true
        getStudentGradesDetails()
    }
}
extension StudentGradesEditorViewModel {
    
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

extension StudentGradesEditorViewModel {
    
    private func getStudentGradesDetails() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.grades = [.init(id: 11,
//                                gradeComponentName: "I ქვიზი",
//                                totalPoints: 15,
//                                currentPoints: 12),
//                           .init(id: 11,
//                                 gradeComponentName: "II ქვიზი",
//                                 totalPoints: 15,
//                                 currentPoints: 9),
//                           .init(id: 11,
//                                 gradeComponentName: "შუალედური",
//                                 totalPoints: 20,
//                                 currentPoints: 10),
//                           .init(id: 11,
//                                 gradeComponentName: "დავალებები",
//                                 totalPoints: 20,
//                                 currentPoints: 18),
//                           .init(id: 11,
//                                 gradeComponentName: "ფინალური",
//                                 totalPoints: 30,
//                                 currentPoints: 0)]
//            self.draw()
//            self.isLoading = false
//        }
        
        @Injected var getStudentMarksUseCase: getStudentGradesUseCase
        
        getStudentMarksUseCase.getStudentGrades(courseId: courseId.description,
                                                studentId: studentId.description)
        .sink { [weak self] completion in
            self?.isLoading = false
            switch completion {
            case .finished:
                DispatchQueue.main.async {
                    self?.loadInfo()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.statusBanner = .init(bannerType: .failure,
                                               description: "ბოდიშის გიხდით შეფერხებისთვის")
                }
            }
        } receiveValue: { [weak self] model in
            self?.grades = model
        }.store(in: &subscriptions)
    }
}

extension StudentGradesEditorViewModel {
    
    private func draw() {
        guard let grades else { return }
        
        var rows: [any CellModel] = []
        
        rows.append(getSpacerCell())
        rows.append(getRoundedHeaderModel())
        grades.enumerated().forEach { index, elem in
            let row = RowItemCellModel(model:
                    .init(labels: .one(model: .init(text: elem.gradeComponentName)),
                          rightItem:
                            .labelAndButton(labelModel:
                                    .init(text: "\(Formatter.formatNumber(number: elem.currentPoints)) / \(Formatter.formatNumber(number: elem.totalPoints))"),
                                            buttonModel: .init(resourceType: .icon(icon: UIImage(systemName: "pencil")!,
                                                                                   tintColor: BrandBookManager.Color.Theme.Component.solid500.uiColor.withAlphaComponent(0.95)),
                                                               action: { [weak self] in
                self?.editModeIndex = self?.editModeIndex == index ? nil : index
                self?.draw()
            })),
                          isSeparatorNeeded: index != editModeIndex && index != (grades.count - 1)))
            rows.append(row)
        }
        
        if let editModeIndex {
            rows.insert(contentsOf: getUpdateGradeSection(studentGradeId: grades[editModeIndex].id), at: editModeIndex + 3)
        }
        rows.append(getRoundedFooterModel())
        
        listCells = rows
    }
    
    private func getUpdateGradeSection(studentGradeId: Int64) -> [any CellModel] {
        var rows: [any CellModel] = []
        rows.append(TextFieldCellModel(model: .init(placeholder: "შეიყვანეთ ახალი შეფასება",
                                                    keyboardType: .phonePad,
                                                    onEditingDidEnd: { [weak self] grade in
            guard let grade = Double(grade.trimmingCharacters(in: .whitespaces)) else {
                self?.statusBanner = .init(bannerType: .failure,
                                           description: "შეიყვანეთ სწორი ფორმატით")
                return
            }
            self?.grade = grade
        })))
        
        let editButton = SecondaryButtonModel(titleModel: .init(text: "დამახსოვრება")) { [weak self] in
            self?.handleUpdateGrade(studentGradeId: studentGradeId)
        }
        
        let cancelButton = SecondaryButtonModel(titleModel: .init(text: "გაუქმება"),
                                                backgroundColor: BrandBookManager.Color.Theme.Invert.tr50.uiColor.withAlphaComponent(0.5),
                                                textColor: BrandBookManager.Color.General.black.uiColor) { [weak self] in
            self?.editModeIndex = nil
            self?.grade = nil
            self?.draw()
        }
        
        rows.append(SecondaryButtonsCellModel(buttonModels: [editButton, cancelButton]))
        if (editModeIndex ?? .zero) + 1 != grades?.count { rows.append(SeparatorCellModel()) }
        
        return rows
    }
    
    private func handleUpdateGrade(studentGradeId: Int64) {
        editModeIndex = nil
        grade = nil
        
//        @Injected var updateGradeUseCase: updateGradeUseCase
//        isLoading = true
//        updateGradeUseCase.updateGrade(studentGradeId: studentGradeId.description, mark: grade?.description ?? "")
//            .sink { [weak self] completion in
//                self?.grade = nil
//                self?.isLoading = false
//                switch completion {
//                case .finished:
//                    DispatchQueue.main.async {
//                        self?.loadInfo()
//                    }
//                case .failure(_):
//                    DispatchQueue.main.async {
//                        self?.statusBanner = .init(bannerType: .failure,
//                                                   description: "ბოდიშის გიხდით შეფერხებისთვის")
//                    }
//                }
//            } receiveValue: { _ in
//
//            }.store(in: &subscriptions)
    }
}
