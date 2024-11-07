//
//  UsersView.swift
//  TestTaskSwiftUI
//
//  Created by user246073 on 11/3/24.
//

import SwiftUI

struct UsersView: View {
    @StateObject private var viewModel = UsersViewModel()
    
    var body: some View {
        VStack {
            CustomRectangleView()
            Spacer()
            VStack() {
                List {
                    ForEach(viewModel.users, id: \.id) { user in
                        UserViewRow(user: user)
                            .onAppear {
                                // Load the next page when reaching the end of the list
                                if viewModel.users.last == user {
                                    viewModel.fetchUsers()
                                }
                            }
                    }
                    
                    if viewModel.isLoading {
                        VStack {
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                            VStack {
                                Image("NoUsers")
                                Text("There are no users yet")
                            }
                            .offset(y: 200)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .refreshable {
                    viewModel.fetchUsers()
                } // Trigger refresh on swipe
            }
        }
    }
}

    


#Preview {
    UsersView()
}
