//
//  PriorData.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 10/2/25.
//

import SwiftUI

struct BaserunnerEntry: View {
    
    var body: some View {
        VStack {
            Image("field")
                .resizable()
                .scaledToFit()
                .padding(10)
        }
        .frame(width: 230, height: 210)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 0)
        )
    }
}

