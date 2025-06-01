import SwiftUI
import ComposableArchitecture

struct GroupItemView: View {
    var group: Group
    var badgeValue: Int = 0
    var systemImage: String = "folder"

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: systemImage)
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor(.accentColor)
            VStack {
                HStack {
                    Text(group.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                }
                HStack {
                    Text(group.description ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
        }
        .padding(3)
        .badge(badgeValue)
    }
}

#Preview {
    GroupItemView(group: GroupList.sample[0], badgeValue: 12)
    .frame(minWidth: 200)
    .padding()
}
