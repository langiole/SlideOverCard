//
//  Color+.swift
//  SlideOverCard
//
//  Created by Lee Angioletti on 7/29/19.
//  Copyright © 2019 Lee Angioletti. All rights reserved.
//

import SwiftUI

extension Color {
    init(uiColor: UIColor) {
        self.init(red: Double(uiColor.rgba.red),
                  green: Double(uiColor.rgba.green),
                  blue: Double(uiColor.rgba.blue),
                  opacity: Double(uiColor.rgba.alpha))
    }
}
