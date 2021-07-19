//
//  HomeSourseOfTruth.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/07/14.
//

import SwiftUI
import Alamofire
import Combine


class NotificationViewModel: ObservableObject {
//    @Published var users = [User]()
    var subscription = Set<AnyCancellable>()
    
    // @Published로 annotation이 되어있기 때문에 Event로 data 변경되는 사항을 알수 있게 된다
    @Published var users = [User]()
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
        fetchRandomUsers()
        fetchMoreActionSubject.sink{[weak self] _ in
            guard let self = self else { return }
            print("RandomUserViewModel - init - refreshActionSubject")
                    
            //Loading이 false 일 경우에만  fetch를 진행해줌
            if !self.isLoading {
                self.fetchMore()
            }
                    
        }.store(in: &subscription)
    }
    
    // Paging 처리
    func fetchMore() {
        guard let currentPage = pageInfo?.page else {
            print("페이지 정보가 없음")
            return
        }
        
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
                self.users += receiveValue.results
                self.pageInfo = receiveValue.info
                
            }).store(in: &subscription)
    }
    
    
    func fetchRandomUsers() {
        // session을 만들어서 호출하는 것이 아닌 기존의 defalt session을 가져옴
        AF.request(HomeUserRouter.getUsers())
            .publishDecodable(type: UserResponse.self)  // json 형식을 바로 decoding 해줌(parsing)
            .compactMap{ $0.value } // Publisher을 .value로 compactMap을 통하여 Optional 값을 Unlapping
            //.map{ $0.results }
            .sink(receiveCompletion: { completion in // *구독을 통해 Event를 받게 된다.
//                print("데이터스트림 완료")
            }, receiveValue: { receiveValue in
//                print("받은 값: \(receiveValue.results.count)")
                self.users = receiveValue.results  // api 통신으로 받은 값 & unrapping 등등 전처리 해준값 model 에 등록 //Published 로 annotion이 되어있기 때문에
                self.pageInfo = receiveValue.info
                
            }).store(in: &subscription)
    }
}
