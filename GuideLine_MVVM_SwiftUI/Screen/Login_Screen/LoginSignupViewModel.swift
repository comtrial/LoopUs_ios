//
//  LoginViewModel.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/07/26.
//

import Foundation
import Combine
import Alamofire
import SwiftUI

final class LoginSignupViewModel: ObservableObject{
    
    var subscription = Set<AnyCancellable>()
    
    @Published  var username: String = ""
    @Published  var password: String = ""
    @AppStorage("token") var token: String = ""
    @AppStorage("isLogged") var isLogged: Bool = false
    
    func signUp() {
        
        let url: URL = URL(
            string: "http://52.79.75.189:8000/user_api/signup/")!
        let param: Parameters = [
                    "username": username,
                    "password": password]
        AF.request(url, method: .post, parameters: param, encoding: URLEncoding.httpBody)
            .publishDecodable(type: TokenResponse.self)
            .compactMap{ $0.value }
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: { receiveValue in
                UserDefaults.standard.set(receiveValue.token, forKey: "token")
                UserDefaults.standard.set(true, forKey: "isLogged")
            }).store(in: &subscription)
        
    }
}
struct TokenResponse: Codable {
    var token: String
}
