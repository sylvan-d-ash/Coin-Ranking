//
//  FiltersView.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 12/01/2025.
//

import SwiftUI

struct FiltersView: View {
    var filters: [FilterOption]
    @ObservedObject var viewModel: FiltersViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Sort by")
                .font(.headline)
                .foregroundStyle(Color.white)

            HStack {
                ForEach(filters, id: \.self) { filter in
                    Text(filter.displayValue)
                        .padding(10)
                        .background(
                            viewModel.selectedFilter == filter ? Color.white : Color("AppGray")
                        )
                        .foregroundStyle(
                            viewModel.selectedFilter == filter ? Color("AppGray") : Color.white
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(viewModel.selectedFilter == filter ? Color.white : Color("AppGray"))
                        }
                        .clipShape(
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                        )
                        .onTapGesture {
                            print("tapped: \(filter.displayValue)")
                            viewModel.selectedFilter = filter
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
    FiltersView(filters: FilterOption.allCases, viewModel: FiltersViewModel())
}
