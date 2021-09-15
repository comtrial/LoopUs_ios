import SwiftUI
import Combine

struct PersonalContentView: View {
    @AppStorage("isLogged") var isLogged: Bool = false
    
    var body: some View {
        
        Text("개인화 페이지")
        
        NavigationLink(
            destination: CreateProfile(),
            label: {
                Text("Create Profile")
            })
            
        Button("Logout", action: {
            UserDefaults.standard.set(false, forKey: "isLogged")
            
        })
        
        
        NavigationLink(
            destination: CreateGroup(),
            label: {
                Text("그룹 맹들기..")
            })
        
    }
}
