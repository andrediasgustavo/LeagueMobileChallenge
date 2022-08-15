//
//  ContentCellSwiftUI.swift
//  LeagueMobileChallenge
//
//  Created by André Dias  on 14/08/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import SwiftUI
import Kingfisher

struct ContentCellSwiftUI: View {
    
    var homeModel: HomeModel

    var body: some View {
        VStack {
            HStack {
                KFImage(URL(string: self.homeModel.avatar))
                    .resizable()
                    .fade(duration: 0.25)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 48, height: 48)
                   
                Text(homeModel.username)
                    .font(.title)
                    .foregroundColor(.primary)
                    .padding(.leading, 8)
                
                Spacer()
            }
            .padding(.leading, 8)
            .padding(.bottom, 8)
            HStack {
                VStack(alignment: .leading) {
                    Text(self.homeModel.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.bottom, 6)
                        .padding(.leading, 8)
                
                    Text(self.homeModel.body)
                        .font(.body)
                        .foregroundColor(.primary)
                        .padding(.leading, 8)
                }
                
                Spacer()
            }
          
        }
        .padding(8)
        .background(Color(UIColor.systemBackground))
    }
}

struct ContentCellSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        ContentCellSwiftUI(homeModel: HomeModel(userId: 1, postId: 1, avatar: "https://i.pravatar.cc/150?u=Rey.Padberg@karina.biz", name: "Clementina DuBuque", username: "Moriah.Stanton", title: "temporibus sit alias delectus eligendi possimus magni", body: "quo deleniti praesentium dicta non quod\naut est molestias\nmolestias et officia quis nihil\nitaque dolorem quia"))
            .preferredColorScheme(.light)
    }
}
