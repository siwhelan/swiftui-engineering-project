//
//  likeButton.swift
//  MobileAcebook
//
//  Created by Amy McCann on 22/02/2024.
//

import Foundation
import Foundation
import SwiftUI


struct LikeButton : View {
    @ObservedObject private var postsModel = PostsView()
    @State var isPressed: Bool
    var postId: String
    
    var body: some View {
        ZStack {
            Image(systemName: "heart.fill")
                .opacity(isPressed ? 1 : 0)
                .scaleEffect(isPressed ? 1.0 : 0.1)
            Image(systemName: "heart")
                .shadow(color: .black, radius: 1)
        }.font(.system(size: 40))
            .onTapGesture {
                isPressed.toggle()
                postsModel.likePost(postId: postId)

        }
        .foregroundColor(isPressed ? .red : .white)
    }
}

//struct LikeButton_Previews: PreviewProvider {
//    static var previews: some View {
//        LikeButton()
//    }
//}
