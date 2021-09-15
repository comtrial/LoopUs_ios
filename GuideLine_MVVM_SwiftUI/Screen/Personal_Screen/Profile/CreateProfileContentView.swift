//
//  CreateProfileContentView.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/08/18.
//

import Foundation
import SwiftUI

struct CreateProfile: View {
    
    @StateObject var profileData = ProfileViewModel()
    
    // Profile Properties
    @State var profileTitle = ""
    @State var profileContent : [ProfileContent] =  []
    
    var body: some View {
        
        // Since we need Nav Buttom
        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false, content:{
                
                VStack(spacing: 15){
                    
                    VStack(alignment: .leading){
                        
                        TextField("Profile Title", text: $profileTitle)
                        
                        Divider()
                    }
                    .padding(.bottom, 20)
                
                    //Write Form
                    ForEach(profileContent){ content in
                        
                        // Custom Text Editor from Uikit
                
                    }
                    
                    
                    //Toggle Menu
                    Menu {
                        // Iterating Cases...
                        ForEach(PostType.allCases, id: \.rawValue){ type in
                            Button(type.rawValue){
                                
                                // Appending New PostContent
                                withAnimation{
                                    profileContent.append(ProfileContent(
                                        value: "", type: type)
                                    )
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
    
                .padding()
            })
            
        }
        .navigationTitle(profileTitle == "" ? "Profile Title": profileTitle)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}
