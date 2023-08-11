//
//  LineGraph.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 8.08.2023.
//

import SwiftUI
import Charts

struct CoinGraph: View {
    var data: [Double]
    var maxY: Double
    var minY: Double
    var lineColor: Color
    @State var percentage: CGFloat = 0
    init(coin: CoinModel) {
        data = coin.sparkline_in_7d?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let price = (data.last ?? 0) - (data.first ?? 0)
        lineColor = price > 0 ? Color.green : Color.red
        
    }
    var body: some View {
        VStack {
            chartView
                .background(VStack {
                    Divider()
                    Spacer()
                    Divider()
                    Spacer()
                    Divider()
                })
        }
        
    }
}

extension CoinGraph {
    private var chartView: some View {
        GeometryReader { geomerty in
            Path { path in
                for index in data.indices {
                    let xPosition = geomerty.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geomerty.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }.trim(from: 0,to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2,lineCap: .round,lineJoin: .round))
                .shadow(color: lineColor.opacity(0.5) , radius: 10)
                .shadow(color: lineColor.opacity(0.2) , radius: 10)
                .shadow(color: lineColor.opacity(0.2) , radius: 10)
            
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
    }
}

//struct LineGraph_Previews: PreviewProvider {
//    static var previews: some View {
//        CoinGraph(coin: coin)
//    }
//}
