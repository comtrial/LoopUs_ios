import SwiftUI

struct SearchContentView: View {
    
    var body: some View {
        HStack{
            SearchBar(text: .constant(""))
                .padding(.top, -30)
            
            Spacer()
        }
    }
}
