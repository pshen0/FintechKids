//
//  Plot.swift
//  FintechKids
//
//  Created by Анна Сазонова on 31.03.2025.
//

import SwiftUI

struct Plot: Shape {
    private var values: [String: Double]
    
    init(_ values: [String: Double]) {
        self.values = values.isEmpty ? [:] : values
    }
    
    func drawPlot(in rect: CGRect) -> Path {
        guard !values.isEmpty else {
            return Path()
        }
        
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / PlotConstants.radiusRatio
        let points = PlotConstants.pointsCount
        let angle = Double.pi * 2 / Double(points)
        let maxValue = values.values.max() ?? PlotConstants.maxValue
        
        var positions: [CGPoint] = []
        var i = 0

        let sortedKeys = values.keys.sorted()
        
        for key in sortedKeys {
            if let number = values[key] {
                let transformedValue = transformValue(number, maxValue: maxValue)
                
                let length = radius * transformedValue
                let x = center.x + cos(Double(i) * angle - Double.pi / 2) * length
                let y = center.y + sin(Double(i) * angle - Double.pi / 2) * length
                positions.append(CGPoint(x: x, y: y))
            }
            i += 1
        }

        while positions.count < points {
            positions.append(center)
        }
        
        path.move(to: positions[0])
        
        for i in 0..<points {
            let nextIndex = (i + 1) % points
            let controlRadius = radius / PlotConstants.controlPointRatio
            let controlAngle = Double(i) * angle + (angle / 2) - Double.pi / 2
            let controlPoint = CGPoint(
                x: center.x + cos(controlAngle) * controlRadius,
                y: center.y + sin(controlAngle) * controlRadius
            )
            
            path.addQuadCurve(to: positions[nextIndex], control: controlPoint)
        }
        
        for i in 0..<points {
            path.addEllipse(in: CGRect(x: positions[i].x - PlotConstants.markRadius,
                                       y: positions[i].y - PlotConstants.markRadius,
                                       width: PlotConstants.markRadius * 2,
                                       height: PlotConstants.markRadius * 2))
        }
        
        path.closeSubpath()
        return path
    }
    
    func path(in rect: CGRect) -> Path {
        return drawPlot(in: rect)
    }
}

struct PlotView: View {
    let values: [String: Double]
    let transactions: [Transaction]
    @State private var progress: Double = 0.0
    @State private var scale: CGFloat = 0.8
    @State private var selectedCategory: String? = nil
    
    var body: some View {
        ZStack {
            PlotWithGradient(values: values, progress: progress)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            CategoryLabels(values: values, transactions: transactions, selectedCategory: $selectedCategory)
        }
        .frame(width: 320, height: 320)
        .padding(20)
        .scaleEffect(scale)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.spring()) {
                selectedCategory = nil
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 10).repeatForever(autoreverses: true)) {
                progress = 0.5
            }
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                scale = 1.0
            }
        }
    }
}

struct PlotWithGradient: View {
    let values: [String: Double]
    let progress: Double
    
