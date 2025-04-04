//
//  CropView.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 31.03.2025.
//

import SwiftUI

struct CropView: View {
    var image: UIImage
    @Binding var croppedImage: UIImage?
    @Environment(\.dismiss) var dismiss
    
    var width: CGFloat
    var height: CGFloat
    @State var location: CGPoint = .init(x: 50, y: 50)
    
    var body: some View {
        GeometryReader { geometry in
            let aspect = image.size.height / image.size.width
            ZStack {
                CustomGradient()
                fullImage
                    .overlay(
                        rectFrame
                            .frame(width: width, height: height)
                            .position(location)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        location = CGPoint(
                                            x: min(max(value.location.x, width / 2), geometry.size.width - width / 2),
                                            y: min(max(value.location.y, height / 2), (width * aspect) - height / 3)
                                        )
                                    }
                            )
                    )
                
                VStack {
                    Spacer()
                    GradientButton(title: "Обрезать", action:
                                    {croppedImage = cropImage(geometry.size)
                        dismiss()
                    })
                    .padding()
                }
            }
        }
    }

    func cropImage(_ geometrySize: CGSize) -> UIImage? {
        let scaleX = image.size.width / geometrySize.width
        let scaleY = image.size.height / geometrySize.height
        let scale = max(scaleX, scaleY)
        let scaledRect = CGRect(
            x: (location.x - width / 2) * scale,
            y: (location.y - height / 2) * scale,
            width: width * scale,
            height: height * scale
        )
        
        guard let cgImage = image.cgImage?.cropping(to: scaledRect) else { return nil }
        return UIImage(cgImage: cgImage)
    }
    
    private var fullImage: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
    }
    
    private var rectFrame: some View {
        RoundedRectangle(cornerRadius: 20)
            .stroke(Color.blue, lineWidth: 2)
            .background(Color(red: 1, green: 1, blue: 1, opacity: 0.1))
    }
}

