//
//  PriorData.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 10/2/25.
//

import SwiftUI

struct ButtonRow<T: ButtonRowDisplayable>: View {
    @Binding var selectedValue: T?
    var activeColor: Color = .blue
    var inactiveColor: Color = .clear
    var textColor: Color = .blue

    var body: some View {
        HStack(spacing: 4) {
            // T.allCases is available because T conforms to CaseIterable
            ForEach(Array(T.allCases), id: \.self) { item in
                Button(action: {
                    selectedValue = item
                }) {
                    Text(item.abbreviation)
                        .font(.system(.subheadline, design: .monospaced))
                        .fontWeight(.bold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 8)
                        .foregroundColor(selectedValue == item ? .white : textColor)
                        .background(selectedValue == item ? activeColor : inactiveColor)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(textColor, lineWidth: 1)
                        )
                }
            }
        }
    }
}
