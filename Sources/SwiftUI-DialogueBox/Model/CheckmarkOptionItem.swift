//
//  File.swift
//  
//
//  Created by Dominik Butz on 28/10/2022.
//

import Foundation
import SwiftUI

public class CheckmarkOptionItem: Identifiable, ObservableObject, Equatable {

    public let id: UUID
    var title: String
    var subtitle: String?
    let tintColor: Color?
    let shouldDismiss: Bool
    @Published var selected: Bool
    var enabled: Bool
    
    /// CheckmarkOptionItem initialiser. serves as model for a CheckmarkButton
    /// - Parameters:
    ///   - title: title of the checkmark button
    ///   - subtitle: subtitle of the checkmark button
    ///   - tintColor:  color of the elements in the checkmark button view.
    ///   - shouldDismiss: set to true if the checkmark button tap should trigger the dialogue to be dismissed.
    ///   - selected: determines if the checkmark should be set or not.
    ///   - enabled: set to true if the checkmark button should be allowed to respond to the user's tap or other gesture.
    public init(title: String, subtitle: String? = nil, tintColor: Color? = .accentColor, shouldDismiss: Bool = true, selected:Bool = false, enabled: Bool = true) {
        self.id = UUID()
        self.title = title
        self.subtitle = subtitle
        self.tintColor =  tintColor
        self.shouldDismiss = shouldDismiss
        self.selected = selected
        self.enabled = enabled
          
    }
    public static func == (lhs: CheckmarkOptionItem, rhs: CheckmarkOptionItem) -> Bool {
        return lhs.id == rhs.id
    }
    
}
