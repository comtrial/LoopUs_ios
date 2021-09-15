//
//  Notification.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/08/28.
//

import Foundation

struct Notification: Codable, Identifiable {
    var id: Int
    var author_id, target_idx, to_id: Int
    var notification_type, username: String
}
