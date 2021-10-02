//
//  BadgeView.swift
//  Challenge
//
//  Created by Lorenzo Di Vita on 2/10/21.
//

import SwiftUI
import ComposableArchitecture
import ChallengeCore

struct BadgeView: View {
    @BindableState var badgeCount: Int
    
    var body: some View {
        ZStack {
            Circle()
              .foregroundColor(.red)
            Text("\(self.badgeCount)")
                .foregroundColor(.white)
                .font(Font.system(size: 12))
        }
        .frame(width: 16, height: 16)
        .opacity(self.badgeCount == 0 ? 0 : 1)
    }
}


