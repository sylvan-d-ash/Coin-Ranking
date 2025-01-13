//
//  CoinStatisticsView.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 13/01/2025.
//

import SwiftUI

struct CoinStatisticsView: View {
    let details: CoinDetails

    var body: some View {
        VStack(alignment: .leading) {
            Text("Statistics")
                .font(.title)

            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Market Cap")
                            .foregroundStyle(Color("TextGray"))
                        Text("$\(details.marketCap.formatMarketCap())")
                            .bold()
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Volume")
                            .foregroundStyle(Color("TextGray"))
                        Text("$\(details.volume.formatMarketCap())")
                            .bold()
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Max Supply")
                            .foregroundStyle(Color("TextGray"))
                        Text("\(details.supply.max.formatMarketCap()) \(details.symbol)")
                            .bold()
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text("All Time High")
                            .foregroundStyle(Color("TextGray"))
                        Text("$\(details.allTimeHigh.price.formatPrice())")
                            .bold()
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Number of Markets")
                            .foregroundStyle(Color("TextGray"))
                        Text("\(details.numberOfMarkets)")
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
                        Text(details.fullyDilutedMarketCap.formatMarketCap())
                            .bold()
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Circulating Supply")
                            .foregroundStyle(Color("TextGray"))
                        Text("\(details.supply.circulating.formatMarketCap()) \(details.symbol)")
                            .bold()
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Total Supply")
                            .foregroundStyle(Color("TextGray"))
                        Text("\(details.supply.total.formatMarketCap()) \(details.symbol)")
                            .bold()
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Ranks")
                            .foregroundStyle(Color("TextGray"))
                        Text("#\(details.rank)")
                            .bold()
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Number of Exhanges")
                            .foregroundStyle(Color("TextGray"))
                        Text("\(details.numberOfExchanges)")
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
    let supply = CoinDetails.Supply(max: "21000000", total: "19809512", circulating: "19809512")
    let allTimeHigh = CoinDetails.AllTimeHigh(price: "108195.47505398515")
    let details = CoinDetails(uuid: "Qwsogvtv82FCd",
                              name: "Bitcoin",
                              symbol: "BTC",
                              rank: 1, price: "91451.123456",
                              change: "-3.33",
                              marketCap: "1811602126581",
                              volume: "37487203119",
                              fullyDilutedMarketCap: "1920473591586",
                              description: "Bitcoin is a digital currency with a finite supply, allowing users to send/receive money without a central bank/government, often nicknamed \"Digital Gold\"",
                              numberOfMarkets: 2451,
                              numberOfExchanges: 104,
                              supply: supply,
                              allTimeHigh: allTimeHigh
    )
    return CoinStatisticsView(details: details)
}