    private var gradient: LinearGradient {
        let colors = [
            Color(red: 209/255, green: 129/255, blue: 240/255),
            Color(red: 115/255, green: 163/255, blue: 239/255),
            Color(red: 182/255, green: 224/255, blue: 155/255),
            Color(red: 255/255, green: 231/255, blue: 110/255),
            Color(red: 242/255, green: 151/255, blue: 76/255)
        ]
        
        let stops = zip(colors, [0.0, 0.2, 0.4, 0.6, 0.8].map { $0 + progress })
            .map { Gradient.Stop(color: $0, location: $1) }
        
        return LinearGradient(
            gradient: Gradient(stops: stops),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    var body: some View {
        ZStack {
            Plot(values)
                .fill(gradient.opacity(0.8))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            
            Plot(values)
                .stroke(Color.text.opacity(0.8), lineWidth: 2)
        }
    }
}

struct CategoryLabels: View {
    let values: [String: Double]
    let transactions: [Transaction]
    @Binding var selectedCategory: String?
    @State private var appear = false
    
    private func getRecentTransactions(for category: String) -> [Transaction] {
        return transactions
            .filter { $0.category == category }
            .sorted { $0.date > $1.date }
    }
    
    var body: some View {
        ForEach(Array(values.keys.sorted().enumerated()), id: \.element) { index, category in
            CategoryLabel(
                category: category,
                index: index,
                total: values.count,
                amount: values[category] ?? 0,
                recentTransactions: getRecentTransactions(for: category),
                isSelected: selectedCategory == category,
                onSelect: { selected in
                    withAnimation(.spring()) {
                        selectedCategory = selected ? category : nil
                    }
                }
            )
            .opacity(appear ? 1 : 0)
            .offset(y: appear ? 0 : 20)
            .animation(.easeOut(duration: 0.5).delay(Double(index) * 0.1), value: appear)
        }
        .onAppear {
            appear = true
        }
    }
}

struct CategoryLabel: View {
    let category: String
    let index: Int
    let total: Int
    let amount: Double
    let recentTransactions: [Transaction]
    let isSelected: Bool
    let onSelect: (Bool) -> Void
    
    private var position: CGPoint {
        let angle = Double(index) * (2 * .pi / Double(total)) - .pi / 2
        let radius: CGFloat = 140
        let x = cos(angle) * radius
        let y = sin(angle) * radius
        return CGPoint(x: 160 + x, y: 160 + y)
    }
    
    private var infoPosition: CGPoint {
        let angle = Double(index) * (2 * .pi / Double(total)) - .pi / 2
        let radius: CGFloat = -30
        let x = cos(angle) * radius
        let y = sin(angle) * radius
        return CGPoint(x: 160 + x, y: 160 + y)
    }
    
    var body: some View {
        ZStack {
            Text(category)
                .font(Font.custom(Fonts.deledda, size: 14))
                .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.8))
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 0.2, green: 0.4, blue: 0.8).opacity(0.3), lineWidth: 1.5)
                        )
                )
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                .onTapGesture {
                    onSelect(!isSelected)
                }
            
            if isSelected {
                CategoryInfo(
                    category: category,
                    amount: amount,
                    recentTransactions: recentTransactions
                )
                .transition(.scale.combined(with: .opacity))
                .position(infoPosition)
            }
        }
        .position(position)
    }
}

struct CategoryInfo: View {
    let category: String
    let amount: Double
    let recentTransactions: [Transaction]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(category)
                .font(Font.custom(Fonts.deledda, size: 18))
                .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.8))
                .padding(.horizontal, 10)
                .padding(.top, 6)
            
            Text("Общая сумма: \(String(format: "%.2f", amount)) ₽")
                .font(Font.custom(Fonts.deledda, size: 14))
                .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.8))
                .padding(.horizontal, 10)
            
            if !recentTransactions.isEmpty {
                Text("Последние траты:")
                    .font(Font.custom(Fonts.deledda, size: 14))
                    .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.8))
                    .padding(.horizontal, 10)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(recentTransactions.prefix(3)) { transaction in
                            VStack(alignment: .leading) {
                                Text(transaction.description)
                                    .font(Font.custom(Fonts.deledda, size: 14))
                                    .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.8))
                                    .lineLimit(2)
                                Text("\(String(format: "%.2f", abs(transaction.amount))) ₽")
                                    .font(Font.custom(Fonts.deledda, size: 14))
                                    .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.8))
                            }
                            Divider()
                        }
                    }
                }
                .frame(maxHeight: 45)
                .padding(.horizontal, 10)
                .padding(.bottom, 6)
            }
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
        .frame(width: 190)
    }
}

func transformValue(_ value: Double, maxValue: Double) -> Double {
    let logValue = log(value + 1)
    let normalizedValue = logValue / log(maxValue + 1)
    return normalizedValue
}

struct CoordinateAxes: Shape {
    func drawCoordinateAxes(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / PlotConstants.radiusRatio
        let points = PlotConstants.pointsCount
        let angle = Double.pi * 2 / Double(points)
        var positions: [CGPoint] = []
        
        for i in 0..<points {
            let tempAngle = Double(i) * angle - Double.pi / 2
            let x = center.x + CGFloat(cos(tempAngle)) * radius
            let y = center.y + CGFloat(sin(tempAngle)) * radius
            let point = CGPoint(x: x, y: y)
            positions.append(point)
            
            path.move(to: center)
            path.addLine(to: point)
        }
        
        for i in PlotConstants.quarters {
            path.addEllipse(in: CGRect(
                x: center.x - radius / i,
                y: center.y - radius / i,
                width: (radius / i) * 2,
                height: (radius / i) * 2
            ))
        }
        return path
    }
    
    func path(in rect: CGRect) -> Path {
        return drawCoordinateAxes(in: rect)
    }
}

//MARK: - Constants

enum PlotConstants {
    static let radiusRatio: Double = 2
    static let controlPointRatio: Double = 3.5
    static let pointsCount = 5
    static let maxValue: Double = 50
    static let markRadius: Double = 4
    static let quarters = [2.0, 1.0]
}
