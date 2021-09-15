//
//  PersonalModel.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/08/18.
//

import Foundation
import SwiftUI

struct Profile: Identifiable, Codable {
    var id: String
    var title: String
//    var author: String
    var profileContent: [ProfileContent]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case profileContent
        
    }
}

// Profile Content Model
struct ProfileContent: Identifiable, Codable {

    var id = UUID().uuidString
    var value: String
    var type: PostType
    
    enum CodingKeys: String, CodingKey {
        case id
        // firebase에서 필요한것 같아서 custom 필요할듯
        case type = "key"
        case value
    }
}

//Content Type 지정
//Eg Header, Paragraph, img...
enum PostType: String, CaseIterable, Codable {
    
    case Header = "Header"
    case SubHeader =  "SubHeader"
    case Paragraph = "Paragrapgh"
    case Image = "Image"
}
