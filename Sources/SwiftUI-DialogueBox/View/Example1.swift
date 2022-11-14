//
//  Example1.swift
//  
//
//  Created by Dominik Butz on 28/10/2022.
//

import Foundation
import SwiftUI

public struct SimpleDialogueExample:View  {
    
    @Environment(\.colorScheme) var colorScheme
    @State var show: Bool = false
    @State var dialogueBoxType: DialogueType = .alert
    @State var backgroundEffect: BackgroundEffect = .dim

    @State var items: [OptionItem] = [OptionItem(title: "Edit", subtitle: nil, image: Image(systemName: "pencil.circle"),  shouldDismiss: true, enabled: true, triggerHandler: nil),
          OptionItem(title: "Share", subtitle: "..with everyone", image: Image(systemName: "square.and.arrow.up"),  shouldDismiss: true, enabled: true, triggerHandler: nil),
          OptionItem(title: "Cancel", subtitle: nil, image: nil, tintColor: .red, shouldDismiss: true, enabled: true, triggerHandler: nil)
         ]
    
    public init() {
        
    }
    
    
    public var body: some View {
        
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    VStack {
                    Picker(selection: $dialogueBoxType, label: Text("Dialogue Type")) {
                        Text("Alert").tag(DialogueType.alert)
                        Text("Sheet").tag(DialogueType.sheet)
                    }.pickerStyle(WheelPickerStyle())
                    
                    Picker(selection: $backgroundEffect, label: Text("Background Effect")) {
                        Text("Dim").tag(BackgroundEffect.dim)
                        Text("Blur").tag(BackgroundEffect.blur)
                        Text("None").tag(BackgroundEffect.none)
                    }.pickerStyle(WheelPickerStyle())
                    
                    
                }
                    Spacer()
                    Divider()
                    
                    Button(action: {
                        withAnimation {
                            self.show = true
                        }
                    }) {
                        Text(self.dialogueBoxType == .alert ? "Show Alert" : "Show Sheet")
                    }.padding()
                
                
                Spacer()
                }
            }
            .dialogueBox(type: dialogueBoxType, frameWidth: dialogueBoxType == .alert ?  min(proxy.size.width * 0.75, 300) : min(400, proxy.size.width),  settings: OptionDialogueSettings(backgroundEffect: backgroundEffect, boxShadow: shadow, dismissOnBackgroundTap: self.dialogueBoxType == .sheet), show: $show, header: {
                  OptionDialogueDefaultHeader(title: "Simple Dialogue", message: "Choose an option")
            }) {

               dialogueBoxContent()

            }
      
        }
    }
    
    public var shadow: Shadow {
        let color = colorScheme == .light ? Color.gray.opacity(0.4) : Color.clear
        let offsetX: CGFloat = self.dialogueBoxType == .alert ? -5 : 0
        return Shadow(color: color, radius: 5, x: offsetX, y: -5)

    }
    
    @ViewBuilder func dialogueBoxContent()->some View {

            ForEach(items) { item in
                
                OptionButton(title: item.title, subtitle: item.subtitle, accentColor: item.tintColor, image: item.image,  shouldDismiss: item.shouldDismiss, enabled:  .constant(item.enabled), show: $show, triggerHandler: item.triggerHandler)
                 
            }
        
       
    }
    

}


struct SimpleDialogueExample_Previews: PreviewProvider {
    static var previews: some View {
        SimpleDialogueExample()
    }
}

