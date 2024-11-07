//
//  UserViewRow.swift
//  TestTaskSwiftUI
//
//  Created by user246073 on 11/3/24.
//

import SwiftUI

struct UserViewRow: View {
    let user: User

    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 16) {
                AsyncImage(url: URL(string: user.photo)) { image in
                    image
                        .resizable()
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 48, height: 48)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(user.name)
                        .font(.custom("NunitoSans-Regular", size: 16))
                        .lineLimit(3)
                        .lineSpacing(8)
                        .multilineTextAlignment(.leading)

                    VStack(alignment: .leading, spacing: 8) {
                        Text(user.position)
                            .font(.custom("NunitoSans-Regular", size: 18))
                            .foregroundColor(.gray)
                            .lineSpacing(6)

                        Text(user.email)
                            .font(.custom("NunitoSans-Regular", size: 14))
                            .foregroundColor(.gray)
                            .lineLimit(1)
                            .lineSpacing(6)
                            .truncationMode(.middle)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .truncationMode(.tail)

                        Text(user.phone)
                            .font(.custom("NunitoSans-Regular", size: 14))
                            .lineSpacing(6)
                    }
                    .padding(.top, 4)
                }
            }
            .padding(.vertical, 24)
        }
    }
}

struct CourseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserViewRow(
            user: User(
                id: 1,
                name: "Igor Kondratenko Vitalievich",
                email: "igorook969@gmail.com",
                phone: "380962221133",
                position: "iOS Developer",
                photo: ""
            )
        )
    }
}

