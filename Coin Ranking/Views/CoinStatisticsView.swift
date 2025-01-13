//
//  CoinStatisticsView.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 13/01/2025.
//

import SwiftUI

struct CoinStatisticsView: View {
    @StateObject var viewModel: CoinDetailsViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Statistics")
                .font(.title)

            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Market Cap")
                            .foregroundStyle(Color("TextGray"))
                        Text("$\(viewModel.details?.marketCap.formatMarketCap() ?? "")")
                            .bold()
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Volume")
                            .foregroundStyle(Color("TextGray"))
                        Text("$\(viewModel.details?.volume.formatMarketCap() ?? "")")
                            .bold()
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Max Supply")
                            .foregroundStyle(Color("TextGray"))
                        Text("\(viewModel.details?.supply.max?.formatMarketCap() ?? "∞") \(viewModel.details?.symbol ?? "")")
                            .bold()
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text("All Time High")
                            .foregroundStyle(Color("TextGray"))
                        Text("$\(viewModel.details?.allTimeHigh.price.formatPrice() ?? "")")
                            .bold()
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Number of Markets")
                            .foregroundStyle(Color("TextGray"))
                        Text("\(viewModel.details?.numberOfMarkets ?? 0)")
                            .bold()
                    }
                }
                .font(.subheadline)

                Spacer()
                Divider()
                    .background(Color("TextGray"))
                    .padding(.trailing, 10)

                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Fully Diluted Market Cap")
                            .foregroundStyle(Color("TextGray"))
                        Text(viewModel.details?.fullyDilutedMarketCap.formatMarketCap() ?? "")
                            .bold()
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Circulating Supply")
                            .foregroundStyle(Color("TextGray"))
                        Text("\(viewModel.details?.supply.circulating.formatMarketCap() ?? "") \(viewModel.details?.symbol ?? "")")
                            .bold()
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Total Supply")
                            .foregroundStyle(Color("TextGray"))
                        Text("\(viewModel.details?.supply.total.formatMarketCap() ?? "") \(viewModel.details?.symbol ?? "")")
                            .bold()
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Ranks")
                            .foregroundStyle(Color("TextGray"))
                        Text("#\(viewModel.details?.rank ?? 0)")
                            .bold()
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Number of Exhanges")
                            .foregroundStyle(Color("TextGray"))
                        Text("\(viewModel.details?.numberOfExchanges ?? 0)")
                            .bold()
                    }
                }
                .font(.subheadline)
            }
        }
        .background(Color("AppBlack"))
        .foregroundStyle(Color.white)
    }
}

#Preview {
//    let supply = CoinDetails.Supply(max: "21000000", total: "19809512", circulating: "19809512")
//    let allTimeHigh = CoinDetails.AllTimeHigh(price: "108195.47505398515")
//    let details = CoinDetails(uuid: "Qwsogvtv82FCd",
//                              name: "Bitcoin",
//                              symbol: "BTC",
//                              rank: 1, price: "91451.123456",
//                              change: "-3.33",
//                              marketCap: "1811602126581",
//                              volume: "37487203119",
//                              fullyDilutedMarketCap: "1920473591586",
//                              description: "Bitcoin is a digital currency with a finite supply, allowing users to send/receive money without a central bank/government, often nicknamed \"Digital Gold\"",
//                              numberOfMarkets: 2451,
//                              numberOfExchanges: 104,
//                              supply: supply,
//                              allTimeHigh: allTimeHigh
//    )

    let coin = Coin(uuid: "Qwsogvtv82FCd",
                    rank: 1,
                    symbol: "BTC",
                    marketCap: "1811602126581",
                    price: "91451.123456",
                    iconUrl: "https://cdn.coinranking.com/Sy33Krudb/btc.svg",
                    change: "-3.33"
    )
    let viewModel = CoinDetailsViewModel(coin: coin)

    return CoinStatisticsView(viewModel: viewModel)
}
