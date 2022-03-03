//
//  ContentView.swift
//  FurryFriends
//
//  Created by Russell Gordon on 2022-02-26.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Stored properties
    
    // Address for main image
    // Starts as a transparent pixel – until an address for an animal's image is set
    @State var currentImage = URL(string: "https://www.russellgordon.ca/lcs/miscellaneous/transparent-pixel.png")!
    
    
    
    
    
    // MARK: Computed properties
    var body: some View {
        
        VStack {
            
            
            // Shows the main image
            RemoteImageView(fromURL: currentImage)
            
            // Push main image to top of screen
            Spacer()
            
        }
        // Runs once when the app is opened
        .task {
            
            
            // Example images for dog
            let remoteDogImage = "https://dog.ceo/api/breeds/image/random"
            // Replaces the transparent pixel image with an actual image of an animal
            // Adjust according to your preference ☺️
          
            currentImage = URL(string: remoteDogImage)!
            print("Attempted to display image")
        }
        .navigationTitle("Furry Friends")
        
    }
    
   
    
    
    
    
    // MARK: Functions
    
    func loadNewDogImage() async {
        
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        
        var request = URLRequest(url: url)
        // Ask for JSON data
        request.setValue("application/json",
                         forHTTPHeaderField: "Accept")
        
        // Start a session to interact (talk with) the endpoint
        let urlSession = URLSession.shared
        
        // Try to fetch a new image
        // It might not work, so we use a do-catch block
        do {
            
            // Get the raw data from the endpoint
            let (data, _) = try await urlSession.data(for: request)
            
            // Attempt to decode the raw data into a Swift structure
            // Takes what is in "data" and tries to put it into "currentImage"
            //                                 DATA TYPE TO DECODE TO
            //                                         |
            //                                         V
            currentImage = try JSONDecoder().decode(Dog.self, from: data)
            
            
            
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView {
                ContentView()
            }
        }
    }
}
