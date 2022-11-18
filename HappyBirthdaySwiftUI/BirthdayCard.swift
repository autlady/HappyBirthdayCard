//
//  BirthdayCard.swift
//  HappyBirthdaySwiftUI
//
//  Created by  Юлия Григорьева on 15.11.2022.
//

import SwiftUI
import EffectsLibrary

struct BirthdayCard: View {

    @State private var isShimmering = false
    @State private var jiggle = false

    var body: some View {
        ZStack {
            VStack {
                Text("Happy Birthday!")
                    .font(Font.custom("PermanentMarker-Regular", size: 40))
                    .foregroundStyle(
                        .linearGradient(
                            colors:[Color.red, Color.blue],
                            startPoint: .leading,
                            endPoint: isShimmering ? .trailing : .leading))
                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: false), value: isShimmering)
                    .onAppear {
                        isShimmering.toggle()
                    }
                Image("photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                    .clipShape(ShapeView(corners: 5, smoothness: 0.45))
                    .shadow(radius: 10)
                Text("Make A Wish!")
                    .font(Font.custom("PermanentMarker-Regular", size: 30))
                    .foregroundColor(Color.red.opacity(2))
                    .scaleEffect(jiggle ? 1.0 : 0.3)
                    .animation( Animation.easeInOut(duration: 1.3) .repeatForever(autoreverses: true),
                                            value: jiggle)
                    .onAppear() { self.jiggle.toggle() }
            }
            .padding()
            FireworkView()
        }
    }

    struct FireworkView: View {
        var body: some View {
            FireworksView(
                        config: FireworksConfig(
                            content: [
                                .shape(.triangle, .blue, 2.0),
                                .shape(.square, .green, 1.0),
                                .shape(.circle, .red, 2.0)
                            ],
                            intensity: .high,
                            lifetime: .long,
                            initialVelocity: .medium,
                            fadeOut: .slow,
                            spreadRadius: .high
                        )
                    )
        }
    }
}

struct BirthdayCard_Previews: PreviewProvider {
    static var previews: some View {
        BirthdayCard()
            .preferredColorScheme(.dark)
    }
}
