//
//  BlurView.swift
//  SlideOverCard
//
//  Created by Lee Angioletti on 7/23/19.
//  Copyright © 2019 Lee Angioletti. All rights reserved.
//

import SwiftUI

struct BackgroundView: UIViewRepresentable {
	let blurEnabled: Bool
	let backgroundColor: UIColor
	
	func makeUIView(context: Context) -> UIView {
		if blurEnabled {
			let blurEffect = UIBlurEffect(style: .systemThickMaterial)
			return UIVisualEffectView(effect: blurEffect)
	
		} else {
			let view = UIView(frame: .zero)
			view.backgroundColor = backgroundColor
			return view
		}
	}
	func updateUIView(_ view: UIView, context: Context) {

	}
	
}

