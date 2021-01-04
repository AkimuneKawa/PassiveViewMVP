//
//  RepositoryCell.swift
//  PassiveViewMVP
//
//  Created by 河明宗 on 2021/01/03.
//  Copyright © 2021 河明宗. All rights reserved.
//

import Foundation
import UIKit
import GitHub
import SnapKit

final class RepositoryCell: UITableViewCell {
    struct Const {
        static let idenrifier: String = "RepositoryCell"
        static let cellHeight: CGFloat = 48
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        nameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(8)
            $0.right.lessThanOrEqualToSuperview().offset(-8)
            $0.centerY.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
    }
    
    func inject(repository: Repository) {
        nameLabel.text = repository.name
    }
}
