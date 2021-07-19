//
//  HomeService.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/07/14.
//

import Foundation
import Alamofire

class HomeNetworkService {
    
    // with no Route Pattern
    func getUsers(completion: @escaping ([User]) -> Void) {
        let url = URL(string: "https://randomuser.me/api/?results=50")!
        URLSession.shared.dataTask(with: url) {
            if let error = $2 {
                print(error)
            } else if let data = $0 {
                do {
                    let users = try JSONDecoder().decode([User].self, from: data)
                    DispatchQueue.main.async {
                        completion(users)
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
        
        
    }
}
