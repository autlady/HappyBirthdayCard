//
//  StarFrame.swift
//  HappyBirthdaySwiftUI
//
//  Created by  Юлия Григорьева on 15.11.2022.
//

import SwiftUI

struct StarFrame: Shape {
    let count = 8
    let inset: CGFloat = 10
    let lineWidth: CGFloat = 10
    let lineColor = Color(.red)


    func path(in rect: CGRect) -> Path {

        let insetRect = CGRectInset(rect, inset, inset)
        let radius = (insetRect.width > insetRect.height ? insetRect.height : insetRect.width) / 2.0
        let center = CGPoint(x: CGRectGetMidX(insetRect), y: CGRectGetMidY(insetRect))
        let radian = CGFloat(Double.pi * 2) / CGFloat(count)
        let start = CGPoint(x:
                                center.x, y: center.y - radius
            )
        var p = Path()
        p.move(to: start)
        for i in 1...count  {
            let θ = CGFloat(3 * (Double.pi / 2)) - CGFloat(i) * radian
            let point = CGPoint(
                x: center.x + radius * cos(θ),
                y: center.y + radius * sin(θ)
            )
            p.addLine(to: point)
        }
        return p
    }
}


struct StarFrame_Previews: PreviewProvider {
    static var previews: some View {
        StarFrame()
    }
}
