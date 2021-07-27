//
//  UserService.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/07/26.
//

import Foundation
import Alamofire

class SignUpRequestBody: Codable {
    let username: String
    let password: String
}

class SignUpService {
    func signUp(username: String, password: String) {
        
        let url: URL = URL(
            string: "http://52.79.75.189:8000/user_api/signup/")!
        let param: Parameters = [
                    "username": username,
                    "password": password]
        AF.request(url, method: .post, parameters: param, encoding: URLEncoding.httpBody)
            .responseJSON(){ response in
                print(response)
            }
        
    }
}
