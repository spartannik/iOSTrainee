//
//  CustomTableViewCell.swift
//  iOSTrainee
//
//  Created by Nikita Yashchenko on 22.09.2022.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    
    //MARK: - Cell ID
    static let id = "CustomCell"
    
    //MARK: - Expand/Collapse
    var handleState: (() -> Void) = { }
    
    private enum DescriptionState {
        case collapse
        case expand
        
        mutating func toggle() {
            switch self {
            case .collapse: self = .expand
            case .expand: self = .collapse
            }
        }
    }
    
    private var descriptionState = DescriptionState.collapse
    lazy var buttonHeightConstraint = previewButton.heightAnchor.constraint(equalToConstant: 0)

    //MARK: - UI
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let previewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var previewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Expand", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.backgroundColor = #colorLiteral(red: 0.2775951028, green: 0.3229554296, blue: 0.369166106, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(updatePreviewLabel), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - previewButton func
    @objc private func updatePreviewLabel() {
        switch descriptionState {
        case .expand:
            previewButton.setTitle("Expand", for: .normal)
            heightAnchor.constraint(equalToConstant: 200).isActive = true
            previewLabel.numberOfLines = 2
            handleState()
        case .collapse:
            previewButton.setTitle("Collapse", for: .normal)
            heightAnchor.constraint(equalToConstant: 300).isActive = true
            previewLabel.numberOfLines = 0
            handleState()
        }
        descriptionState.toggle()
    }
    
    //MARK: - Setup Cell
    func setupCell(with p: PostEntity) {
 
        dateLabel.text = p.timestampValue
        titleLabel.text = p.title
        previewLabel.text = p.previewText
        likesLabel.text = "❤️ \(p.likesCount)"

        if p.previewText.count <= 120 {
            previewButton.isHidden = true
            self.buttonHeightConstraint.constant = 0
        } else {
            previewButton.isHidden = false
            self.buttonHeightConstraint.constant = 50
        }

    }
    
    //MARK: - Cell Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout
    private func layout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(previewLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(previewButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
            
            previewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            previewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            previewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            likesLabel.topAnchor.constraint(equalTo: previewLabel.bottomAnchor, constant: 20),
            likesLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: likesLabel.topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            previewButton.topAnchor.constraint(equalTo: likesLabel.bottomAnchor, constant: 20),
            previewButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            previewButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            buttonHeightConstraint,
            previewButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

