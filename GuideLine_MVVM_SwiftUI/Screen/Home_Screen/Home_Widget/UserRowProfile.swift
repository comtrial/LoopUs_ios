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
           
    }
}

