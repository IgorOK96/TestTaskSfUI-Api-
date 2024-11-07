//
//  UserListViewModel.swift
//  TestTaskSwiftUI
//
//  Created by user246073 on 11/5/24.
//

import SwiftUI

class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var currentPage = 1
    private var totalPages = 1

    init() {
        fetchUsers()
    }

    func fetchUsers() {
        guard !isLoading else { return }
        guard currentPage <= totalPages else { return }

        isLoading = true
        errorMessage = nil

        NetworkManager.shared.getUsers(page: currentPage, count: 6) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.users.append(contentsOf: response.users)
                    self?.currentPage += 1
                    self?.totalPages = response.total_pages
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}


