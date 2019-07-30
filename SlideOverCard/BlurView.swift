//
//  BlurView.swift
//  SlideOverCard
//
//  Created by Lee Angioletti on 7/23/19.
//  Copyright © 2019 Lee Angioletti. All rights reserved.
//

import SwiftUI

struct BlurView: UIViewRepresentable {	
	func makeUIView(context: Context) -> UIView {
		let blurEffect = UIBlurEffect(style: .systemThinMaterial)
		return UIVisualEffectView(effect: blurEffect)
	}
	func updateUIView(_ view: UIView, context: Context) {

	}
	
}

