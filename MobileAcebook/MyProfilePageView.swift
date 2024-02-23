//
//  MyProfilePageView.swift
//  MobileAcebook
//
//  Created by Amy McCann on 19/02/2024.
//

import Foundation
import SwiftUI

struct MyProfilePageView: View {
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @ObservedObject private var postsModel = PostsView()
    @ObservedObject private var loggedinUserModel = LoggedInUser()
    @ObservedObject private var postOwnerModel = PostUser()
    
    var body: some View {
        ZStack {
            VStack {
                
                Text("My Profile")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(.black)
                    .cornerRadius(20.0)
                    .accessibilityIdentifier("titleText")
                    .padding()
                
                if let avatarImage = UIImage(named: "default_avatar.png") {
                    Image(uiImage: avatarImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .accessibilityIdentifier("profile-picture")
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .foregroundColor(.gray)
                    }
                
                
                    Spacer()
                    LazyVGrid(columns: layout, alignment: .leading, content: {
                        Text("Username:").font(.headline)
                        Text(loggedinUserModel.user?.username ?? "")
                        Text("Email:").font(.headline)
                        Text(loggedinUserModel.user?.email ?? "")
                        Text("Bio: ").font(.headline)
                        Text("Software Engineer").font(.subheadline)
                    })
                    .padding(.horizontal)
                    .onAppear {
                        loggedinUserModel.fetchUser()
                    }
                    .padding()
                    
                
                Spacer()
//                Text("Posts")
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .foregroundColor(.black)
//                    .padding()
//                    .frame(width: 100, height: 35)
//
//                    .accessibilityIdentifier("titleText")
                List{
                    ForEach(postsModel.posts) {post in
                        if post.createdBy == loggedinUserModel.user?._id {
                            ScrollView {
                                VStack(alignment: .leading) {
                                    Text(post.message)
                                    Spacer()
                                    HStack{
                                        Text(postOwnerModel.postOwner?.username ?? "").font(.footnote).onAppear{postOwnerModel.fetchPostUser(userId: post.createdBy)}
                                        Spacer()
                                        Text(convertDateFormat(inputDate: post.createdAt)).font(.footnote)
                                    }
                                    
                                }
                            }
                        }
                        
                    }
                }
                .onAppear {

                        postsModel.fetchPosts()
                    
                    }

                }
            }
        }
    }

    

struct MyProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfilePageView()
    }
}

