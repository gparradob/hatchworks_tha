//
//  ToastType.swift
//  hatchworks_tha
//
//  Created by Gustavo Parrado on 10/25/25.
//

import Foundation
import SwiftUI

enum ToastType {
    case success(String)
    case error(String)
    case info(String)
    
    var backgroundColor: Color {
        switch self {
        case .success:
            return .green
        case .error:
            return .red
        case .info:
            return .blue
        }
    }
    
    var message: String {
        switch self {
        case .success(let message), .error(let message), .info(let message):
            return message
        }
    }
    
    var icon: Image? {
        switch self {
        case .success:
            return Image(systemName: "checkmark")
        case .error:
            return Image(systemName: "exclamationmark.trianglepath")
        case .info:
            return Image(systemName: "info.circle")
        }
    }
}
