//
//  PriorData.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 10/2/25.
//

import SwiftUI

struct BaserunnerColumn: View {
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(1...4, id: \.self) { index in
                BaserunnerEntry()
            }
        }
        .padding(.bottom)
    }
}

