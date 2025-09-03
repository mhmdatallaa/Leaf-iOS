//
//  SettingsView.swift
//  Leaf
//
//  Created by Mohamed Atallah on 04/09/2025.
//

import SwiftUI

import SwiftUI

@MainActor
final class SettingViewModel: ObservableObject {
//    var userName: String = ""
    

    func logOut() async throws {
        try await AuthService.shared.signOut()
    }
    
//    func getUserName() {
//        Task {
//            do {
//                self.userName = try await AuthService.shared.getAuthenticatedUser().name ?? "none"
//            } catch {
//                
//            }
//        }
//    }
 
//    func resetPassword() async throws {
//        let authUser = try await AuthService.shared.getAuthenticatedUser()
//        guard let email = authUser.email else {
//            throw URLError(.fileDoesNotExist)
//        }
//        try await AuthService.shared.resetPassword(email: email)
//    }
//    
//    func updateEmail() async throws {
//        let email = "mi3713889@gmail.com"
//        try await AuthService.shared.updateEmail(email: email)
//    }
//    
//    func updatePassword() async throws {
//        let pass = "hello123"
//        try await AuthService.shared.updatePassword(password: pass)
//    }
}

struct SettingView: View {
    
    @StateObject private var vm = SettingViewModel()
    @Binding var showLoginView: Bool
    
    var name: String
    
    var body: some View {
        List {
            Text("Hello, \(name)")
            Button("Log out") {
                Task {
                    do {
                        try await vm.logOut()
                        showLoginView = true
                    } catch {
                        print(error)
                    }
                }
            }
            
//           emailSection

        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingView(showLoginView: .constant(false), name: "Mo")
    }
}
//
//extension SettingView {
//    private var emailSection: some View {
//        Section {
//            Button("Reset Password") {
//                Task {
//                    do {
//                        try await vm.resetPassword()
//                        print("Password reset")
//                    } catch {
//                        print(error)
//                    }
//                }
//
//            }
//            
//            Button("Update Email") {
//                Task {
//                    do {
//                        try await vm.updateEmail()
//                        print("Email Updated")
//                    } catch {
//                        print(error)
//                    }
//                }
//
//            }
//            
//            Button("Update Password") {
//                Task {
//                    do {
//                        try await vm.updatePassword()
//                        print("Password updated")
//                    } catch {
//                        print(error)
//                    }
//                }
//
//            }
//        } header: {
//            Text("Email functions")
//        }
//    }
//}
