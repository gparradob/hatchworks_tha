//
//  ToastView.swift
//  hatchworks_tha
//
//  Created by Gustavo Parrado on 10/25/25.
//

import SwiftUI

struct ToastView: View {
    let toast: ToastType
    
    var body: some View {
        HStack {
            toast.icon
                .foregroundColor(.white)
            Text(toast.message)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .foregroundColor(.white)
        }
        .padding()
        .background(toast.backgroundColor.opacity(0.9))
        .cornerRadius(8)
        .shadow(radius: 5)
    }
}

extension EnvironmentValues {
    @Entry var showToast: (ToastType) -> Void = { _ in }
}

struct ToastModifier : ViewModifier {
    @State var toast: ToastType?
    @State private var dismissTask: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .environment(\.showToast, { type in
                withAnimation(.easeInOut) {
                    self.toast = type
                }
                
                dismissTask?.cancel()
                
                let task = DispatchWorkItem {
                    withAnimation(.easeInOut) {
                        self.toast = nil
                    }
                }
                
                self.dismissTask = task
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: task)
            })
            .overlay(alignment: .top) {
                if let toast {
                    ToastView(toast: toast)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .padding(.top, 20)
                }
            }
    }
}

extension View {
    func toastable() -> some View {
        modifier(ToastModifier())
    }
}

#Preview {
    ToastView(toast: .error("Data could not be loaded"))
}
