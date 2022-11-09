//
//  Example2.swift
//  
//
//  Created by Dominik Butz on 31/10/2022.
//

import Foundation
import SwiftUI

public struct CheckmarkExample:View  {
    @Environment(\.colorScheme) var colorScheme
    @StateObject  var viewModel = CheckmarkItemsViewModel()
    
   public init() {}
    
    public var body: some View {
        
        GeometryReader { proxy in
            VStack {
                VStack {
                    Picker(selection: $viewModel.dialogueBoxType, label: Text("Dialogue Type")) {
                        Text("Alert").tag(DialogueType.alert)
                        Text("Sheet").tag(DialogueType.sheet)
                    }.pickerStyle(WheelPickerStyle())
                    
                    Picker(selection: $viewModel.backgroundEffect, label: Text("Background Effect")) {
                        Text("Dim").tag(BackgroundEffect.dim)
                        Text("Blur").tag(BackgroundEffect.blur)
                        Text("None").tag(BackgroundEffect.none)
                    }.pickerStyle(WheelPickerStyle())
                    
                    Toggle("Checkmark Multi-Select", isOn: $viewModel.multiSelect).padding()
                    
                }
                Spacer()
                Divider()
 
                    Button(action: {
                        self.viewModel.showCheckmarkDialogue = true
                    }) {
                        Text("Show Checkmark Dialogue")
                    }.padding()
                
                Spacer()
            }

            .dialogueBox(type: viewModel.dialogueBoxType, frameWidth: viewModel.dialogueBoxType == .alert ?  min(proxy.size.width * 0.75, 300) : min(400, proxy.size.width),  settings: OptionDialogueSettings(backgroundEffect: viewModel.backgroundEffect, boxShadow: shadow, dismissOnBackgroundTap: self.viewModel.dialogueBoxType == .sheet), show: $viewModel.showCheckmarkDialogue, header: {
                OptionDialogueDefaultHeader(title: "Checkmark Dialogue", message: "Select at least one option")
            }) {

                dialogueBoxContent


            }
            .onChange(of: self.viewModel.multiSelect) { _ in
                self.viewModel.createCheckmarkItems()
            }
            
               
        }
 
    }
    
    var shadow: Shadow {
        let color = colorScheme == .light ? Color.gray.opacity(0.4) : Color.clear
        let offsetX: CGFloat = self.viewModel.dialogueBoxType == .alert ? -5 : 0
        return Shadow(color: color, radius: 5, x: offsetX, y: -5)

    }
    
    @ViewBuilder public var dialogueBoxContent: some View {

        ForEach(viewModel.checkmarkItems) { item in
                
            CheckmarkButton(checkmarkItem: item, allCheckmarkItems: self.viewModel.checkmarkItems, show:  $viewModel.showCheckmarkDialogue, multiSelect: viewModel.multiSelect) {
                self.viewModel.updateMultiSelectOKButtonState()
            }
           
        }
        if viewModel.multiSelect {
            OptionButton(title: "OK", subtitle: nil, image: nil , triggerHandler: nil, shouldDismiss: true, enabled: $viewModel.multiSelectOKButtonEnabled, show: $viewModel.showCheckmarkDialogue)
            
            
            OptionButton(title: "Cancel", subtitle: nil, accentColor: .red, image: nil,  triggerHandler: nil, shouldDismiss: true, enabled: .constant(true), show: $viewModel.showCheckmarkDialogue)
              
        }
        
       
    }
    

    


}


struct CheckmarkExample_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkExample()
    }
}

 class CheckmarkItemsViewModel: ObservableObject {
    
    @Published var showCheckmarkDialogue: Bool = false
    
    @Published var dialogueBoxType: DialogueType = .alert
    @Published var backgroundEffect: BackgroundEffect = .dim
    @Published var multiSelect: Bool = false
    
    @Published var multiSelectOKButtonEnabled: Bool = false
    @Published var checkmarkItems: [CheckmarkOptionItem] = []
    
    public init() {
        createCheckmarkItems()
    }
    
    func createCheckmarkItems() {
        self.checkmarkItems =  [CheckmarkOptionItem(title: "First Option", subtitle: "1st Subtitle", shouldDismiss: multiSelect == false, selected: true, enabled: true),
                      CheckmarkOptionItem(title: "Second Option", subtitle: "2nd Subtitle", shouldDismiss: multiSelect == false, selected: false, enabled: true),
                      CheckmarkOptionItem(title: "Third Option", subtitle: "2nd Subtitle", shouldDismiss: multiSelect == false, selected: false, enabled: true)
            ]
      
        self.updateMultiSelectOKButtonState()
        
    }
    
    func updateMultiSelectOKButtonState() {
        var enabled = false
        for item in self.checkmarkItems {
            if item.selected {
                enabled = true
            }
        }
        self.multiSelectOKButtonEnabled = enabled
    }
}
