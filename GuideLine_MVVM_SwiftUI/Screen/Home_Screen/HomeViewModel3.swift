//
//  HomeViewModel.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/08/18.
//

import SwiftUI
import Alamofire
import Combine


class HomeViewModel3: ObservableObject {
//    @Published var users = [User]()
    var subscription = Set<AnyCancellable>()
    
    // @Published로 annotation이 되어있기 때문에 Event로 data 변경되는 사항을 알수 있게 된다
    @Published var feeds = [FeedItem]()
    // To Paging 처리
    @Published var pageInfo : Info? {
            didSet {
                //print("pageInfo: \(pageInfo)")
            }
        }
    // Loading 중에 api가 중복적으로 call 되는 것을 방지 하기 위함
    @Published var isLoading : Bool = false
    
    // paging 처리
    var fetchMoreActionSubject = PassthroughSubject<(), Never>()
    
    // Alamofire를 통해 api 를 호출 하게 되는데
    // RandomUserViewModel 이 생성 될 때 API를 호출 하게 설계 하므로 init()
    init() {
        fetchHomeFeed()
        fetchMoreActionSubject.sink{[weak self] _ in
            guard let self = self else { return }
            print("RandomUserViewModel - init - refreshActionSubject")
                    
            //Loading이 false 일 경우에만  fetch를 진행해줌
            if !self.isLoading {
//                self.fetchMore()
            }
                    
        }.store(in: &subscription)
    }
    
    // Paging 처리
//    func fetchMore() {
//        guard let currentPage = pageInfo?.page else {
//            print("페이지 정보가 없음")
//            return
//        }
//        self.isLoading = true
//
//        let pageToLoad = currentPage + 1
//        AF.request(HomeUserRouter.getUsers(page: pageToLoad))
//            .publishDecodable(type: UserResponse.self)
//            .compactMap{ $0.value }
//            //.map{ $0.results }
//            .sink(receiveCompletion: { completion in
//                print("데이터스트림 완료")
//                self.isLoading = false
//            }, receiveValue: { receiveValue in
//                //print("받은 값: \(receiveValue.results.count)")
//                // 기존 data에 덮어쓰는게 아니라 추가하는 방식으로 처리를 위해서
//                self.users += receiveValue.results
//                self.pageInfo = receiveValue.info
//        }).store(in: &subscription)
//    }
    
    
    func fetchHomeFeed() {
        
        self.isLoading = true
        
        let url: URL = URL(
            string: "http://52.79.75.189:8000/feed_api/home_load")!
        
//        let param: Parameters = [
//                    "username": username,
//                    "password": password
//        ]
//            , parameters: param
        AF.request(url, method: .get, encoding: URLEncoding.httpBody)
            .publishDecodable(type: FeedResponse.self)
            .compactMap{ $0.value }
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: { receiveValue in
                print(receiveValue)
                
            }).store(in: &subscription)
        
    }
}
