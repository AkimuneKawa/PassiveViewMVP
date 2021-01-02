//
//  SearchUserViewController.swift
//  PassiveViewMVP
//
//  Created by 河明宗 on 2021/01/01.
//  Copyright © 2021 河明宗. All rights reserved.
//

import Foundation
import UIKit
import GitHub

final class SearchUserViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UserCell.Const.cellHeight
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.Const.identifier)
        return tableView
    }()
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "アカウント名を入力してください"
        searchController.searchBar.becomeFirstResponder()
        return searchController
    }()
    
    private var presenter: SearchUserPresenterInput?
    
    func inject(presenter: SearchUserPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        searchController.searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.searchController = searchController
        
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension SearchUserViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.didTapSearchButton(text: searchBar.text)
    }
}

extension SearchUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelectRow(at: indexPath)
    }
}

extension SearchUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfUsers ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.Const.identifier) as! UserCell
        
        if let user = presenter?.user(forRow: indexPath.row) {
            cell.inject(user: user)
        }
        
        return cell
    }
}

extension SearchUserViewController: SearchUserPresenterOutput {
    func transitionToUserDetail(userName: String) {
        let model = UserDetailModel(userName: userName)
        let view = UserDetailViewController()
        let presenter = UserDetailPresenter(userName: userName, view: view, model: model)
        view.inject(presenter: presenter)
        
        navigationController?.pushViewController(view, animated: true)
    }
    
    func updateUsers(_ users: [User]) {
        tableView.reloadData()
    }
}
