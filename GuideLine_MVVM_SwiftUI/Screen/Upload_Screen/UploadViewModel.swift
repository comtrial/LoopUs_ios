//
//  UploadViewModel.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/07/18.
//
import SwiftUI
import Combine

class UploadViewModel: ObservableObject {
    
    @Published  var shouldSendCampus: Bool = false
    @Published  var shouldWriteQusetion: Bool = false
    @Published  var title = ""
    @Published  var content = ""

}
