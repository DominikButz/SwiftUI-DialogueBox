//
//  SwiftUIView.swift
//  
//
//  Created by Dominik Butz on 8/11/2022.
//

import SwiftUI

public struct OptionDialogueDefaultHeader: View {

    
    let title: String
    let message: String?
    
    public init(title: String, message: String? = nil) {
        self.title = title
        self.message = message
    }
    
    public var body: some View {
        VStack(spacing: 5) {
            Text(title).font(.headline)
            if let message = message {
                Text(message).font(.footnote).italic()
            }
        }.padding()
    }
}

struct OptionDialogueDefaultHeader_Previews: PreviewProvider {
    static var previews: some View {
        OptionDialogueDefaultHeader(title: "Test", message: "Test message")
    }
}
