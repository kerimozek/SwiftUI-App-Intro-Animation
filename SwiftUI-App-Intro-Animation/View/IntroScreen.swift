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
    // MARK: Current Slide Index
    @State var currentIndex: Int = 0
    var body: some View {
        GeometryReader{
            let size = $0.size
            
            HStack(spacing: 0){
                ForEach($introItems) { $item in
                    let isLastSlide = (currentIndex == introItems.count - 1)
                    VStack{
                        
                        // MARK: Top Nav Bar
                        
                        HStack{
                            Button("Back"){
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                    playAnimation()
                                }
                            }
                            .opacity(currentIndex > 0 ? 1 : 0)
                            
                            Spacer(minLength: 0)
                            
                            Button("Skip"){
                                currentIndex = introItems.count - 1
                                playAnimation()
                            }
                            .opacity(isLastSlide ? 0 : 1)
                        }
                        .animation(.easeInOut, value: currentIndex)
                        .tint(Color("Green"))
                        .font(.title3.bold())

                        
                        // MARK: Movable Slides
                        VStack(spacing: 15){
                            let offset = -CGFloat(currentIndex) * size.width
                            // MARK: Resizable Lottie View
                            ResizableLottieView(introItem: $item)
                                .frame(height: size.width)
                                .onAppear{
                                    // MARK: Initially Playing First Slide Animation
                                    if currentIndex == indexOf(item){
                                        item.lottieView.play(toProgress: 0.7)
                                    }
                                }
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5), value: currentIndex)
                            Text(item.title)
                                .font(.title.bold())
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.1), value: currentIndex)
                            Text(item.subtitle)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal,15)
                                .foregroundColor(.gray)
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.2), value: currentIndex)
                        }
                        
                        Spacer(minLength: 0)
                        
                        // MARK: Next-Login Button
                        VStack(spacing: 15){
                            Text(isLastSlide ? "Login" : "Next")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical,isLastSlide ? 13 : 12)
                                .frame(maxWidth: .infinity)
                                .background{
                                    Capsule()
                                        .fill(Color("Green"))
                                }
                                .padding(.horizontal,isLastSlide ? 40 : 100)
                                .onTapGesture{
                                    // MARK: Updating to Next Index
                                    if currentIndex < introItems.count - 1 {
                                        // MARK: Pausing Previous Animation
                                        let currentProgress = introItems[currentIndex].lottieView.currentProgress
                                        introItems[currentIndex].lottieView.currentProgress = (currentProgress == 0 ? 0.7 : currentProgress)
                                        currentIndex += 1
                                        // MARK: Playing Next Animation from Start
                                        playAnimation()
                                    }
                                }
                            
                            HStack{
                                Text("Terms of Service")
                                    .underline(true, color: .primary)
                                
                                Text("Privacy Policy")
                                    .underline(true, color: .primary)
                            }
                            .font(.caption2)
                            .offset(y: 5)
                          
                        }
                        .animation(.easeInOut, value: isLastSlide)
                    }
                    .padding(15)
                    .frame(width: size.width, height: size.height)
                }
            }
            .frame(width: size.width * CGFloat(introItems.count), alignment: .leading)
        }
    }
    
    // MARK: Playing Animation
    func playAnimation() {
        introItems[currentIndex].lottieView.currentProgress = 0
        introItems[currentIndex].lottieView.play(toProgress: 0.7)
    }
    
    // MARK: Retreving Index of the Item in the Array
    func indexOf(_ item: IntroItem)-> Int{
        if let index = introItems.firstIndex(of: item){
            return index
        }
        return 0
    }
}

struct IntroScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: Resizable Lottie View Without Background

struct ResizableLottieView: UIViewRepresentable{
    @Binding var introItem: IntroItem
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        setupLottieView(view)
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    func setupLottieView(_ to: UIView){
        let lottieView = introItem.lottieView
        lottieView.backgroundColor = .clear
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: Applying Constraints
        let constraints = [
            lottieView.widthAnchor.constraint(equalTo: to.widthAnchor),
            lottieView.heightAnchor.constraint(equalTo: to.heightAnchor),
        ]
        to.addSubview(lottieView)
        to.addConstraints(constraints)
        
    }
}
