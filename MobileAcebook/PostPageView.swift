//
//  PostPageView.swift
//  MobileAcebook
//
//  Created by Si on 21/02/2024.
//

import Foundation
import SwiftUI


// When you scroll, SwiftUI reuses views for efficiency, 
// and the .onAppear() modifier is called each time a view comes into view.
// Since postOwnerModel is a shared instance across all list items, updating it in
//  .onAppear for one post causes all visible post views to update their postOwner to the last fetched user.

// Fix :

// Assign each post it's username directly first
struct PostView: View {
    let post: Post
    @ObservedObject var postOwnerModel: PostUser = PostUser() // name tag for the post.
    
    init(post: Post) {
        self.post = post
        // when we create the name tag, we write the name of the post's author on it.
        self.postOwnerModel.fetchPostUser(userId: post.createdBy)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(post.message) // The content of the post.
                .font(.body) // Ensure post content has a standard readable size
            
            HStack {
                Text(postOwnerModel.postOwner?.username ?? "Loading...")
                    .font(.caption) // Make the username slightly smaller
                    .foregroundColor(.gray) // Make the username greyer to differentiate
                Spacer()
                Text(convertDateFormat(inputDate: post.createdAt))
                    .font(.caption)
                    .foregroundColor(.secondary) // make the timestamp match the username style
            }
        }
    }
}



// This is the view where all posts are
struct PostPageView: View {
    @ObservedObject private var postModel = PostsView()
    @ObservedObject private var loggedinUserModel = LoggedInUser()

    var body: some View {
        VStack {
            Text("Posts Feed")
                .font(.title)
                .fontWeight(.bold)
            List(postModel.posts) { post in
                HStack {
                    VStack(alignment: .leading) {
                        //Text(post.message) // The content of the post
                        
                        // Use PostView for displaying post details like username and timestamp
                        PostView(post: post)
                    }
                    
                    Spacer() // Pushes content to the left and LikeButton to the right
                    
                    // Conditionally display the LikeButton based on whether the post is liked
                    if post.likes.contains(loggedinUserModel.user?._id ?? "") {
                        LikeButton(isPressed: true, postId: post._id)
                            .scaleEffect(0.8) // Make the button slightly smaller
                            .padding(.trailing, 8) // Adjust padding for positioning
                    } else {
                        LikeButton(isPressed: false, postId: post._id)
                            .scaleEffect(0.8) // Make the button slightly smaller
                            .padding(.trailing, 8) // Adjust padding for positioning
                    }
                }
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
