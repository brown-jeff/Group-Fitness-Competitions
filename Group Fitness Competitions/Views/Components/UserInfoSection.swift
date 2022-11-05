import SwiftUI

struct UserInfoSection: View {

    let user: User
    
    var body: some View {
        Section("Profile") {
            HStack {
                ImmutableListItemView(value: user.name, valueType: .name)
                IDPill(id: user.hashId)
            }
            ImmutableListItemView(value: user.email, valueType: .email)
        }
    }
}
