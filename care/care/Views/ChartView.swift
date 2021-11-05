//
//  ChartView.swift
//  care
//
//  Created by rutik maraskolhe on 02/11/21.
//

import SwiftUI

struct ChartView: View {
    let values: [Int]
    let labels: [String]
    let xAxisLabels: [String]

    var body: some View {
        GeometryReader { geo in
            HStack(alignment: .bottom) {
                ForEach(0..<values.count) { idx in
                    let max  = values.max() ?? 0

                    VStack {
                        Text(labels[idx])
                            .font(.caption)
                            .rotationEffect(.degrees(-60))

                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.orange)
                            .frame(width: 20, height: CGFloat(values[idx]) / CGFloat(max) * geo.size.height * 0.6)
                        
                        Text(xAxisLabels[idx])
                            .font(.caption)
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.primary.opacity(0.2))
                .cornerRadius(10)
                .padding(.bottom,20)
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        let values = [213,343,3,3,344,435,342,30]
        let lables = ["213","343","3","3","344","435","342","30"]
        let xAxisValues = ["May 30", "May 31","June 1", "June 2", "June 3", "June 4", "June 5", "June 6"]
        ChartView(values: values, labels: lables, xAxisLabels: xAxisValues)
    }
}
