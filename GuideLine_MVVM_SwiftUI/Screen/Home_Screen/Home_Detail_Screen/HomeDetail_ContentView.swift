//
//  Home_Detail_ContentView.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/07/17.
//

import Foundation
import SwiftUI
import Combine
import URLImage
import Alamofire

struct HomeDetail_ContentView: View {

    @ObservedObject var feedModel: HomeViewModel
    @ObservedObject var feedDetailModel = FeedDetailViewModel()
    
    @State var feed: Feed
    @State var comment: String = ""
    
    
    let screenSize: CGRect = UIScreen.main.bounds


    var body: some View {
        
        //MARK - for bottom comment
        ZStack{
            ScrollView{
            VStack(alignment: .leading){
                //Mark - Feed img 없을 경우
                if feed.feedImage.count == 0 {
                    VStack(alignment: .leading){
                    //MARK - Profile
                    HStack{
                        //View에 전달해야 하는 변수를 등록하여 사용

                        Text("\(feed.username)")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 14))
                            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                            //.minimumScaleFactor(0.5)
                            // lineLimit 두줄 넘어갈 경우 scale 줄어드는 정도 control
                    }// Hstack에 대한 frame을 줘서 profilwimgView 사이즈 컨트롤
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: 36, alignment: . leading)
                    .padding(.vertical)
                    
                    
                    //MARK - Feed Content
                    VStack{
                        Text(feed.title)
                            .fontWeight(.semibold)
                            .font(.system(size: 16))
                            .lineLimit(3)
                        Text(feed.content)
                            .fontWeight(.medium)
                            .font(.system(size: 14))
                            .lineLimit(3)
                    }
                }
                //VstackView
                .navigationBarTitle(feed.title, displayMode: .inline)
                .padding(8)
                //.background(Color.init(.systemGray6))
                .cornerRadius(16)
                .onTapGesture {
                    hideKeyboard()
                }
                .onAppear{
                    self.feedDetailModel.fetchHomeDetailFeeds(feed: feed)
                }
                    
                } else {
                        
                VStack(alignment: .leading){
                    
                    //MARK - Profile
                    var imageUrlex = URL(string: feed.feedImage[0].image)

                    HStack{
                        //View에 전달해야 하는 변수를 등록하여 사용
                        ProfileImgView(imageUrl: imageUrlex! )
                        
                        Text("\(feed.username)")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 14))
                            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                            //.minimumScaleFactor(0.5)
                            // lineLimit 두줄 넘어갈 경우 scale 줄어드는 정도 control
                    }// Hstack에 대한 frame을 줘서 profilwimgView 사이즈 컨트롤
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: 36, alignment: . leading)
                    .padding(.vertical)
                    .padding(.horizontal)
                    
                    
                    //MARK - Feed Content
                    VStack(alignment: .leading){
                        Text(feed.title)
                            .fontWeight(.semibold)
                            .font(.system(size: 16))
                            .lineLimit(3)
                        Text(feed.content)
                            .fontWeight(.medium)
                            .font(.system(size: 14))
                            .lineLimit(3)
                    }
                    .padding(16)
                    
                    
                    
                    //MARK - Feed Img
                    ScrollView(.horizontal, showsIndicators: true){
                        HStack(spacing: 20){
                            ForEach(feed.feedImage){ image in
                                ImageCard(imgUrl: image.image)
                            }
                        }
                        
                    }
                    .padding(.horizontal)
                    
                }//VstackView
                .navigationBarTitle("", displayMode: .inline)
                //   .padding(24)
                //.background(Color.init(.systemGray6))
                .cornerRadius(16)
                .onTapGesture {
                    hideKeyboard()
                }
                .onAppear{
                    self.feedDetailModel.fetchHomeDetailFeeds(feed: feed)
                }
                }
                
                //MARK - Feed Comment
                CommentView(feedDetailModel: feedDetailModel, feed: feed)


                    
                }
            }
            
            
            //MARK - Feed Comment
            VStack{
                Spacer()
                
                HStack{
                    TextField("댓글 남기기", text: $comment)
                        .padding(12)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(6)
                    Button{
                        feedDetailModel.uploadComment(feed: feed, comment: comment)
                        comment = ""
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 24))
                    }
                }
                .padding(.horizontal)
                .padding(.vertical)
            }
            
        }
        
        
        
    }
}

struct ImageCard: View {
    
    var imgUrl: String = ""
    let screenSize: CGRect = UIScreen.main.bounds
    
    var body: some View{
        
        VStack{
            URLImage(URL(string: imgUrl)!,
                         content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                         })
                .frame(minWidth: screenSize.width - 60, idealWidth: screenSize.width - 60, maxWidth: screenSize.width - 60, minHeight: 0, idealHeight: screenSize.width - 60, maxHeight: .infinity, alignment: .leading)
                .cornerRadius(12)
        }
    }
    
}

