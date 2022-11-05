import Factory
import SwiftUI

struct Home: View {

    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        TabView {
            Dashboard()
                .embeddedInNavigationView()
                .tabItem { Label("Home", systemImage: .houseFill) }
        
            Explore()
                .embeddedInNavigationView()
                .tabItem { Label("Explore", systemImage: .globeAmericas) }
        }
        .onOpenURL(perform: viewModel.handle)
        .sheet(item: $viewModel.deepLinkedCompetition) { CompetitionView(competition: $0).embeddedInNavigationView() }
        .sheet(item: $viewModel.deepLinkedUser) { UserView(user: $0).embeddedInNavigationView() }
    }
}
