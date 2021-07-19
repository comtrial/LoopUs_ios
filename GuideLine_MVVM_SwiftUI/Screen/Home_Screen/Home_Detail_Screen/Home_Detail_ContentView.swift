//
//  Home_Detail_ContentView.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/07/17.
//

import Foundation
import SwiftUI
import Combine

struct Home_Detail_ContentView: View {

    var user: User
    
    var body: some View {
        Text("\(user.description)")
    }
}
