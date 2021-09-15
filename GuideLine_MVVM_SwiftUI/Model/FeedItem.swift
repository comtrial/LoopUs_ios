// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let feed = try? newJSONDecoder().decode(Feed.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseFeed { response in
//     if let feed = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - Feed
struct Feed: Codable,Identifiable {
    var id: Int
    var username, title: String
    var createdAt, content: String
    var feedImage: [FeedImage]
    var feedComment: [FeedComment]
    var like: [Like]
    

    enum CodingKeys: String, CodingKey {
        case id, username, title
        case createdAt = "created_at"
        case content
        case feedImage = "feed_image"
        case feedComment = "feed_comment"
        case like
        
    }
}


// MARK - pagination을 구현하기 위한 idx 비교  Equatable 프로토콜
extension Feed : Equatable {
    
    static func == (lhs: Feed, rhs: Feed) -> Bool {
        return lhs.id == rhs.id
    }
    
}

// MARK: - FeedComment
struct FeedComment: Codable, Identifiable, Hashable {
    var id, feed: Int
    var username, content, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, feed, username, content
        case createdAt = "created_at"
        
    }
}



// MARK: - FeedImage
struct FeedImage: Codable, Identifiable {
    let id = UUID()
    var feed: Int
    var image: String
}


// MARK: - Like
struct Like: Codable {
    var username: String
    var feed: Int
}
