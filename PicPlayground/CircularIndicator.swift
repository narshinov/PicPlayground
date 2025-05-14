//
//  RotationAxisView.swift
//  PicPlayground
//
//  Created by Никита Аршинов on 13.05.25.
//

import SwiftUI

protocol IndicatorTypeImpl {
    var image: Image { get }
    var maxValue: CGFloat { get }
}

enum RotationIndicatorType: CaseIterable, IndicatorTypeImpl {
    case rotation
    case vertical
    case horizontal
    
    var image: Image {
        switch self {
        case .horizontal: .init(systemName: "trapezoid.and.line.horizontal.fill")
        case .vertical: .init(systemName: "trapezoid.and.line.vertical.fill")
        case .rotation: .init(systemName: "circle.and.line.horizontal.fill")
        }
    }
    
    var maxValue: CGFloat {
        switch self {
        case .horizontal, .vertical: 30
        case .rotation: 45
        }
    }
}

struct CircularIndicator<T: IndicatorTypeImpl>: View {
    let model: Model
            
    var body: some View {
        content
            .degreeIndicator(model.value)
    }
    
    @ViewBuilder
    private var content: some View {
        if model.isEdited {
            model.type.image
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .foregroundStyle(.black)
        } else {
            Text(displayValue)
        }
    }
    
    private var displayValue: String {
        Int((model.type.maxValue * model.value).rounded()).formatted(.number)
    }
    
    struct Model {
        let type: T
        var value: CGFloat
        var isEdited: Bool = true
    }
}

#Preview {
    let type = RotationIndicatorType.rotation
    CircularIndicator(model: .init(type: type, value: 0.5))
}

struct DegreeIndicator: ViewModifier {
    let value: CGFloat
    
    func body(content: Content) -> some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 3)
                .foregroundStyle(.tertiary)
            
            Circle()
                .trim(from: .zero, to: .init(abs(value)))
                .stroke(style: .init(lineWidth: 2, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .scaleEffect(x: trimDirection)
            
            content
        }
        .foregroundStyle(color)
        .frame(width: 64, height: 64)
    }
    
    private var trimDirection: CGFloat {
        value <= 0 ? -1 : 1
    }
    
    private var color: Color {
        value <= 0 ? .black : .yellow
    }
}

extension View {
    func degreeIndicator(_ value: CGFloat) -> some View {
        modifier(DegreeIndicator(value: value))
    }
}
