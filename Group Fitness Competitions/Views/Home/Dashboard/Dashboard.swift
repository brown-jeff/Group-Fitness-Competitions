import SwiftUI
import SwiftUIX

struct Dashboard: View {
    
    @StateObject private var viewModel = DashboardViewModel()
            
    @State private var presentAbout = false
    @State private var presentDeveloper = false
    @State private var presentPermissions = false
    @State private var presentNewCompetition = false
    @State private var presentSearchFriendsSheet = false
    @AppStorage("competitionsFiltered") var competitionsFiltered = false
    
    var body: some View {
        List {
            Group {
                activitySummary
                competitions
                friends
            }
            .textCase(nil)
        }
        .navigationBarTitle(viewModel.title)
        .toolbar {
            HStack {
                NavigationLink {
                    Profile()
                } label: {
                    Image(systemName: .personCropCircle)
                }
            }
        }
        .sheet(isPresented: $presentSearchFriendsSheet) { InviteFriends(action: .addFriend) }
        .sheet(isPresented: $presentNewCompetition) { NewCompetition() }
        .sheet(isPresented: $viewModel.requiresPermissions) { PermissionsView() }
        .registerScreenView(name: "Home")
    }
    
    private var activitySummary: some View {
        Section {
            ActivitySummaryInfoView(activitySummary: viewModel.activitySummary)
        } header: {
            Text("Today's Activity").font(.title3)
        } footer: {
            if viewModel.activitySummary == nil {
                Text("We can't find any activity summaries yet. Have you worn your watch today? Please make sure that permissions are enabled in the Health app.")
            }
        }
    }
    
    private var competitions: some View {
        Section {
            ForEach(viewModel.competitions) { competition in
                if competitionsFiltered ? competition.isActive : true {
                    CompetitionDetails(competition: competition, showParticipantCount: false, isFeatured: false)
                }
            }
            ForEach(viewModel.invitedCompetitions) { competition in
                if competitionsFiltered ? competition.isActive : true {
                    CompetitionDetails(competition: competition, showParticipantCount: false, isFeatured: false)
                }
            }
        } header: {
            HStack {
                let text = competitionsFiltered ? "Active competitions" : "Competitions"
                Text(text).font(.title3)
                Spacer()
                Button {
                    withAnimation { competitionsFiltered.toggle() }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle\(competitionsFiltered ? ".fill" : "")")
                        .font(.title2)
                }
                .disabled(viewModel.competitions.isEmpty)
                
                Button(toggling: $presentNewCompetition) {
                    Image(systemName: .plusCircle)
                        .font(.title2)
                }
            }
        } footer: {
            if viewModel.competitions.isEmpty && viewModel.invitedCompetitions.isEmpty {
                Text("Start a competition against multiple friends!")
            }
        }
    }
    
    private var friends: some View {
        Section {
            ForEach(viewModel.friends) { row in
                NavigationLink {
                    UserView(user: row.user)
                } label: {
                    HStack {
                        ActivityRingView(activitySummary: row.activitySummary?.hkActivitySummary)
                            .frame(width: 35, height: 35)
                        Text(row.user.name)
                        Spacer()
                        if row.isInvitation {
                            Text("Invited")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        } header: {
            HStack {
                Text("Friends")
                    .font(.title3)
                Spacer()
                Button(toggling: $presentSearchFriendsSheet) {
                    Image(systemName: .personCropCircleBadgePlus)
                        .font(.title2)
                }
            }
        } footer: {
            if viewModel.friends.isEmpty {
                Text("Get started by adding your friends!")
            }
        }
    }
}
