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
            
            HStack {
                Text(postOwnerModel.postOwner?.username ?? "Loading...") // The name on the name tag.
                Spacer()
                Text(convertDateFormat(inputDate: post.createdAt))
            }
        }
    }
}



// This is the view where all posts are
struct PostPageView: View {
    @ObservedObject var postModel = PostsView() // This holds all the posts.
    
    var body: some View {
        VStack {
            Text("Posts Feed")
                .font(.title)
                .fontWeight(.bold)
            List(postModel.posts) { post in
                PostView(post: post) // Here we add each post with its name tag on the view.
            }
        }
        .onAppear {
            postModel.fetchPosts() // load the full collection at once
        }
    }
}

struct PostPageView_Previews: PreviewProvider {
    static var previews: some View {
        PostPageView()
    }
}
