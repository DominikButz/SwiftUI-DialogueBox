//
//  File.swift
//  
//
//  Created by Dominik Butz on 28/10/2022.
//

import Foundation
import SwiftUI

public struct OptionDialogueSettings {

    var boxCornerRadius: CGFloat
    var backgroundEffect: BackgroundEffect
    var backgroundDimColor: Color
    var backgroundBlurRadius: CGFloat
    var boxShadow: Shadow?
    var dismissOnBackgroundTap: Bool
    var alertBottomPadding: CGFloat
    var sheetBottomPadding: CGFloat
    
    /// OptionDialogueSettings initialiser
    /// - Parameters:
    ///   - boxCornerRadius: corner radius of the dialogue box. Applied to all four corners if the dialogue type is an alert. Applied only to top corners if dialogue type is a sheet.
    ///   - backgroundEffect: background effect when the dialogue box appears - either dim or blur
    ///   - backgroundDimColor: dim effect color if selected background effect is dim.
    ///   - backgroundBlurRadius: blur radius  if selected background effect is blur.
    ///   - boxShadow: drop shadow under the dialogue box.
    ///   - dismissOnBackgroundTap: determines if the alert or sheet can be dismissed by tapping on the background. Default is true.
    ///   - alertBottomPadding: bottom padding under the buttons view if dialogue type is an alert.
    ///   - sheetBottomPadding: bottom padding under the buttons view if dialogue type is a sheet. 
    public init( boxCornerRadius: CGFloat = 15, backgroundEffect: BackgroundEffect = .dim, backgroundDimColor: Color = .black.opacity(0.2), backgroundBlurRadius: CGFloat = 0.8, boxShadow: Shadow? = Shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: -5), dismissOnBackgroundTap: Bool = true, alertBottomPadding: CGFloat = 10, sheetBottomPadding: CGFloat = 20) {
 
        self.boxCornerRadius = boxCornerRadius
        self.backgroundEffect = backgroundEffect
        self.backgroundDimColor = backgroundDimColor
        self.backgroundBlurRadius = backgroundBlurRadius
        self.boxShadow = boxShadow
        self.dismissOnBackgroundTap = dismissOnBackgroundTap
        self.alertBottomPadding = alertBottomPadding
        self.sheetBottomPadding = sheetBottomPadding
    }
    
}
