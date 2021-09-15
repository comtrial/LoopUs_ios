import SwiftUI
import Combine

struct NotificationContentView: View {
    var body: some View {
        VStack{
            Text("알림 창")
            Link(
                "이런식으로 link 연결",
                destination: URL(
                    string: "http://www.inu.ac.kr/user/indexSub.do?codyMenuSeq=104720&siteId=ime&dum=dum&boardId=47884&page=1&command=view&boardSeq=634841")!
                  )
        }
        
    }
}
