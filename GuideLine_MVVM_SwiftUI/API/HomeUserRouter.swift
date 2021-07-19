//
//  HomeUserRouter.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/07/15.
//

import Foundation
import Alamofire

// https://randomuser.me/api/?page=3&results=10&seed=abc
let BASE_URL = "https://randomuser.me/api/"

enum HomeUserRouter: URLRequestConvertible {
    
    //HomeRouter로 들어 온 Api의 여러 메서드들의 확장성을 위함
    //default에 추가하며 Api 처리 하면 된다. ex) getuser, getmessage 등
    case getUsers(page: Int = 1, results: Int = 5)
    
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    // base + endpoint 별로 case를 나눠 주어 처리
    var endpoint : String {
        switch self {
        case .getUsers:
            return ""
        default:
            return ""
        }
    }
    
    // 각 enpoint 별 method 정의
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        default:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case let .getUsers(page, results):
            var params = Parameters()
            params["page"] = page
            params["results"] = results
            params["seed"] = "susan"
            
            return params
        default:
            return Parameters()
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        // 위에서 정의한 endpoit 넣어줘
        let url = baseURL.appendingPathComponent(endpoint)
        
        var request = URLRequest(url: url)
        request.method = method
        
        // 위에서 정의 한 parameter 들을 enpoint에 맞게 req에 넣어준다.
        switch self {
        case .getUsers:
            request = try URLEncoding.default.encode(request, with: parameters)
        default:
            return request
        }
        
        return request
    }
}

