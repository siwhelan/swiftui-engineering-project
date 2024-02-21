//
//  PostPageView.swift
//  MobileAcebook
//
//  Created by Si on 21/02/2024.
//

import Foundation
import SwiftUI

struct PostPageView: View {
    @ObservedObject var postModel = PostsView()

    var body: some View {
        VStack {
            Text("Posts Page").font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            List(postModel.posts) { post in
                Text(post.message)
            }
            .onAppear {
                postModel.fetchPosts()
            }
        }
    }
}

struct PostPageView_Previews: PreviewProvider {
    static var previews: some View {
        PostPageView()
    }
}

