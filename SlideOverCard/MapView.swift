//
//  MapView.swift
//  SlideOverCard
//
//  Created by Lee Angioletti on 7/20/19.
//  Copyright © 2019 Lee Angioletti. All rights reserved.
//

import SwiftUI
import MapKit

// UIViewRepresentable protocol has two requirements you need to add: a makeUIView(context:) method that creates an MKMapView, and an updateUIView(_:context:) method that configures the view and responds to any changes
struct MapView: UIViewRepresentable {
	func makeUIView(context: Context) -> MKMapView {
		MKMapView(frame: .zero)
	}
	
	func updateUIView(_ view: MKMapView, context: Context) {
		let coordinate = CLLocationCoordinate2D(latitude: 34.011286, longitude: -116.166868)
		let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
		let region = MKCoordinateRegion(center: coordinate, span: span)
		view.setRegion(region, animated: true)
	}
}

struct MapView_Preview: PreviewProvider {
	static var previews: some View {
		MapView()
	}
}
