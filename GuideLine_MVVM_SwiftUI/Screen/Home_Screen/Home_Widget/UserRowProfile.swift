//
//  profileimgView.swift
//  ios_tutorial_api
//
//  Created by 최승원 on 2021/07/06.
//

import Foundation
import SwiftUI
import URLImage

struct ProfileImgView : View {
    
    var imageUrl: URL
    
    var body: some View {
        
        URLImage(imageUrl,
                 content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                 })
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .overlay(Circle().stroke(Color.init(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)),
                                     lineWidth: 2))
           
    }
}

