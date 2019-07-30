//
//  CardView.swift
//  SlideOverCard
//
//  Created by Lee Angioletti on 7/21/19.
//  Copyright © 2019 Lee Angioletti. All rights reserved.
//

import SwiftUI

struct CardView<Content: View>: View {
	@GestureState private var dragState = DragState.inactive
	@State private var position = DefaultPosition.bottom
	var blurEnabled: Bool = false
	var backgroundColor: UIColor = .secondarySystemBackground
	var content: () -> Content
	
	var body: some View {
		let drag = DragGesture()
			.updating($dragState) { drag, state, transaction in
				state = .dragging(translation: drag.translation)
			}
			.onEnded(dragEnded)
		let tap = TapGesture()
			.onEnded { _ in
				if self.position == DefaultPosition.top {
					self.position = DefaultPosition.bottom
				} else {
					self.position = DefaultPosition.top
				}
			}
		
		return ZStack {
			BackgroundView(blurEnabled: blurEnabled, backgroundColor: backgroundColor)
				.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
			Handle()
				.padding(.bottom, 881)
			self.content()
		}
		.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
		.cornerRadius(10)
		.shadow(radius: 7)
		.offset(y: position.rawValue + dragState.translation.height < DefaultPosition.top.rawValue ? logDrag(): linearDrag())
		.animation(dragState.isDragging ? nil : .interactiveSpring())
		.gesture(drag)
		.gesture(tap)
		
	}
	
	func linearDrag() -> CGFloat {
		return position.rawValue + dragState.translation.height
	}
	
	func logDrag() -> CGFloat {
		return DefaultPosition.top.rawValue - pow(-dragState.translation.height, 0.7)
	}
	
	func dragEnded(drag: DragGesture.Value) {
		let direction = drag.startLocation.y - drag.location.y
		let relativePosition = position.rawValue + drag.translation.height
		let upperhalf = (DefaultPosition.middle.rawValue - DefaultPosition.top.rawValue) / CGFloat(2)
		let lowerhalf = (DefaultPosition.bottom.rawValue - DefaultPosition.middle.rawValue) / CGFloat(2)
		
		// calculated final position if the user dragged and stopped
		if abs(drag.location.y - drag.predictedEndLocation.y) < 10 {
			switch position {
			case .top:
				if abs(drag.translation.height) < upperhalf { return }
			case .middle:
				if (direction > 0 && abs(drag.translation.height) < upperhalf) ||
					(direction < 0 && abs(drag.translation.height) < lowerhalf) { return }
			case .bottom:
				if abs(drag.translation.height) < lowerhalf { return }
			}
		}

		// calculate desired final position based on the drag translation
		if (direction > 0) {
			if (relativePosition < DefaultPosition.middle.rawValue) {
				position = DefaultPosition.top
			}
			else {
				position = DefaultPosition.middle
			}
		} else {
			if (relativePosition > DefaultPosition.middle.rawValue) {
				position = DefaultPosition.bottom
			}
			else {
				position = DefaultPosition.middle
			}
		}
	}
}



enum DefaultPosition: CGFloat {
	case top = 56.0
	case middle = 571.0
	case bottom = 792.0
}

enum DragState {
	case inactive
	case dragging(translation: CGSize)
	
	var translation: CGSize {
		switch self {
		case .inactive:
			return .zero
		case .dragging(let translation):
			return translation
		}
	}
	
	var isActive: Bool {
		switch self {
		case .inactive:
			return false
		case .dragging:
			return true
		}
	}
	
	var isDragging: Bool {
		switch self {
		case .inactive:
			return false
		case .dragging:
			return true
		}
	}
}

