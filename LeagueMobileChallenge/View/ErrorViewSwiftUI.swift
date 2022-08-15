//
//  ErrorViewSwiftUI.swift
//  LeagueMobileChallenge
//
//  Created by André Dias  on 14/08/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import SwiftUI

struct ErrorViewSwiftUI: View {
    
    @ObservedObject var viewModel: HomeViewModel
    var messageError: String
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 60))
                .foregroundColor(.primary)
                .padding()
            
            Text("An error has ocurred")
                .font(.title)
                .foregroundColor(.primary)
                .padding(.top, 16)
            
            Text(messageError)
                .font(.body)
                .foregroundColor(.primary)
                .padding(.bottom, 32)
            
            Button {
                viewModel.inputs.tryAPICallServices()
            } label: {
                Text("Try again")
                    .font(.body)
                    .frame(minWidth: 200)
                    .frame(height: 50, alignment: .center)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                
                
                
            }
        }
        
    }
}

struct ErrorViewSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        ErrorViewSwiftUI(viewModel: HomeViewModel(apiService: APIController()), messageError: APIError.corruptData.localizedDescription)
    }
}
