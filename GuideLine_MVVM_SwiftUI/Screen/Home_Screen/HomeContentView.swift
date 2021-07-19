import SwiftUI
import Combine

struct HomeContentView: View {

    let selectedUserPublisher = PassthroughSubject<User, Never>()
    @ObservedObject var userModel: HomeViewModel
    
    var body: some View {
        VStack{
            
            List(userModel.users){ user in
                NavigationLink(
                    destination: Home_Detail_ContentView(user: user) ,
                    label: {
                    UserRowView(user)
                        .listRowBackground(Color.init(.systemGray))
                        .listRowInsets(EdgeInsets.init(top: 0, leading: 0, bottom: 80, trailing: 0))
//                        .onTapGesture {
//                            self.selectedUserPublisher.send(user )
//                        }
                        .redacted(reason: userModel.isLoading ? .placeholder : [])
                        .onAppear {
                            fetchMoreData(user)
                        }//UserRowView
                }
                )
                
            } // List
            .listRowBackground(Color.init(.systemGray))

        }
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing) {

                Button{
                    print("알림 Clicked")
                } label: {
                    Image(systemName: "bell")
                       
                }
                
                Button{
                    print("뭐시기 Clicked")
                } label: {
                    Image(systemName: "paperplane")
                }
                    
                //Button("뭐시기", action: print("뭐시기 Clicked"))
                
            }
        }// toolbar
        .accentColor(.gray)
        
        // Navigation Title 지우고 싶을 경우
        //.self.navigationBarHidden(true)
           

        
        // Loading 중 Viw 처리
        if userModel.isLoading {
            ProgressView()
                .progressViewStyle(
                    CircularProgressViewStyle(tint: Color.init(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)))
                ).scaleEffect(1, anchor: .bottom)
        }
    }
}

// MARK - Helper Methods
extension HomeContentView {
    
    fileprivate func fetchMoreData(_ user: User){
        if self.userModel.users.last == user {
            print("마지막 도달!")
            // fetmore 요청 with combine
            userModel.fetchMoreActionSubject.send()
        }
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView(userModel: HomeViewModel())
    }
}
