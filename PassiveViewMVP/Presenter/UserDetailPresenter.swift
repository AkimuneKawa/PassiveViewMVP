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

