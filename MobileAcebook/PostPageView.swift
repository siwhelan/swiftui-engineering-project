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
    @ObservedObject var postOwnerModel = PostUser()
    var body: some View {
        VStack {
            Text("Posts Feed")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            List(postModel.posts) { post in
                Text(post.message)
                
                HStack{
                    Text(postOwnerModel.postOwner?.username ?? "")
                        .font(.footnote)
                        .onAppear(){
                            postOwnerModel.fetchPostUser(userId: post.createdBy)
                        }
                    Spacer()
                    Text(convertDateFormat(inputDate:
                                            post.createdAt))
                }                           .font(.footnote)
            }
        }
            .onAppear {
                postModel.fetchPosts()
            }
        }
    }

struct PostPageView_Previews: PreviewProvider {
    static var previews: some View {
        PostPageView()
    }
}
