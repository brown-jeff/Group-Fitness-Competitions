import SwiftUI

struct FeaturedCompetition: View {

    let competition: Competition

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        color
            .aspectRatio(3/2, contentMode: .fit)
            .overlay {
                if let banner = competition.banner {
                    FirebaseImage(path: banner)
                }
            }
            .overlay {
                // has navigation link already
                CompetitionDetails(competition: competition, showParticipantCount: true, isFeatured: true)
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .background(.ultraThinMaterial)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .cornerRadius(10)
    }

    private var color: some View {
        colorScheme == .light ? Color(uiColor: .systemGray4) : Color.secondarySystemBackground
    }
}
