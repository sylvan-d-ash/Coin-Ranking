//
//  CoinRowView.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 12/01/2025.
//

import SwiftUI

struct CoinRowView: View {
    enum Dimensions {
        static let rank: CGFloat = 30
        static let price: CGFloat = 100
        static let icon: CGFloat = 40
        static let padding: CGFloat = 10
        static let change: CGFloat = 60
    }

    @State var position: Int
    @State var coin: Coin

    var body: some View {
        HStack {
            Text("\(position)")
                .foregroundColor(Color(red: 0.807843137254902, green: 0.8352941176470589, blue: 0.8941176470588236))
                .frame(width: Dimensions.rank, alignment: .leading)
                .foregroundStyle(Color("TextGray"))

            AsyncImage(url: URL(string: coin.iconUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: Dimensions.icon, height: Dimensions.icon)
                        .foregroundStyle(Color.white)
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: Dimensions.icon, height: Dimensions.icon)
                        .clipShape(Circle())
                case .failure:
                    Circle()
                        .fill(Color.red)
                        .frame(width: Dimensions.icon, height: Dimensions.icon)
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading) {
                Text(coin.symbol)
                    .font(.body)
                    .bold()
                    .foregroundStyle(Color.white)

                Text(coin.marketCap.formatMarketCap())
                    .font(.caption)
                    .foregroundStyle(Color("TextGray"))
            }

            Spacer()

            Text("$\(coin.price.formatPrice())")
                .frame(width: Dimensions.price, alignment: .trailing)
                .foregroundStyle(Color("TextGray"))

            Text("\(coin.change)%")
                .foregroundStyle(Color("TextGray"))
                .frame(width: Dimensions.change)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(.leading, Dimensions.padding)
        }
        .padding(.horizontal, Dimensions.padding)
        .padding(.vertical, 8)
        .background(Color("AppBlack"))
    }
}

#Preview {
    let coin = Coin(uuid: "adsas", rank: 1, symbol: "BTC", marketCap: "1899234234543", price: "887654.78", iconUrl: "https://cdn.coinranking.com/Sy33Krudb/btc.svg", change: "-2120.5", sparkline: "")
    return CoinRowView(position: 1, coin: coin)
}
