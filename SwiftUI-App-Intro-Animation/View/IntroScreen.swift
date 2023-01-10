//
//  IntroScreen.swift
//  SwiftUI-App-Intro-Animation
//
//  Created by Mehmet Kerim ÖZEK on 10.01.2023.
//

import SwiftUI
import Lottie

struct IntroScreen: View {
    // MARK: Intro Slides Model Data
    @State var introItems: [IntroItem] = [
        .init(title: "Request Pickup",
              subtitle: "Tell us who you're sending it to, what you're sending and when it's best to pickup the package and we will pick it up at the most convenient time.",
              lottieView: .init(name: "Pickup",bundle: .main)),
        .init(title: "Track Delivery",
              subtitle: "The best part starts when our courier is on the way to your location, as you will get real time notifications as to the exact location of the courier",
              lottieView: .init(name: "Transfer",bundle: .main)),
        .init(title: "Receive Package",
              subtitle: "The journey ends when your package get to it's location. Get notified immediately your package is received at its intended location",
              lottieView: .init(name: "Delivery",bundle: .main))
    ]
    var body: some View {
        GeometryReader{
            let size = $0.size
            
            HStack(spacing: 0){
                ForEach(introItems) { item in
                    VStack{
                        
                        // MARK: Top Nav Bar
                        
                        HStack{
                            Button("Back"){
                                
                            }
                            
                            Spacer(minLength: 0)
                            
                            Button("Skip"){
                                
                            }
                          
                        }
                        .tint(Color("Green"))
                        .font(.title3.bold())

                        
                        // MARK: Movable Slides
                        VStack(spacing: 15){
                            // MARK: Resizable Lottie View
                            
                            Text(item.title)
                                .font(.title.bold())
                            Text(item.subtitle)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                        }
                        
                        Spacer(minLength: 0)
                        
                        // MARK: Next-Login Button
                        VStack(spacing: 15){
                            Text("Next")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity)
                                .background{
                                    Capsule()
                                        .fill(Color("Green"))
                                }
                                .padding(.horizontal, 100)
                            
                            HStack{
                                Text("Terms of Service")
                                    .underline(true, color: .primary)
                                
                                Text("Privacy Policy")
                                    .underline(true, color: .primary)
                            }
                            .font(.caption2)
                          
                        }
                        
                    }
                    .padding(15)
                    .frame(width: size.width, height: size.height)
                }
            }
            .frame(width: size.width * CGFloat(introItems.count), alignment: .leading)
        }
    }
}

struct IntroScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
