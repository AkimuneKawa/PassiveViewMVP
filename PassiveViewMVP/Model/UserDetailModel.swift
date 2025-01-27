//
//  RepositoryListModel.swift
//  PassiveViewMVP
//
//  Created by 河明宗 on 2021/01/02.
//  Copyright © 2021 河明宗. All rights reserved.
//

import Foundation
import GitHub

protocol UserDetailModelInput {
    func fetchRepositories(completion: @escaping (Result<[Repository]>) -> ())
}

final class UserDetailModel: UserDetailModelInput {
    private let userName: String!
    init(userName: String) {
        self.userName = userName
    }
    
    func fetchRepositories(completion: @escaping (Result<[Repository]>) -> ()) {
        let session = GitHub.Session()
        let request = UserReposRequest(username: userName, type: nil, sort: nil, direction: nil, page: nil, perPage: nil)
        session.send(request) { result in
            switch result {
            case .success(let response):
                completion(.success(response.0))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
