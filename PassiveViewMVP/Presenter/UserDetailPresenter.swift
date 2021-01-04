//
//  UserDetailPresenter.swift
//  PassiveViewMVP
//
//  Created by 河明宗 on 2021/01/03.
//  Copyright © 2021 河明宗. All rights reserved.
//

import Foundation
import GitHub

protocol UserDetailPresenterInput {
    var numberOfRepositories: Int { get }
    func repository(forRow row: Int) -> Repository?
    func viewDidLoad()
}

protocol UserDetailPresenterOutput: AnyObject {
    func updateRepositories(_ repositories: [Repository])
}

final class UserDetailPresenter: UserDetailPresenterInput {
    private let userName: String
    private var repositories: [Repository] = []
    
    private weak var view: UserDetailPresenterOutput!
    private let model: UserDetailModelInput
    
    init(userName: String, view: UserDetailPresenterOutput, model: UserDetailModelInput) {
        self.userName = userName
        self.view = view
        self.model = model
    }
    
    var numberOfRepositories: Int {
        return repositories.count
    }
    
    func repository(forRow row: Int) -> Repository? {
        guard row < repositories.count else { return nil }
        return repositories[row]
    }
    
    func viewDidLoad() {
        model.fetchRepositories() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let repositories):
                self.repositories = repositories
                
                DispatchQueue.main.async {
                    self.view?.updateRepositories(repositories)
                }
            case .failure(let error):
                ()
                // TODO: error handling
            }
        }
    }
}
