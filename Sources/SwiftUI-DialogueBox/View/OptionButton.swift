//
//  OptionButton.swift
//  
//
//  Created by Dominik Butz on 28/10/2022.
//

import Foundation
import SwiftUI

public struct OptionButton: View {

    let title: String
    let subtitle: String?
    let accentColor: Color?
    let image: Image?
    
    @Binding var show: Bool
    @Binding var enabled: Bool
    let triggerHandler: (()->Void)?
    let shouldDismiss: Bool
    
    public init(title: String, subtitle: String? = nil, accentColor: Color? = .accentColor, image: Image? = nil, triggerHandler: (() -> Void)? = nil, shouldDismiss: Bool,  enabled: Binding<Bool>, show: Binding<Bool>) {
        self.title = title
        self.subtitle = subtitle
        self.accentColor = accentColor
        self.image = image
        self._enabled = enabled
        self.triggerHandler = triggerHandler
        self.shouldDismiss = shouldDismiss
        self._show = show
       
    }
    
    public var body: some View {
        Button(action: {
            guard self.enabled else {return}
            if self.shouldDismiss { 
                show = false
            }
            triggerHandler?()
        }) {
                VStack {
                    Divider()
                    HStack(alignment:.center) {
                        
                        VStack(alignment: image == nil ? .center :  .leading) {
                                Text(title).font(.callout)
                                if let subtitle = subtitle {
                                    Text(subtitle).font(.footnote).lineLimit(2).fixedSize(horizontal: false, vertical: true)
                                }
              
                        }
                        
                        if let image = image {
                            Spacer()
                            image.font(.system(size: 21))
                                //.foregroundColor(accentColor)
                        }
                    }.padding(.horizontal, 8)
            }
        }.foregroundColor(accentColor ?? .accentColor).disabled(enabled == false )

    }
}

