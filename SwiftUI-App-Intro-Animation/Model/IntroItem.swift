//
//  IntroItem.swift
//  SwiftUI-App-Intro-Animation
//
//  Created by Mehmet Kerim ÖZEK on 10.01.2023.
//

import SwiftUI
import Lottie

// MARK: Intro Item Model

struct IntroItem: Identifiable,Equatable{
    var id: UUID = .init()
    var title: String
    var subtitle: String
    var lottieView: LottieAnimationView = .init()
}
