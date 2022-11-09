//
//  File.swift
//  
//
//  Created by Dominik Butz on 28/10/2022.
//

import Foundation
import SwiftUI

struct OptionDialogueScene<Header: View, Buttons: View>: ViewModifier {
    
    let dialogueType: DialogueType
    let frameWidth: CGFloat
    let settings: OptionDialogueSettings
    
    @Binding var show: Bool
    @ViewBuilder var header: ()->Header
    @ViewBuilder var buttons: ()->Buttons
    
    func body(content: Content) -> some View {
        
        ZStack {
                 
            content.blur(radius: self.settings.backgroundEffect == .blur && self.show ? settings.backgroundBlurRadius : 0)


              VStack {
             
                     Spacer()

                      if self.dialogueType == .alert {
                          alert
                          Spacer()
                      } else {
                          sheet
                      }
                    

                 }
                 .frame(width:UIScreen.main.bounds.width)
                 .background(background)
                 .animation(.easeIn, value: self.show)
                 .edgesIgnoringSafeArea(.all)

         }
    }
    
    var background: some View {
        
        Group {
            if self.show {
                self.settings.backgroundEffect == .dim ? settings.backgroundDimColor : Color.gray.opacity(0.01)
            } else {
                Color.clear
            }
           
        }.onTapGesture {
            guard self.settings.dismissOnBackgroundTap else {return}
            withAnimation(.easeOut) {
                self.show = false
            }
        }
    }
    
    var dialogueBox: some View {
        OptionDialogueBox(dialogueType: dialogueType, frameWidth: frameWidth, settings: settings, header: header, content: buttons)
    }
    
    var alert: some View {
        Group {
            if self.show {
                dialogueBox
                    .transition(AnyTransition.asymmetric(insertion: AnyTransition.scale.animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.5)), removal: AnyTransition.opacity.animation(.easeOut(duration: 0.3))))
            }
        }
    }
    
    var sheet: some View {
        dialogueBox
        .offset(y: self.show ? 0 : UIScreen.main.bounds.height)
        .animation(.spring(response: 0.6, dampingFraction: 0.9, blendDuration: 1), value: self.show)
    }

}

public extension View {
    
    /// Option Dialogue View Modifier
    /// - Parameters:
    ///   - type: DialogueBox type - alert or sheet
    ///   - frameWidth: frame width of the dialogue box
    ///   - settings: settings
    ///   - show: bool binding to a state variable or published variable
    ///   - header: header view of the dialogue box - insert a OptionDialogueDefaultHeader or custom view
    ///   - buttons: insert Button views or any other custom views.
    /// - Returns: some View
    func dialogueBox<Header: View, Buttons: View>(type: DialogueType, frameWidth: CGFloat, settings:OptionDialogueSettings = OptionDialogueSettings(), show: Binding<Bool>, @ViewBuilder header: @escaping ()->Header, @ViewBuilder buttons: @escaping ()-> Buttons)->some View {
        self.modifier(OptionDialogueScene(dialogueType:  type, frameWidth: frameWidth, settings:settings, show: show, header: header, buttons: buttons))
    }
}




