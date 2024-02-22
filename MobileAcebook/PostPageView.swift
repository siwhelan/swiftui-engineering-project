//
//  PostPageView.swift
//  MobileAcebook
//
//  Created by Si on 21/02/2024.
//

import Foundation
import SwiftUI

struct PostPageView: View {
    @ObservedObject private var postModel = PostsView()
    @ObservedObject private var postOwnerModel = PostUser()
    @ObservedObject private var loggedinUserModel = LoggedInUser()
    
    @State var isPressed = false
    
    var body: some View {
        VStack {
            Text("Posts Feed")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            List(postModel.posts) { post in
                Text(post.message)
                HStack{
                    if post.likes.contains(loggedinUserModel.user?._id ?? "") {
                        LikeButton(isPressed: true, postId: post._id)
                    } else {
                        LikeButton(isPressed: false, postId: post._id)
                    }
                    Text(postOwnerModel.postOwner?.username ?? "")
                        .font(.footnote)
                        .onAppear{postOwnerModel.fetchPostUser(userId: post.createdBy)}
                    Spacer()
                    Text(convertDateFormat(inputDate:
                                            post.createdAt))
                }                           .font(.footnote)
            }
        }
            .onAppear {
                postModel.fetchPosts()
                loggedinUserModel.fetchUser()
            }
        }
    }

struct PostPageView_Previews: PreviewProvider {
    static var previews: some View {
        PostPageView()
    }
}
