//
//  CoinDetailsView.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 13/01/2025.
//

import SwiftUI
import Charts

struct CoinDetails: Decodable {
    struct Supply: Decodable {
        let max: String
        let total: String
        let circulating: String
    }

    struct AllTimeHigh: Decodable {
        let price: String
    }

    let uuid: String
    let name: String
    let symbol: String
    let rank: Int
    let price: String
    let change: String
    let marketCap: String
    let volume: String // 24hVolume
    let fullyDilutedMarketCap: String
    let description: String
    let numberOfMarkets: Int
    let numberOfExchanges: Int
    let supply: Supply
    let allTimeHigh: AllTimeHigh

    var isPositiveChange: Bool {
        if let val = Double(change), val > 0 {
            return true
        }
        return false
    }
}

struct CoinHistory: Decodable {
    struct History: Decodable {
        let price: String
        let timestamp: TimeInterval
    }

    let change: String
    let history: [History]
}

struct CoinDetailsView: View {
    let details: CoinDetails
    let history: CoinHistory

    private var isPositiveChange: Bool {
        if let val = Double(details.change), val > 0 {
            return true
        }
        return false
    }

    private func formattedTime(from timestamp: TimeInterval) -> Date {
        return Date(timeIntervalSince1970: timestamp)
    }

    private func amPMTime(from timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        return formatter.string(from: date)
    }

    private func priceRange() -> ClosedRange<Double> {
        let prices = history.history.compactMap { Double($0.price) }
        guard let minPrice = prices.min(), let maxPrice = prices.max() else {
            return 0...1
        }
        print(minPrice)
        print(maxPrice)
        return minPrice...maxPrice
    }

    private func isExtremePrice(_ price: Double) -> Bool {
        let prices = history.history.compactMap { Double($0.price) }
        guard let minPrice = prices.min(), let maxPrice = prices.max() else {
            return false
        }
        return price == minPrice || price == maxPrice
    }

    private func extremePrices() -> (min: Double, max: Double)? {
        let prices = history.history.compactMap { Double($0.price) }
        guard let minPrice = prices.min(), let maxPrice = prices.max() else {
            return nil
        }
        return (min: minPrice, max: maxPrice)
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

                Chart(history.history, id: \.timestamp) { entry in
                    LineMark(
                        x: .value("Time", formattedTime(from: entry.timestamp)),
                        y: .value("Price", Double(entry.price) ?? 0.0)
                    )
                    .foregroundStyle(Color.green)
                }
                .chartYScale(domain: priceRange())
                .chartXAxis {
                    AxisMarks { value in
                        AxisValueLabel()
                            .foregroundStyle(Color("TextGray"))
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .trailing) { value in
                        AxisValueLabel()
                            .foregroundStyle(Color("TextGray"))
                        AxisGridLine()
                            .foregroundStyle(Color("TextGray"))
                        AxisTick()
                    }

                    // Add lowest and highest price markers
                    if let prices = extremePrices() {
                        AxisMarks(values: [prices.min, prices.max]) { value in
                            AxisValueLabel()
                                .font(.caption)
                                .foregroundStyle(Color("TextGray"))
                            AxisGridLine()
                                .foregroundStyle(Color("TextGray"))
                        }
                    }
                }
                .frame(height: 200)

                Divider()
                    .background(Color("AppGray"))

                Text(details.description)
                    .font(.subheadline)

                Divider()
                    .background(Color("AppGray"))

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

    let history = CoinHistory(change: "-3.33",
                              history: [
                                CoinHistory.History(price: "91641.73371438966", timestamp: TimeInterval(1736774700)),
                                CoinHistory.History(price: "91579.73371438966", timestamp: TimeInterval(1736774400)),
                                CoinHistory.History(price: "91351.73371438966", timestamp: TimeInterval(1736774100)),
                                CoinHistory.History(price: "91201.73371438966", timestamp: TimeInterval(1736773800)),
                                CoinHistory.History(price: "90813.73371438966", timestamp: TimeInterval(1736773500)),
                                CoinHistory.History(price: "90782.73371438966", timestamp: TimeInterval(1736773200)),
                                CoinHistory.History(price: "90821.73371438966", timestamp: TimeInterval(1736772900)),
                                CoinHistory.History(price: "90613.73371438966", timestamp: TimeInterval(1736772600)),
                              ]
    )

    return CoinDetailsView(details: details, history: history)
}
