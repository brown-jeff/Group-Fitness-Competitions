import SwiftUI

struct PermissionsView: View {

    @StateObject private var viewModel = PermissionsViewModel()

    var body: some View {
        List {
            Section {
                ForEach(viewModel.permissionStatuses, id: \.0) { permission, permissionStatus in
                    PermissionView(permission: permission, status: permissionStatus) {
                        viewModel.request(permission)
                    }
                }
            } header: {
                Text("To get the best experience in Group Fitness Competitions, we need access to a few things.")
            } footer: {
                Text("You can change your responses in the settings app.")
            }
            .textCase(.none)
        }
        .navigationTitle("Permissions needed")
        .embeddedInNavigationView()
        .registerScreenView(name: "Permissions")
    }
}
