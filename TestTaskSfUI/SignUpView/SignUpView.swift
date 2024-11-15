//
//  SignView.swift
//  TestTaskSwiftUI
//
//  Created by user246073 on 11/3/24.
//

import SwiftUI


    
struct SignUpView: View {
    @StateObject private var viewModel = RegistrationViewModel()
    
    @State private var isNameValid = true
    @State private var isEmailValid = true
    @State private var isPhoneValid = true
    @State private var isPhotoValid = true
    @State private var selectedImage: UIImage? //ImagePicker
    
    @FocusState private var isFocused: Bool // Focus state for TextField

    var body: some View {
                VStack {
                    CustomRectangleView()
                    ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        VStack {
                            TextFieldView(
                                text: $viewModel.name,
                                isValid: $isNameValid,
                                placeholder: "Your your",
                                errorText: "Required field"
                            )
                            
                            TextFieldView(
                                text: $viewModel.email,
                                isValid: $isEmailValid,
                                placeholder: "Email",
                                errorText: "Invalid email format"
                            )
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                            
                            
                            TextFieldView(
                                text: $viewModel.phone,
                                isValid: $isPhoneValid,
                                placeholder: "Phone",
                                supportingText: "+38 (XXX) XXX - XX - XX",
                                errorText: "Required field"
                            )
                            .keyboardType(.phonePad)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    Button("Done") {
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    }
                                }
                            }
                        }
                        .focused($isFocused)
                        
                        
                        RadioButtonGroupView(
                            selectedPositionID: $viewModel.selectedPositionID,
                            positions: viewModel.positions
                        )
                        .offset(y: 10)
                        PhotoLoadView(selectedImage: $viewModel.photo, isValid: $isPhotoValid)
                        HStack {
                            Spacer()
                            PrimaryButton(
                                title: "Sign up",
                                action: {
                                    isNameValid = viewModel.validateName
                                    isEmailValid = viewModel.validateEmail
                                    isPhoneValid = viewModel.validatePhone
                                    isPhotoValid = viewModel.validPhoto()
                                    
                                    if viewModel.isFormValid {
                                        viewModel.registerUser()
                                    }
                                    
                                },
                                isActive: viewModel.isButtonValid ? true : false )
                            Spacer()
                        }
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 50)
                    }
                    .offset(y: 25)
                }
                .hideKeyboard()
                .onTapGesture {
                    isFocused = false
                }
                .onAppear {
                    viewModel.fetchPositions() }
                .navigationDestination(isPresented:  $viewModel.registrationSuccess) {
                    SignResultView(valid: true)
                }
                .navigationDestination(isPresented:  $viewModel.registrationFalse) {
                    SignResultView(valid: false)
                }
            }
    }
}
    

//#Preview {
//    SignUpView(isNameValid: true, isEmailValid: true, isPhoneValid: true, isPhotoValid: true)
//}
