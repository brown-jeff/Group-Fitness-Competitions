import Factory
import SwiftUI
import SwiftUIX

struct CompetitionView: View {
    
    @StateObject private var viewModel: CompetitionViewModel

    @State private var canSaveEdits = true
    
    init(competition: Competition) {
        _viewModel = .init(wrappedValue: .init(competition: competition))
    }

    var body: some View {
        List {
            standings
            if !viewModel.pendingParticipants.isEmpty {
                pendingInvites
            }
            CompetitionInfo(competition: $viewModel.competition, editing: viewModel.editing) {
                canSaveEdits = $0
            }
            actions
        }
        .navigationTitle(viewModel.competition.name)
        .toolbar {
            if viewModel.canEdit {
                HStack {
                    if viewModel.editing {
                        Button("Save", action: viewModel.saveTapped)
                            .disabled(!canSaveEdits)
                    }
                    Button(viewModel.editButtonTitle, action: viewModel.editTapped)
                        .font(viewModel.editing ? .body.bold() : .body)
                }
            }
        }
        .registerScreenView(
            name: "Competition",
            parameters: [
                "id": viewModel.competition.id,
                "name": viewModel.competition.name
            ]
        )
    }

    private var standings: some View {
        Section {
            ForEach(viewModel.standings) {
                CompetitionParticipantView(config: $0)
            }
        } header: {
            Text("Standings")
        } footer: {
            if viewModel.standings.isEmpty {
                Text("Nothing here, yet.")
            }
        }
    }

    private var pendingInvites: some View {
        Section("Pending invites") {
            ForEach(viewModel.pendingParticipants) {
                CompetitionParticipantView(config: $0)
            }
        }
    }

    private var actions: some View {
        Section {
            ForEach(viewModel.actions, id: \.self) { action in
                Button {
                    viewModel.perform(action)
                } label: {
                    Label(action.buttonTitle, systemImage: action.systemImage)
                        .if(action.destructive) { view in
                            view.foregroundColor(.red)
                        }
                }
            }
        }
        .confirmationDialog(viewModel.confirmationTitle, isPresented: $viewModel.confirmationRequired, titleVisibility: .visible) {
            Button("Yes", role: .destructive, action: viewModel.confirm)
            Button("Cancel", role: .cancel) {}
        }
        .sheet(isPresented: $viewModel.showInviteFriend) {
            InviteFriends(action: .competitionInvite(viewModel.competition))
        }
    }
}
