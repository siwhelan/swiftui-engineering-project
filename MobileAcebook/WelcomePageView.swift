//
//  WelcomePageView.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 30/09/2023.
//

import SwiftUI

struct WelcomePageView: View {
    var body: some View {
        NavigationView{
            ZStack {
                
                VStack {

                    
                    //Spacer()
                    

                    Image("Acebook-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 400)
                        .accessibilityIdentifier("makers-logo")

                    
                    Spacer()
                    
                    NavigationLink(destination: SignUpPageView())
                    { Text("Sign Up") }
                        .accessibilityIdentifier("signUpButton")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.black)
                        .cornerRadius(15.0)
                        .accessibilityIdentifier("loginButton")
                    
                    NavigationLink(destination: LoginPageView()){
                        Text("Login")
                    }
                    .accessibilityIdentifier("loginButton")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.black)
                    .cornerRadius(15.0)
                    .accessibilityIdentifier("loginButton")
                    
                    Spacer()
                    
                }
            }
        }
    }
}

struct WelcomePageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePageView()
    }
}
