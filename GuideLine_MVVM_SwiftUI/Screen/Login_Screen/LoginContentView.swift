//
//  LoginContentView.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/07/26.
//

import Foundation
import SwiftUI

struct LoginContentView: View {
    
    @ObservedObject var viewModel: LoginSignupViewModel
    
    var body: some View {
        
        VStack{
            Text("Sign UP")
            Form{
                Section(header: Text("회원가입 정보")){
                    TextField("ID", text:
                                $viewModel.username)
                        .autocapitalization(.none)
                    TextField("password", text:
                                $viewModel.password)
                        .autocapitalization(.none)
                    
                }
                Button("회원가입", action: {
                    viewModel.signUp()
                })
            }
        }
        
    }
}
