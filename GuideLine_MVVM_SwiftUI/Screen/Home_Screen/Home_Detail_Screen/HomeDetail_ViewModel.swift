
import Foundation
import SwiftUI
import Combine
import Alamofire

class FeedDetailViewModel: ObservableObject {
    
    @Published var feedComment = [FeedComment]()
    @Published var isLoading : Bool = false
    var subscription = Set<AnyCancellable>()
    
     

    //MARK - Detail Load
    func fetchHomeDetailFeeds(feed: Feed)  {
        self.isLoading = true
    
        let url: URL = URL(string: "http://3.38.89.253:8000/feed_api/detail_load/\(feed.id)/")!
        let token: String = UserDefaults.standard.string(forKey: "token")!
        let headers: HTTPHeaders = ["Authorization": "Token \(token)"]


        AF.request(url, method: .get,encoding: JSONEncoding.default, headers: headers)
            .publishDecodable(type: Feed.self)
            .compactMap{ $0.value }
            .sink(receiveCompletion: { completion in
                self.isLoading = false
            }, receiveValue: { receiveValue in
                
                self.feedComment = receiveValue.feedComment
            
               print(self.feedComment)
                
            }).store(in: &subscription)
        
    }
    
    
    //MARK - upload comment
    func uploadComment(feed: Feed, comment: String) {
//        var newcomment: FeedComment
        let url: URL = URL(
            string: "http://3.38.89.253:8000/feed_api/comment_upload/\(feed.id)/")!
        let token: String = UserDefaults.standard.string(forKey: "token")!
        let headers: HTTPHeaders = ["Authorization": "Token \(token)"]
        let param: Parameters = ["content": comment]
        AF.request(url,method: .post, parameters: param, encoding: URLEncoding.httpBody, headers: headers)
            .publishDecodable(type: FeedComment.self)
            .compactMap{ $0.value }
            .sink(receiveCompletion: { completion in
                print("comment upload complete")
            }, receiveValue: { receiveValue in
                print(receiveValue)
                self.feedComment.append(receiveValue) 
            }).store(in: &subscription)

    }
}

