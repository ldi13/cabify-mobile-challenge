//
//  LoaderView.swift
//  Challenge
//
//  Created by Lorenzo Di Vita on 1/10/21.
//

import SwiftUI

struct LoaderView: View {
  @State var isLoading: Bool = false

  var body: some View {
    Circle()
        .trim(from: 0, to: 0.6)
        .stroke(lineWidth: 2)
        .frame(width: 20, height: 20)
        .foregroundColor(Color.white)
        .rotationEffect(Angle(degrees: self.isLoading ? 0 : 360))
        .onAppear {
            withAnimation(.linear(duration: 0.3).repeatForever(autoreverses: false)) {
                self.isLoading.toggle()
            }
        }
  }
}
