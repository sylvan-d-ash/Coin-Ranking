//
//  SortButton.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 14/01/2025.
//

import SwiftUI

struct SortButton: View {
    enum SortIndicatorPosition {
        case prefix
        case suffix
    }

    let title: String
    let isSelected: Bool
    let sortDirection: SortDirection
    let indicatorPosition: SortIndicatorPosition
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                if indicatorPosition == .prefix, isSelected {
                    Image(systemName: sortDirection == .descending ? "chevron.down" : "chevron.up")
                        .resizable()
                        .frame(width: 10, height: 6)
                }

                Text(title)

                if indicatorPosition == .suffix, isSelected {
                    Image(systemName: sortDirection == .descending ? "chevron.down" : "chevron.up")
                        .resizable()
                        .frame(width: 10, height: 6)
                }
            }
        }
    }
}

#Preview {
    SortButton(title: "Price", isSelected: true, sortDirection: .ascending, indicatorPosition: .prefix, action: {})
}
