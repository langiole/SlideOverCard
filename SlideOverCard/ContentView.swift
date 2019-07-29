//
//  ContentView.swift
//  SlideOverCard
//
//  Created by Lee Angioletti on 7/20/19.
//  Copyright © 2019 Lee Angioletti. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		ZStack {
			MapView()
			CardView(blurEnabled: true) {
				VStack {
					Text("Hello")
					Text("Hello")
				}
			}
		}
		.edgesIgnoringSafeArea(.vertical)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
