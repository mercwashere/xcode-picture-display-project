//
//  ContentView.swift
//  my-very-cool-app
//
//  Created by Ambika   on 19/02/2026.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    var body: some View {
        VStack { //just stacks whats in the brackets one above each other
            TabView{ //this is the bit at the bottom of an app that has the home page, account etc. the way it works is by pushing/hiding adjacent tabs
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                        
                SearchView()//click the little square at the top of the sim to switch between tabs
                    .tabItem{
                        Label("Search", systemImage: "magnifyingglass")
                    }
                

            }
        }
 
    }
    
    struct HomeView: View {
        @State private var selectedPhoto: PhotosPickerItem? //refresh the page whenever a change is seen here, but be aware that PhotosPicker might not exist
        @State var photo: Image?
        
        var body: some View{
            VStack{
                PhotosPicker("select a photo", selection: $selectedPhoto) //dollar sign says this links to the state object above with the same name
                   
            
                if let photo = photo { //if there is a photo
                    photo
                        .resizable() //resize
                        .scaledToFit() //keep aspect ratio
                        .clipShape(.rect(cornerRadius: 20)) //give rectangle cornered edges
                        .frame(width:300,height:300)
                    
                }
                    
            }
            .onChange(of:selectedPhoto){_,_ in
                onPhotoSelected() //when a photo is selected, run the function to display it
            }
            
        //without the following code, the photo you pick just gets stored in the selectedPhoto variable but not displayed anywhere
        }
        func onPhotoSelected() {
                Task {
                    if let loadedImage = try? await selectedPhoto?.loadTransferable(type: Image.self) {
                        photo = loadedImage
                    }
                }
            }
    }
    
    struct SearchView: View {
        var body: some View{
            Text("This is the Search Page")
        }
    }

}


#Preview {
    ContentView()
}

//on a personal mac, you can plug in your phone and run the app on your phone directly 
