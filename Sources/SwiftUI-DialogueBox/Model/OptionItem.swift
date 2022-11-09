//
//  File.swift
//  
//
//  Created by Dominik Butz on 30/10/2022.
//

import Foundation
import SwiftUI

public struct OptionItem: Identifiable, Equatable {

    public let id: UUID
    public var title: String
    public var subtitle: String?
    public var image: Image?
    public let tintColor: Color?
    public var triggerHandler: (()->Void)?
    public let shouldDismiss: Bool
    public var enabled: Bool
    
    /// Option Item - holds properties of an OptionButton or any custom view
    /// - Parameters:
    ///   - title: title of the view
    ///   - subtitle: subtitle of the view
    ///   - image: image of the view
    ///   - tintColor: color of the elements in the button view.
    ///   - shouldDismiss: set to true if the button or custom view tap should trigger the dialogue to be dismissed.
    ///   - enabled: set to true if the button or custom view should be allowed to respond to the user's tap or other gesture.
    ///   - triggerHandler: closure to insert additional logic that should be triggered by the user's gesture. 
    public init(title: String, subtitle: String? = nil, image: Image? = nil,  tintColor: Color? = .accentColor, shouldDismiss: Bool = true,  enabled: Bool = true, triggerHandler: (()->Void)? ) {
        self.id = UUID()
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.tintColor = tintColor
        self.triggerHandler = triggerHandler
        self.shouldDismiss = shouldDismiss
        self.enabled = enabled 
          
    }
     
   public static func == (lhs: OptionItem, rhs: OptionItem) -> Bool {
        return lhs.id == rhs.id
    }
    
}


