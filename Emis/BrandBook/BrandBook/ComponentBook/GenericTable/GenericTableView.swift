//
//  GenericTableView.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 06.06.23.
//

import UIKit

// Protocol for the table view cells
public protocol Cell {
    func bind(with data: any CellModel)
}

public typealias TableCell = Cell & UITableViewCell

public protocol CellModel<T>: ObservableObject where T: TableCell {
    associatedtype T
    var cellType: TableCell.Type { get }
    var cellHeight: CGFloat { get }
}

public extension CellModel {
    var cellHeight: CGFloat { UITableView.automaticDimension }
    var cellType: TableCell.Type { T.self }
}

// Generic table view class that accepts an array of TableViewCell
public class GenericTableView: UITableView, UITableViewDataSource {
    private var cellModels: [any CellModel] = []
    
    public init() {
        super.init(frame: .zero, style: .grouped)
        dataSource = self
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        separatorStyle = .none
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func register<Cell: UITableViewCell>(_ cellType: [Cell.Type]) where Cell: TableCell {
        cellType.forEach { super.register($0, forCellReuseIdentifier: String(describing: $0)) }
    }
    
    public func bind(with data: [any CellModel]) {
        self.cellModels = data
        reloadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellModels[indexPath.row].cellHeight
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = cellModels[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: model.cellType), for: indexPath) as? TableCell
        else {
            return UITableViewCell()
        }
        cell.bind(with: model)
        return cell
    }
}

