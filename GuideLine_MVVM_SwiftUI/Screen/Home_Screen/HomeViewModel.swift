//
//  HomeSourseOfTruth.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/07/14.
//

import SwiftUI
import Alamofire
import Combine


class HomeViewModel: ObservableObject {
//    @Published var users = [User]()
    var subscription = Set<AnyCancellable>()
    
    // @Published로 annotation이 되어있기 때문에 Event로 data 변경되는 사항을 알수 있게 된다
    @Published var feeds = [Feed]()
    @Published var notifications = [Notification]()
//    @Published var feed: Feed

    // To Paging 처리
    @Published var currentPage: Int = 2 {
            didSet {
                print("currentPage: \(currentPage)")
            }
        }
    // Loading 중에 api가 중복적으로 call 되는 것을 방지 하기 위함
    @Published var isLoading : Bool = true
    
    // 마지막 페이지일 경우
    @Published var isDone : Bool = false
    
    // paging 처리
    var fetchMoreActionSubject = PassthroughSubject<(), Never>()
    
    // Alamofire를 통해 api 를 호출 하게 되는데
    // RandomUserViewModel 이 생성 될 때 API를 호출 하게 설계 하므로 init()
    init() {
        
        fetchHomeFeeds()
        fetchMoreActionSubject.sink{[weak self] _ in
            guard let self = self else { return }
            print("RandomUserViewModel - init - refreshActionSubject")
            
            //Loading이 false 일 경우에만  fetch를 진행해줌
            if !self.isLoading {
                self.fetMoreFeed()
            }
        }.store(in: &subscription)
    }
    
    // Paging 처리
    func fetchMore() {
//        guard let currentPage = pageInfo?.page else {
//            print("페이지 정보가 없음")
//            return
//        }
        self.isLoading = true
        
        let pageToLoad = currentPage + 1
        AF.request(HomeUserRouter.getUsers(page: pageToLoad))
            .publishDecodable(type: UserResponse.self)
            .compactMap{ $0.value }
            //.map{ $0.results }
            .sink(receiveCompletion: { completion in
                print("데이터스트림 완료")
                self.isLoading = false
            }, receiveValue: { receiveValue in
                //print("받은 값: \(receiveValue.results.count)")
                // 기존 data에 덮어쓰는게 아니라 추가하는 방식으로 처리를 위해서
//                self.users += receiveValue.results
//                self.pageInfo = receiveValue.info
        }).store(in: &subscription)
        
        self.isLoading = false
    }
    

    func fetchHomeFeeds() {
        self.isLoading = true
        
        let parameters: Parameters = ["page": currentPage]
        let url: URL = URL(string: "http://3.38.89.253:8000/feed_api/home_load")!
        let token: String = UserDefaults.standard.string(forKey: "token") ?? ""
        let headers: HTTPHeaders = ["Authorization": "Token \(token)"]

        
        AF.request(url, method: .get,encoding: JSONEncoding.default, headers: headers)
            .publishDecodable(type: [Feed].self)
            .compactMap{ $0.value }
            .sink(receiveCompletion: { completion in
                self.isLoading = false
            }, receiveValue: { receiveValue in

                self.feeds = receiveValue
                    
            }).store(in: &subscription)
    }
    
    func fetMoreFeed() {
        self.isLoading = true
        let url: URL = URL(string: "http://3.38.89.253:8000/feed_api/home_load?page=\(currentPage)")!
        self.currentPage += 1
        let token: String = UserDefaults.standard.string(forKey: "token")!
        let headers: HTTPHeaders = ["Authorization": "Token \(token)"]
        
         AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
             .publishDecodable(type: [Feed].self)
             .compactMap{ $0.value }
             .sink(receiveCompletion: { completion in
                 self.isLoading = false
             }, receiveValue: { receiveValue in
                 
                self.feeds += receiveValue
                if self.feeds.reversed()[0] == receiveValue.reversed()[0] {
                    self.isDone = true
                    print("마지막 페이지")
                }
                print("More 해서 받은 값: \(self.currentPage)")
                print("More 해서 받은 값: \(self.feeds.count)")
             }).store(in: &subscription)
        
        // 데이터 없을 경우 무한 로딩 방지
        self.isLoading = false
    }
    
    //MARK - Detail Load
    func fetchHomeDetailFeeds(feed: Feed)  {
        self.isLoading = true
        let url: URL = URL(string: "http://3.38.89.253:8000/feed_api/detail_load/\(feed.id)")!
        let token: String = UserDefaults.standard.string(forKey: "token")!
        let headers: HTTPHeaders = ["Authorization": "Token \(token)"]
        
            AF.request(url, method: .get,encoding: JSONEncoding.default, headers: headers)
                .publishDecodable(type: Feed.self)
                .compactMap{ $0.value }
                .sink(receiveCompletion: { completion in
                    self.isLoading = false
                }, receiveValue: { receiveValue in
                    print("받은 값: \(receiveValue)")
                    
//                    self.feed = receiveValue
                }).store(in: &subscription)
    }
    
    
    
    
    
    
    
    //MARK - Read Notification
    func readNotification() {

        let url: URL = URL(
            string: "http://3.38.89.253:8000/notification_api/read_notification")!
        let token: String = UserDefaults.standard.string(forKey: "token")!
        let headers: HTTPHeaders = ["Authorization": "Token \(token)"]
        
        AF.request(url,method: .get,  encoding: URLEncoding.httpBody, headers: headers)
            .publishDecodable(type: [Notification].self)
            .compactMap{ $0.value }
            .sink(receiveCompletion: { completion in
                print("noti read complete")
            }, receiveValue: { receiveValue in
                print(receiveValue)
                self.notifications = receiveValue
            }).store(in: &subscription)

    }
    
    //MARK - Create Crew
    func createCrew(group_idx: Int, crew: Int) {

        let url: URL = URL(
            string: "http://3.38.89.253:8000/group_api/create_crew/\(group_idx)")!
        let parameters: Parameters = ["crew": crew]
        let token: String = UserDefaults.standard.string(forKey: "token")!
        let headers: HTTPHeaders = ["Authorization": "Token \(token)"]
        AF.request(url,method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers)
           .responseJSON(){ response in
                print(response)
           }
    

    }
}
