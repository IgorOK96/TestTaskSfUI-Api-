//
//  NoConnection.swift
//  TestTaskSfUI
//
//  Created by user246073 on 11/7/24.
//

import SwiftUI

struct NoConnectionView: View {
    @ObservedObject var networkMonitor: NetworkMonitor // Пробрасываем объект наблюдателя

    var body: some View {
        VStack {
            Image("NoConnect")
                .resizable()
                .frame(width: 200, height: 200)
                .background(Color.white)
            Text("There is no internet connection")
                .font(.custom("NunitoSans-Regular", size: 20))
            PrimaryButton(title: "Try again", action: {
                networkMonitor.checkConnection()
            }, isActive: true)
        }
    }
}

//#Preview {
//    NoConnectionView(networkMonitor: NetworkMonitor)
//}
