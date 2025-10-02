//
//  PriorData.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 10/2/25.
//

import SwiftUI

struct BaserunnerEntry: View {
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.systemGray6))
            
            Image("field")
                .resizable()
                .scaledToFit()
                .padding(10)
        }
        .frame(width: 230, height: 200)
    }
}

