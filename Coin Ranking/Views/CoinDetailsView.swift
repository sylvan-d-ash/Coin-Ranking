//
//  CoinDetailsView.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 13/01/2025.
//

import SwiftUI

struct CoinDetailsView: View {
    let details: CoinDetails
    let history: [CoinHistory]

    private var isPositiveChange: Bool {
        if let val = Double(details.change), val > 0 {
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
                            Text(details.name)
                                .font(.body)

                            Text("#\(details.rank)")
                                .font(.footnote)
                                .foregroundStyle(Color("TextGray"))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                                .background(Color("AppGray"))
                                .clipShape(RoundedRectangle(cornerRadius: 8))

                            Spacer()
                        }

                        Text("$\(details.price.formatPrice())")
                            .font(.title)
                            .bold()
                    }

                    Spacer()

                    Text("\(details.change)%")
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
                CoinHistoryView(history: history)

                Divider()
                    .background(Color("AppGray"))

                // Description
                Text(details.description)
                    .font(.subheadline)

                Divider()
                    .background(Color("AppGray"))

                // Statistics
                CoinStatisticsView(details: details)
            }
        }
        .padding(.horizontal, 8)
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

    let history = [
        CoinHistory(price: "91641.73371438966", timestamp: TimeInterval(1736774700)),
        CoinHistory(price: "91579.73371438966", timestamp: TimeInterval(1736774400)),
        CoinHistory(price: "91351.73371438966", timestamp: TimeInterval(1736774100)),
        CoinHistory(price: "91201.73371438966", timestamp: TimeInterval(1736773800)),
        CoinHistory(price: "90813.73371438966", timestamp: TimeInterval(1736773500)),
        CoinHistory(price: "90782.73371438966", timestamp: TimeInterval(1736773200)),
        CoinHistory(price: "90821.73371438966", timestamp: TimeInterval(1736772900)),
        CoinHistory(price: "90613.73371438966", timestamp: TimeInterval(1736772600)),
    ]

    return CoinDetailsView(details: details, history: history)
}
