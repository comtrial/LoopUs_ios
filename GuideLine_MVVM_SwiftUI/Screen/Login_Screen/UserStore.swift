//
//  LoginViewModel.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/07/26.
//

import Foundation
import SwiftUI
import Combine

class UserStore: ObservableObject {
    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged"){
        didSet{
            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
        }
    }
    
    @Published var showLogin = false
}
