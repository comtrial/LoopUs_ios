//
//  RandomUserRowView.swift
//  ios_tutorial_api
//
//  Created by 최승원 on 2021/07/06.
//

import Foundation
import SwiftUI
import URLImage

struct UserRowView : View {
    ///
    var imageUrlex = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwJi4mY32Pzr7Jr83ovLkM1OpuOO-Ml5Q9Og&usqp=CAU")
    //
    
    var randomUser : User
    
    init(_ randomUser: User) {
        self.randomUser = randomUser
    }
    
    var body : some View{
        VStack{
            HStack{
                //View에 전달해야 하는 변수를 등록하여 사용
                ProfileImgView(imageUrl: randomUser.profileImgUrl )
                
                Text("\(randomUser.description)")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 14))
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    //.minimumScaleFactor(0.5)
                    // lineLimit 두줄 넘어갈 경우 scale 줄어드는 정도 control
                
                
            }// Hstack에 대한 frame을 줘서 profilwimgView 사이즈 컨트롤
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: 36, alignment: . leading)
            .padding(.vertical)
            
            URLImage(imageUrlex!,
                     content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                     })
                .overlay(Circle().stroke(Color.init(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)),
                                         lineWidth: 2))
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: 300)
            
            Text("컴공 졸작 주제동영상 하이라이트 추출, 동영상 내 검색  ( 동영상 내 등장인물 검색, 사건, 자막 등)RabbitMQ 내 포폴에 적을 각오하고 피피티 만들어라생활 패턴을 좀 만들어 (알고리즘, 비피, 앱)deno..?인공지능의 필드를 좁혀 (gnn 같은 소비자 패턴 등의)백엔드 많이 챙겨")
                .fontWeight(.medium)
                .font(.system(size: 14))
                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
        }
        
    }
    
}

