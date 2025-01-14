//
//  SortOptionsView.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 12/01/2025.
//

import SwiftUI

struct SortOptionsView: View {
    var sortOptions: [SortOption]
    @ObservedObject var viewModel: SortOptionsViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Sort by")
                .font(.headline)
                .foregroundStyle(Color.white)

            HStack {
                ForEach(sortOptions, id: \.self) { option in
                    Text(option.displayValue)
                        .padding(10)
                        .background(
                            viewModel.selectedOption == option ? Color.white : Color("AppGray")
                        )
                        .foregroundStyle(
                            viewModel.selectedOption == option ? Color("AppGray") : Color.white
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(viewModel.selectedOption == option ? Color.white : Color("AppGray"))
                        }
                        .clipShape(
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                        )
                        .onTapGesture {
                            viewModel.selectedOption = option
                        }
                }

                Spacer()
            }
        }
        .padding(.top, 5)
        .padding(.bottom, 10)
        .background(Color("AppBlack"))
    }
}

#Preview {
    SortOptionsView(sortOptions: SortOption.allCases, viewModel: SortOptionsViewModel())
}
