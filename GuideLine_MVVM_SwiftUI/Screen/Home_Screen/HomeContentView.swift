import SwiftUI
import Combine

struct HomeContentView: View {

    let selectedFeedPublisher = PassthroughSubject<Feed, Never>()
    
//    let selectedFeedPublisher = PassthroughSubject<FeedItem, Never>()
//    @ObservedObject var feedModel: HomeViewModel
    @ObservedObject var feedModel: HomeViewModel
//    @ObservedObject var feedDetailModel: HomeDetail_ViewModel
    @State var isShowNoti: Bool = false
    
    var body: some View {
        VStack{
                    
        List(feedModel.feeds, id: \.id ){ feed in
            NavigationLink(
                destination: HomeDetail_ContentView(feedModel: feedModel,feed: feed) ,
                label: {
                    if(feed.feedImage.count != 0){
                        UserRowView(feed)
                            .listRowBackground(Color.init(.systemGray))
                            .listRowInsets(EdgeInsets.init(top: 0, leading: 0, bottom: 80, trailing: 0))
                            .redacted(reason: feedModel.isLoading ? .placeholder : [])
                            .onAppear {
                                fetchMoreData(feed)
                            }//UserRowView
                    } else {
                        FeedNoImgView(feed)
                            .onAppear{
                                fetchMoreData(feed)
                            }
                    }
                    
                }
            )//NavLink
        } // List
        .listRowBackground(Color.init(.systemGray))
                        

        
            
            
        }
        
        //MARK - ToolBar
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing) {

                //MARK - NOTIFICATION
                Button{
                    isShowNoti.toggle()
                    feedModel.readNotification()
                    print("알림 Clicked")
                } label: {
                    Image(systemName: "bell")
                }
                .sheet(isPresented: $isShowNoti, content: {
                    Text("notice")
                    List(feedModel.notifications){ noti in
                        VStack{
                            if (noti.notification_type == "group"){
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(noti.notification_type)
                                            .bold()
                                        Text("\(noti.username)님의 알림")
                                    }
                                    
                                    Spacer()
                                    
                                    HStack{
                                        Button("수락하기", action: {
                                            print("수락하기 클릭")
                                            feedModel.createCrew(group_idx: noti.target_idx, crew: noti.author_id)
                                        })
//                                        Button("거절하기", action: {
//
//                                        })
                                    }
                                }
                            }
                            
                            
                        }
                        .padding(.vertical)
                        
                    }
                })
                
                
                
                Button{
                    print("뭐시기 Clicked")
                } label: {
                    Image(systemName: "paperplane")
                }
            }
        }// toolbar
        .accentColor(.gray)
        
        // Navigation Title 지우고 싶을 경우
//        .self.navigationBarHidden(true)
           
//         Loading 중 Viw 처리
        if feedModel.isLoading {
            ProgressView()
                .progressViewStyle(
                    CircularProgressViewStyle(tint: Color.init(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)))
                ).scaleEffect(1, anchor: .bottom)
        }
                
                
                
    }
}

// MARK - Helper Methods
extension HomeContentView {
    fileprivate func fetchMoreData(_ feed: Feed){
        if self.feedModel.feeds.last == feed  && !self.feedModel.isDone {
            print("마지막 도달!")
//             fetmore 요청 with combine
            feedModel.fetchMoreActionSubject.send()
        }
    }
}

