//
//  LoginViewModel.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/07/26.
//

import Foundation
import Combine
import SwiftUI

final class LoginSignupViewModel: ObservableObject{
    
    @Published  var username: String = ""
    @Published  var password: String = ""
    
}
