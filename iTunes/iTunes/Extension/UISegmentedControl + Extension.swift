//
//  UISegmentedControl + Extension.swift
//  iTunes
//
//  Created by Siba Krushna on 13/11/24.
//

import UIKit

// Extension for UISegmentedControl to adjust the content hugging priority
extension UISegmentedControl {
    // Override the `didMoveToSuperview` method which is called when the view is added to a superview
    override open func didMoveToSuperview() {
        super.didMoveToSuperview() // Call the superclass implementation
        // Set the content hugging priority for the vertical axis to low.
        // This affects how the segmented control behaves when there is extra space in its container.
        self.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}

