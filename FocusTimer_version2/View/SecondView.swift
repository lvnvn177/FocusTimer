//
//  SecondView.swift
//  iOS-base-app
//
//  Created by 이영호 on 9/22/24.
//

import SwiftUI

struct SecondView: View {
    @ObservedObject var viewModel: SecondViewModel
    var body: some View {
        Text("SecondView")
    }
}

#Preview {
    SecondView(viewModel: SecondViewModel())
}
