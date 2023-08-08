//
//  LineGraph.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 8.08.2023.
//

import SwiftUI

struct LineGraph: View {
    var data: [Double]?
    var body: some View {
        if let data = data, data.count > 1 {
            GeometryReader { proxy in
                ZStack {
                    let height = proxy.size.height
                    let width = (proxy.size.width) / CGFloat(data.count)
                    
                    let maxPoint = (data.max() ?? 0) + 100
                    
                    let point = data.enumerated().compactMap{ item -> CGPoint in
                        let progress = item.element / maxPoint
                        
                    let pathHeight = progress + height
                    
                    let pathWidth = width * CGFloat(item.offset)
                    return CGPoint(x: pathWidth, y: -pathHeight + height)
                    }
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        
                        path.addLines(point)
                    }
                    .strokedPath(StrokeStyle(lineWidth: 2.5,lineCap: .round,lineJoin: .round))
                    .fill(
                        LinearGradient(colors: [
                            Color(.blue)
                        ], startPoint: .top, endPoint: .bottom)
                    )
                }
            }
        } else {
            Text("Geçersiz")
        }

    }
}

struct LineGraph_Previews: PreviewProvider {
    static var previews: some View {
        LineGraph()
    }
}
