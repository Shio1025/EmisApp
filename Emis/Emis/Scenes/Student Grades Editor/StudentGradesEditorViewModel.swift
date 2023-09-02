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
    @Published private var editModeIndex: Int?
    
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
    
    private func getRoundedHeaderWithTitle(title: String) -> RoundedHeaderWithTitleModel {
        .init(headerTitle: title)
    }
}

extension StudentGradesEditorViewModel {
    
    private func getStudentGradesDetails() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.draw()
            self.isLoading = false
        }
    }
}

extension StudentGradesEditorViewModel {
    
    private func draw() {
        guard let grades else { return }
        var rows: [any CellModel] = []
        
        listCells = rows
    }
}
