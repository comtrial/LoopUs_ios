//
//  LoginViewController.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/07/26.
//

import Foundation
import SwiftUI
import Combine
import Alamofire

class HomeViewController2:
    UIHostingController<HomeContentView> {
    
    override init(rootView: HomeContentView){
        super.init(rootView: rootView)
        
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
