//
//  UserDetailViewController.swift
//  PassiveViewMVP
//
//  Created by 河明宗 on 2021/01/03.
//  Copyright © 2021 河明宗. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import GitHub

final class UserDetailViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.Const.idenrifier)
        tableView.rowHeight = RepositoryCell.Const.cellHeight
        return tableView
    }()
    
    var presenter: UserDetailPresenterInput?
    
    func inject(presenter: UserDetailPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        
        presenter?.viewDidLoad()
    }
    
    private func setupViews() {
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension UserDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRepositories ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.Const.idenrifier) as! RepositoryCell
        
        if let repo = presenter?.repository(forRow: indexPath.row) {
            cell.inject(repository: repo)
        }
        
        return cell
    }
}

extension UserDetailViewController: UserDetailPresenterOutput {
    func updateRepositories(_ repositories: [Repository]) {
        tableView.reloadData()
    }
}
