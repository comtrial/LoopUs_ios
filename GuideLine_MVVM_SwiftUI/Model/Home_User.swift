//
//  RandomUser+ResponseData.swift
//  ios_tutorial_api
//
//  Created by 최승원 on 2021/07/06.
//

import Foundation

//User 한명에 대한 정보 값들
// 고유값이 들어갈 경우 처리 Identifiable
struct User: Codable, Identifiable {
    // 생성시 고유 id 생성해줌
    var id = UUID()
    var name : Name
    var photo: Photo

    //json 과 key를 달리 받고 싶은 경우
    private enum CodingKeys: String, CodingKey{
        case name = "name"
        case photo = "picture"
        // json에서의 picture를 photo로 사용하고 싶을 경우
    }
    // Dummy Data 만들때의 technic
    static func getDummy() -> Self{
        return User(name: Name.getDummy(), photo: Photo.getDummy())
    }
    
    var profileImgUrl : URL {
        get{
            URL(string: photo.medium )!
        }
    }
    
    var description: String {
        return name.description
    }
}

// Pagination을 구현하기 위한 idx 비교  Equatable 프로토콜
extension User : Equatable {
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
}



struct Name: Codable, CustomStringConvertible {
    var title : String
    var first : String
    var last : String
    
    var description: String {
        return "[\(title)] \(last), \(first)"
    }
    
    static func getDummy() -> Self {
        print(#fileID, #function, #line, "")
        return Name(title: "유튜버", first: "정대리", last: "개발하는")
    }
}

struct Photo: Codable {
    var large : String
    var medium : String
    var thumbnail : String
    static func getDummy() -> Self {
        print(#fileID, #function, #line, "")
        return Photo(large: "https://randomuser.me/api/portraits/women/93.jpg",
                     medium: "https://randomuser.me/api/portraits/women/93.jpg",
                     thumbnail: "https://randomuser.me/api/portraits/women/93.jpg")
    }
}

struct Info : Codable {
    var seed : String
    var resultsCount : Int
    var page : Int
    var version : String
    private enum CodingKeys: String, CodingKey {
        case seed = "seed"
        case resultsCount = "results"
        case page = "page"
        case version = "version"
    }
}


//{
//    "results": [...],
//    "info": {
//        "seed": "b60767cca26186d0",
//        "results": 5,
//        "page": 1,
//        "version": "1.3"
//    }
//}
// 구조의 json parsing

struct UserResponse: Codable, CustomStringConvertible {
    var results: [User]
    var info: Info
    private enum CodingKeys: String, CodingKey {
        case results, info
    }
    var description: String {
        return "results.count: \(results.count) / info : \(info.seed)"
    }
}
