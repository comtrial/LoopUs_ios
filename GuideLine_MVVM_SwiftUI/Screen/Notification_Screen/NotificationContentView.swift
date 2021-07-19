import SwiftUI
import Combine

struct NotificationContentView: View {
   
    let selectedUserPublisher = PassthroughSubject<User, Never>()
    @ObservedObject var userModel: HomeViewModel
    
    var body: some View {
        List(userModel.users){ user in
            UserRowView(user)
                .onTapGesture {
                    self.selectedUserPublisher.send(user )
                }
                .onAppear {
                    fetchMoreData(user)
                }
        }
        
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
extension NotificationViewModelContentView {
    
    fileprivate func fetchMoreData(_ user: User){
        if self.userModel.users.last == user {
            print("마지막 도달!")
            // fetmore 요청 with combine
            userModel.fetchMoreActionSubject.send()
        }
    }
}

//struct HomeContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeContentView
//    }
//}
