//
//  ProfileViewModel.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/08/18.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject{
    
    // Profile...
    @Published var profile: [Profile]?
}
