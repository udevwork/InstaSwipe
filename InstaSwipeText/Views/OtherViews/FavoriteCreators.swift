//
//  FavoriteCreators.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 23.05.2023.
//

import SwiftUI

struct FavoriteCreatorIconView: View {
    @Environment(\.openURL) var openURL

    var creator: FavoriteCreator
    
    var body: some View {
        AsyncImage(url: URL(string:creator.profileAvatarImageURL)) { phase in
            switch phase {
                case .empty:
                    VStack(alignment: .center) {
                        ProgressView()
                    }.frame(maxWidth: .infinity)
                case .success(let image):
                    VStack {
                        ZStack {
                            image
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .center)
                                .cornerRadius(50)
                                .blur(radius: 14)
                                .brightness(0.2)
                                .contrast(1)
                                .saturation(2)
                            
                            
                            image
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .center)
                                .cornerRadius(50)
                            Text(creator.profileName)
                                .font(.system(size: 14, weight: .regular, design: .rounded))
                                .foregroundColor(.white)
                                .padding(.horizontal,12)
                                .padding(.vertical,4)
                                .background(Material.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
                                .offset(x: 0, y: 50)
                        }
                    }.onTapGesture {
                        if let url = URL(string: creator.profileLink) {
                            openURL(url)
                        }
                    }
                case .failure:
                    EmptyView()
                @unknown default:
                    EmptyView()
            }
        }.frame(height: 150)
      
    }
}


struct FavoriteCreatorsView: View {

    var creators: [FavoriteCreator]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack (spacing: 0) {
                SpacingView(side: .horizontal, size: horPadding)
                ForEach(self.creators, id: \.self) { creator in
                    ZStack {
                        FavoriteCreatorIconView(creator: creator)
                    }
                    SpacingView(side: .horizontal, size: 20)
                }.padding(1)
                
            }
        }
    }
}

struct FavoriteCreators_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCreatorsView(creators: [])
    }
}
