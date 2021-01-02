//
//  SearchUserPresenter.swift
//  PassiveViewMVP
//
//  Created by 河明宗 on 2021/01/01.
//  Copyright © 2021 河明宗. All rights reserved.
//

import Foundation
import GitHub

protocol SearchUserPresenterInput {
    var numberOfUsers: Int { get }
    func user(forRow row: Int) -> User?
    func didTapSearchButton(text: String?)
}

protocol SearchUserPresenterOutput: AnyObject {
    func updateUsers(_ users: [User])
}

final class SearchUserPresenter: SearchUserPresenterInput {
    private(set) var users: [User] = []
    
    private weak var view: SearchUserPresenterOutput!
    private var model: SearchUserModelInput
    
    init(view: SearchUserPresenterOutput, model: SearchUserModelInput) {
        self.view = view
        self.model = model
    }
    
    var numberOfUsers: Int {
        return users.count
    }
    
    func user(forRow row: Int) -> User? {
        guard row < users.count else { return nil }
        return users[row]
    }

    func didTapSearchButton(text: String?) {
        guard let query = text else { return }
        guard !query.isEmpty else { return }
        model.fetchUsers(query: query) { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                
                DispatchQueue.main.async {
                    self?.view.updateUsers(users)
                }
            case.failure(let error):
                ()
                // TODO: add error handling
            }
        }
    }
}
