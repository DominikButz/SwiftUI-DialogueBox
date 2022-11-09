//
//  CheckmarkButton.swift
//  
//
//  Created by Dominik Butz on 7/11/2022.
//

import Foundation
import SwiftUI

struct CheckmarkButton: View {
    @ObservedObject var checkmarkItem: CheckmarkOptionItem
    var allCheckmarkItems: [CheckmarkOptionItem]
    @Binding var show: Bool
    var multiSelect:  Bool = false
    var triggerHandler: (()->Void)? = nil
    
    var body: some View {
        
        Button {
            if self.checkmarkItem.enabled {
                self.handleCheckmarkItemTap()
            }
        } label: {
            HStack {
                VStack {
                    Divider()
                
                    HStack {
                        VStack(alignment: .leading) {
                            Text(self.checkmarkItem.title).font(.callout)
                            if self.checkmarkItem.subtitle != nil {
                                Text(self.checkmarkItem.subtitle!).font(.footnote).lineLimit(2).fixedSize(horizontal: false, vertical: true)
                            }
                        }.padding(.leading, 5)
                        Spacer()
                        if checkmarkItem.selected {
                            Image(systemName: "checkmark").transition(AnyTransition.scale)
                        }
                    }.padding(8)
                }
            }.padding(.top, 5)
        }.disabled(self.checkmarkItem.enabled == false).foregroundColor(checkmarkItem.tintColor ?? .accentColor)

           
    }
    
    func handleCheckmarkItemTap() {
            if self.multiSelect == true {
                // with multi select, selection can always be toggled
                toggleSelection()
            } else {
                // single select - only toggle, if selection is false
                if checkmarkItem.selected == false  {
                    // not selected
                   toggleSelection()// set selected
                    // set the other items unselected!
                    for otherItem in self.allCheckmarkItems {
                        if checkmarkItem.id != otherItem.id {
                            withAnimation {
                                otherItem.selected = false
                            }
                          
                        }
                    }
                 
                 
                }
                
            }
        
        triggerHandler?()

            if checkmarkItem.shouldDismiss {
                withAnimation {
                      DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                           self.show = false
                      }
                }
              }
        }
    
    func toggleSelection() {
        withAnimation {
            checkmarkItem.selected.toggle()
        }
    }
    
    

    
}
