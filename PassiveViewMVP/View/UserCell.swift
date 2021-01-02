//
//  UserCell.swift
//  PassiveViewMVP
//
//  Created by 河明宗 on 2021/01/02.
//  Copyright © 2021 河明宗. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import GitHub

final class UserCell: UITableViewCell {
    struct Const {
        static let identifier: String = "UserCell"
        static let iconSize: CGFloat = 48
        static let cellHeight: CGFloat = iconSize + 20
    }
    
    var user: User?
    
    let icon: UIView = {
        let icon = UIView(frame: CGRect(x: 0, y: 0, width: Const.iconSize, height: Const.iconSize))
        icon.backgroundColor = .gray
        icon.contentMode = .scaleAspectFill
        icon.layer.masksToBounds = true
        icon.layer.cornerRadius = Const.iconSize / 2.0
        return icon
    }()
    
    let nameLabel: UILabel = {
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
        addSubview(icon)
        addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        icon.snp.makeConstraints {
            $0.size.equalTo(Const.iconSize)
            $0.left.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
        }
        nameLabel.snp.makeConstraints {
            $0.left.equalTo(icon.snp.right).offset(8)
            $0.right.lessThanOrEqualToSuperview().offset(-8)
            $0.centerY.equalToSuperview()
        }
    }
    
    func inject(user: User) {
        self.user = user
        nameLabel.text = user.login
    }
}
