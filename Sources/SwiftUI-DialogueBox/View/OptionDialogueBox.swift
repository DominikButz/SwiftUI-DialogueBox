//
//  SwiftUIView.swift
//  
//
//  Created by Dominik Butz on 28/10/2022.
//

import SwiftUI

struct OptionDialogueBox<Header: View, Buttons: View>: View {
    
    let dialogueType: DialogueType
    let frameWidth: CGFloat
    let settings: OptionDialogueSettings
    @ViewBuilder var header: ()->Header
    @ViewBuilder var content: ()->Buttons
    
    init(dialogueType: DialogueType, frameWidth: CGFloat, settings: OptionDialogueSettings, @ViewBuilder header:  @escaping ()->Header,  @ViewBuilder content: @escaping () -> Buttons) {
        self.dialogueType = dialogueType
        self.frameWidth = frameWidth
        self.settings = settings
        self.header = header
        self.content = content
    }
    
    var body: some View {
        VStack {
            
            header()
            
            // buttons
            content()
   
        }
        .padding(.bottom, dialogueType == .alert ? settings.alertBottomPadding : settings.sheetBottomPadding)
        .background(background)
            .frame(width:frameWidth)

    }
    
    var background: some View {
        Group {
            if self.dialogueType == .alert {
                RoundedRectangle(cornerRadius: settings.boxCornerRadius).foregroundColor(Color(.secondarySystemBackground))
            } else {
                RoundedCornerRectangle(tl:settings.boxCornerRadius, tr: settings.boxCornerRadius, bl: 0, br:0).foregroundColor(Color(.secondarySystemBackground))
            }
        }.shadow(color: self.settings.boxShadow != nil ? settings.boxShadow!.color : .clear, radius: self.settings.boxShadow != nil ? settings.boxShadow!.radius : 0, x: settings.boxShadow != nil ? settings.boxShadow!.x : 0, y: settings.boxShadow != nil ? settings.boxShadow!.y : 0)
    }
    
}

public enum DialogueType {
    case alert, sheet
}

//struct OptionDialogueTest: View {
//    
//    var body: some View {
//        
//        GeometryReader { proxy in
//            VStack {
//                     
//                Spacer()
//                OptionDialogueBox(dialogueType: .alert, frameWidth: min(proxy.size.width * 0.75, 300), settings: OptionDialogueSettings(), header: {
//                    VStack {
//                        Text("Some Alert")
//                        Text("Choose an option")
//                    }
//                        
//                }) {
//                    
//                    OptionButton(title: "First Option", subtitle: "Just tap me!", textColor: .accentColor, triggerHandler: {
//                        print("first option tapped")
//                    }, image: Image(systemName: "pencil.circle"), enabled: true)
//                    
//                    OptionButton(title: "Second Option", subtitle: "Just tap me!", textColor: .accentColor, triggerHandler: {
//                        print("second option tapped")
//                    }, image: Image(systemName: "square.and.arrow.up"), enabled: true)
//                    
//                    OptionButton(title: "Cancel", textColor: .red, triggerHandler: {
//                        print("Cancel  tapped")
//                    }, enabled: true)
//                    .padding(.bottom, 5)
//                }
//                Spacer()
//                             
//            }.frame(width: proxy.size.width, height: proxy.size.height)
//         
//        }
//    }
//}
//
//struct OptionDialogueBox_Previews: PreviewProvider {
//    static var previews: some View {
//        OptionDialogueTest().ignoresSafeArea(.all)
//    }
//}


