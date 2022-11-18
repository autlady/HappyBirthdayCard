//
//  ShapeView.swift
//  HappyBirthdaySwiftUI
//
//  Created by  Юлия Григорьева on 15.11.2022.
//

import SwiftUI

struct ShapeView: Shape {

    let corners: Int
    let smoothness: Double

    func path(in rect: CGRect) -> Path {
            // проверяем, что у нас есть по крайней мере два угла
            guard corners >= 2 else { return Path() }

            // рисуем от центра нашего прямоугольника
            let center = CGPoint(x: rect.width / 2, y: rect.height / 2)

            // начинаем прямо вверх
            var currentAngle = -CGFloat.pi / 2

            // считаем, сколько нам нужно переместить с каждым углом звезды
            let angleAdjustment = .pi * 2 / Double(corners * 2)

            // выясняем, на сколько нам нужно переместить X / Y для внутренних точек звезды
            let innerX = center.x * smoothness
            let innerY = center.y * smoothness

            // создаем Path
            var path = Path()

            // начинаем с исходного положения
            path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))

            // самая низкая точка, к которой мы приближаемся, чтобы позже мы могли центрировать
            var bottomEdge: Double = 0

            // идем циклом по всем точкам и внутренним точкам
            for corner in 0..<corners * 2  {
                // определяем местоположение точки
                let sinAngle = sin(currentAngle)
                let cosAngle = cos(currentAngle)
                let bottom: Double

                // если кратно 2, мы рисуем внешний край звезды
                if corner.isMultiple(of: 2) {
                    // сохраняем Y позицию
                    bottom = center.y * sinAngle

                    // сохраняем Y позицию
                    path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
                } else {
                    // не кратно 2, что означает, что мы рисуем внутреннюю точку

                    // сохраняем Y позицию
                    bottom = innerY * sinAngle

                    // и добавляем линию
                    path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
                }

                // если эта новая нижняя точка является самой низкой, отложите ее на потом
                if bottom > bottomEdge {
                    bottomEdge = bottom
                }

                // перемещаемся к следующему углу
                currentAngle += angleAdjustment
            }

            // определите, сколько неиспользуемого пространства у нас есть в нижней части нашего прямоугольника для рисования
            let unusedSpace = (rect.height / 2 - bottomEdge) / 2

            // создайте и примените преобразование, которое перемещает наш контур вниз на эту величину, центрируя фигуру по вертикали
            let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
            return path.applying(transform)
        }
    }



