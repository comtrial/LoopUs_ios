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
    //isLogged -> false 로 바꿔줘야대
    @AppStorage("isLogged") var isLogged: Bool = true
    
    func signUp() {
        
        let url: URL = URL(
            string: "http://3.38.89.253:8000/user_api/signup/")!
        let param: Parameters = [
                    "username": username,
                    "password": password]
        AF.request(url, method: .post, parameters: param, encoding: URLEncoding.httpBody)
            .publishDecodable(type: TokenResponse.self)
            .compactMap{ $0.value }
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: { receiveValue in
                UserDefaults.standard.set(receiveValue.Token, forKey: "token")
                UserDefaults.standard.set(true, forKey: "isLogged")
                
                print(UserDefaults.standard.string(forKey: "token"))
            }).store(in: &subscription)
        
    }
    
    func login() {
        
        let url: URL = URL(
            string: "http://3.38.89.253:8000/user_api/login/")!
        let param: Parameters = [
                    "username": username,
                    "password": password
        ]
        AF.request(url, method: .post, parameters: param, encoding: URLEncoding.httpBody)
            .publishDecodable(type: TokenResponse.self)
            .compactMap{ $0.value }
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: { receiveValue in
                UserDefaults.standard.set(receiveValue.Token, forKey: "token")
                UserDefaults.standard.set(true, forKey: "isLogged")
            }).store(in: &subscription)
        
    }
}

struct TokenResponse: Codable {
    var Token: String
}
