//
//  SearchUserModel.swift
//  PassiveViewMVP
//
//  Created by 河明宗 on 2021/01/02.
//  Copyright © 2021 河明宗. All rights reserved.
//

import Foundation
import GitHub

protocol SearchUserModelInput {
    func fetchUsers(
        query: String,
        completion: @escaping (Result<[User]>) -> ()
    )
}

final class SearchUserModel: SearchUserModelInput {
    func fetchUsers(query: String, completion: @escaping (Result<[User]>) -> ()) {
        let session = GitHub.Session()
        let request = SearchUsersRequest(
            query: query,
            sort: nil,
            order: nil,
            page: nil,
            perPage: nil)
        
        session.send(request) { result in
            switch result {
            case .success(let response):
                completion(.success(response.0.items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
