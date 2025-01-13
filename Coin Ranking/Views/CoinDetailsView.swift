//
//  CoinDetailsView.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 13/01/2025.
//

import SwiftUI

struct CoinDetailsView: View {
    @StateObject var viewModel: CoinDetailsViewModel

    private var isPositiveChange: Bool {
        if let val = Double(viewModel.details?.change ?? ""), val > 0 {
            return true
        }
        return false
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Name, price, 24h change
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(viewModel.details?.name ?? "")
                                .font(.body)

                            Text("#\(viewModel.details?.rank ?? 0)")
                                .font(.footnote)
                                .foregroundStyle(Color("TextGray"))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                                .background(Color("AppGray"))
                                .clipShape(RoundedRectangle(cornerRadius: 8))

                            Spacer()
                        }

                        Text("$\(viewModel.details?.price.formatPrice() ?? "")")
                            .font(.title)
                            .bold()
                    }

                    Spacer()

                    Text("\(viewModel.details?.change ?? "")%")
                        .font(.title3)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(isPositiveChange ? Color.green : Color.red)
                        .foregroundStyle(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }

                Divider()
                    .background(Color("AppGray"))

                // Chart
                if viewModel.isLoadingHistory {
                    ProgressView()
                        .padding()
                } else {
                    CoinHistoryView(history: viewModel.history)
                }

                Divider()
                    .background(Color("AppGray"))

                // Description
                Text(viewModel.details?.description ?? "")
                    .font(.subheadline)

                Divider()
                    .background(Color("AppGray"))

                // Statistics
                if viewModel.isLoadingDetails {
                    ProgressView()
                        .padding()
                } else {
                    CoinStatisticsView(viewModel: viewModel)
                }
            }
        }
        .padding(.horizontal, 8)
        .background(Color("AppBlack"))
        .foregroundStyle(Color.white)
        .task {
            await viewModel.fetchDetails()
            await viewModel.fetchHistory()
        }
        .alert(
            "Error",
            isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.errorMessage = nil }}
            ),
            presenting: viewModel.errorMessage) { _ in
                Button("Cancel", role: .cancel) {}
            } message: { message in
                Text(message)
            }
    }
}

#Preview {
    let coin = Coin(uuid: "Qwsogvtv82FCd",
                    rank: 1,
                    symbol: "BTC",
                    marketCap: "1811602126581",
                    price: "91451.123456",
                    iconUrl: "https://cdn.coinranking.com/Sy33Krudb/btc.svg",
                    change: "-3.33"
    )
    let viewModel = CoinDetailsViewModel(coin: coin)

    return CoinDetailsView(viewModel: viewModel)
}
