//
//  SplashView.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 10/03/26.
//

import SwiftUI

struct SplashView: View {
    @StateObject var viewModel: SplashViewModel
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            Text("Sequis Picsum")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
        }
        .onAppear {
            viewModel.start()
        }
    }
}

#Preview {
    SplashView(viewModel: SplashViewModel())
}
