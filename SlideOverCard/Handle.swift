//
//  Handle.swift
//  SlideOverCard
//
//  Created by Lee Angioletti on 7/23/19.
//  Copyright © 2019 Lee Angioletti. All rights reserved.
//

import SwiftUI

struct Handle: View {
    private let handleThickness = CGFloat(5.0)
    var body: some View {
        RoundedRectangle(cornerRadius: handleThickness / 2.0)
            .frame(width: 36, height: handleThickness)
            .padding(5)
			.foregroundColor(Color.secondary)
    }
}
