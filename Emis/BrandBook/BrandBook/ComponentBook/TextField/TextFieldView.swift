//
//  TextFieldView.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 11.05.23.
//
import UIKit
import Combine

public class TextFieldView: UIView {
    
    private var cancellables: Set<AnyCancellable> = []
    private var onEditingDidEnd: ((String) -> Void)?
    
    @Published var bgColor: UIColor = textFieldState.inactive.backgroundColor
    @Published var borderColor: UIColor = textFieldState.inactive.borderColor
    @Published var textColor: UIColor = textFieldState.inactive.textColor

    public var textPublisher: AnyPublisher<String?, Never> {
        textField
            .publisher(for: \.text)
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .clear
        textField.textColor = .clear
        return textField
    }()
    
    private lazy var textFieldHolder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var textFieldContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = .S
        return stackView
    }()
    
    private lazy var leadingLabel: LocalLabel = {
        let label = LocalLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trailingLabel: LocalLabel = {
        let label = LocalLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isHidden = true
        return view
    }()

    public init() {
        super.init(frame: .zero)
        addSubviews()
        setUpUI()
        addConstraints()
    }
    
    public convenience init(model: TextFieldViewModel) {
        self.init()
        configure(model: model)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func  addSubviews() {
        textFieldHolder.addSubview(textField)
        textFieldContainer.addSubview(textFieldHolder)
        labelsContainer.addSubview(trailingLabel)
        labelsContainer.addSubview(leadingLabel)
        stackView.addArrangedSubview(textFieldContainer)
        stackView.addArrangedSubview(labelsContainer)
        self.addSubview(stackView)
    }
    
    private func setUpUI() {
        backgroundColor = .clear
        setUpTextFieldAppearance()
    }
    
    private func addConstraints() {
        textField.top(toView: textFieldHolder, constant: .XS)
        textField.bottom(toView: textFieldHolder, constant: .XS)
        textField.left(toView: textFieldHolder, constant: .XS)
        textField.right(toView: textFieldHolder, constant: .XS)
        
        textFieldHolder.top(toView: textFieldContainer, constant: 1)
        textFieldHolder.bottom(toView: textFieldContainer, constant: 1)
        textFieldHolder.left(toView: textFieldContainer, constant: 1)
        textFieldHolder.right(toView: textFieldContainer, constant: 1)
        
        trailingLabel.right(toView: labelsContainer)
        trailingLabel.top(toView: labelsContainer)
        leadingLabel.left(toView: labelsContainer)
        leadingLabel.top(toView: labelsContainer)
        
        stackView.top(toView: self)
        stackView.bottom(toView: self)
        stackView.left(toView: self)
        stackView.right(toView: self)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        textFieldContainer.layer.cornerRadius = .S
        textFieldContainer.clipsToBounds = true
        textFieldHolder.layer.cornerRadius = .S
        textFieldHolder.clipsToBounds = true
    }
}

extension TextFieldView {
    
    func setUpTextFieldAppearance() {
        $bgColor.assign(to: \.backgroundColor!, on: textFieldHolder).store(in: &cancellables)
        $borderColor.assign(to: \.backgroundColor!, on: textFieldContainer).store(in: &cancellables)
        $textColor.assign(to: \.textColor!, on: textField).store(in: &cancellables)
    }
}

extension TextFieldView {
    
    public func configure(model: TextFieldViewModel) {
        onEditingDidEnd = model.onEditingDidEnd
        textField.delegate = self
        configureTextField(with: model)
    }
    
    func configureTextField(with model: TextFieldViewModel) {
        if let placeholder = model.placeholder {
            textField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: textFieldState.inactive.placeholderColor])
        }
        
        if let leadingTextModel = model.leadingLabelModel {
            leadingLabel.configure(with: leadingTextModel)
            labelsContainer.isHidden = false
        }
        
        if let trailingTextModel = model.trailingLabelModel {
            trailingLabel.configure(with: trailingTextModel)
            labelsContainer.isHidden = false
        }
    }
}

extension TextFieldView: UITextFieldDelegate {
    
    @objc public func textFieldDidEndEditing(_ textField: UITextField) {
        textColor = textFieldState.inactive.textColor
        bgColor = textFieldState.inactive.backgroundColor
        borderColor = textFieldState.inactive.borderColor
        onEditingDidEnd?(textField.text ?? "")
    }
    
    @objc public func textFieldDidBeginEditing(_ textField: UITextField) {
        textColor = textFieldState.inProgressOfEditing.textColor
        bgColor = textFieldState.inProgressOfEditing.backgroundColor
        borderColor = textFieldState.inProgressOfEditing.borderColor
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}