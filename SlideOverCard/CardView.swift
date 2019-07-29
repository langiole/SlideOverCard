//
//  CardView.swift
//  SlideOverCard
//
//  Created by Lee Angioletti on 7/21/19.
//  Copyright © 2019 Lee Angioletti. All rights reserved.
//

import SwiftUI

struct CardView<Content: View>: View {
	@GestureState var dragState = DragState.inactive
	@State var position = DefaultPosition.bottom
	@State var v_abs = 0.0
	@State var dist = 0.0
	var blurEnabled: Bool? = false
	//v_rel = v_abs / (target — current)
	var content: () -> Content
	
	
	var body: some View {
		let drag = DragGesture()
			.updating($dragState) { drag, state, transaction in
				state = .dragging(translation: drag.translation)
			}
			.onEnded(dragEnded)
				
		return ZStack {
			if (blurEnabled!) {
				BlurView()
					.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
			}
			Handle()
				.padding(.bottom, 881)
			self.content()
		}
		.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
		.foregroundColor(Color.white)
		.cornerRadius(10)
		.shadow(radius: 7)
		.offset(y: position.rawValue + dragState.translation.height < DefaultPosition.top.rawValue ? logDrag(): linearDrag())
		.animation(dragState.isDragging ? nil : .interactiveSpring())
		.gesture(drag)
		
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

		if (direction > 0) {
			if (relativePosition < DefaultPosition.middle.rawValue) {
				position = DefaultPosition.top
			}
			else {
				position = DefaultPosition.middle
			}
		}
		else {
			if (relativePosition > DefaultPosition.middle.rawValue) {
				position = DefaultPosition.bottom
			}
			else {
				position = DefaultPosition.middle
			}
		}

		//self.position = DefaultPosition.middle
		v_abs = abs(Double(drag.translation.height / CGFloat(drag.time.timeIntervalSinceNow)))
		dist = Double(position.rawValue - drag.location.y)
	}
}



enum DefaultPosition: CGFloat {
	case top = 56
	case middle = 571
	case bottom = 792
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

#if DEBUG
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView {
			VStack {
				Text("Hello")
				Text("Hello")
			}
		}
    }
}
#endif

