import SwiftUI
import Combine

struct CommentView: View {
    
    @ObservedObject var feedDetailModel: FeedDetailViewModel
    let selectedFeedPublisher = PassthroughSubject<FeedComment, Never>()
    @State var feed: Feed

    @State var comment: String = ""

    var body: some View{

        if feedDetailModel.feedComment.count != 0 {
   
            ForEach(feedDetailModel.feedComment, id: \.self){ comment in
                VStack(alignment: .leading){
                    Text(comment.username)
                        .fontWeight(.semibold)
                        .font(.system(size: 16))
                        .lineLimit(3)
                    Text(comment.content)
                        .fontWeight(.medium)
                        .font(.system(size: 14))
                        .lineLimit(3)
                }
                .padding(.horizontal)
                .padding(.vertical, 4)
            }

        } else{
            VStack{
                Text("댓글이 아직 없어영..")
                    .font(.system(size: 14))
                    .fontWeight(.light)
                    
                Spacer()

            }
            .padding(.top, 24)
            .padding(.horizontal)
        }
        }
}
