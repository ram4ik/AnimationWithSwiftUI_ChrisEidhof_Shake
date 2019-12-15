//
//  ContentView.swift
//  AnimationWithSwiftUI_ChrisEidhof_Shake
//
//  Created by Ramill Ibragimov on 15.12.2019.
//  Copyright © 2019 Ramill Ibragimov. All rights reserved.
//

import SwiftUI

struct Dump: View {
    var result = ""
    init<A>(_ value: A) {
        dump(value, to: &result)
    }
    var body: Text { Text(result) }
}

struct ShakeEffect: GeometryEffect {
    var position: CGFloat = 0
    var numberOfShakes = 3
    
    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        print(position)
        return ProjectionTransform(CGAffineTransform(translationX: 30 * sin(CGFloat(numberOfShakes) * position * 2 * .pi), y: 0))
    }
}

struct ContentView: View {
    @State var selected = false
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.pink)
                .frame(width: 200, height: 100)
                .modifier(ShakeEffect(position: selected ? 1 : 0))
                .animation(Animation.default)
            
            Button(action: {
                self.selected.toggle()
            }, label: { selected ? Text("Deselected") : Text("Select") })
            
            Dump(Rectangle().fill(Color.pink).frame(width: 200, height: 100))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
