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
        
        for key in values.keys {
            if let number = values[key] {
                let transformedValue = transformValue(number, maxValue: maxValue)
                
                let length = radius * transformedValue
                let x = center.x + cos(Double(i) * angle - Double.pi / 2) * length
                let y = center.y + sin(Double(i) * angle - Double.pi / 2) * length
                positions.append(CGPoint(x: x, y: y))
            }
            i += 1
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
    static let markRadius: Double = 1
    static let quarters = [2.0, 1.0]
}
