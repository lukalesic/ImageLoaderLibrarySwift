//
//  HomeView.swift
//  LoaderPrototype5
//
//  Created by Luka Lešić on 15.09.2022..
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            let dispatchGroup = DispatchGroup()
            let queue = DispatchQueue.global(qos: .background)
            let dispatchSemaphore = DispatchSemaphore(value: 4)
            
            let columns = [
                    GridItem(.flexible(), spacing: 14),
                    GridItem(.flexible(), spacing: 14),
                    GridItem(.flexible(), spacing: 14)]
            
            let posters = [
                "https://image.tmdb.org/t/p/original//pThyQovXQrw2m0s9x82twj48Jq4.jpg",
                "https://image.tmdb.org/t/p/original//vqzNJRH4YyquRiWxCCOH0aXggHI.jpg",
                "https://image.tmdb.org/t/p/original//vqzNJRH4YyquRiWxCCOH0aXggHI.jpg",
                "https://source.unsplash.com/random/900x900",
                "https://source.unsplash.com/random/300x300",
                "https://source.unsplash.com/random/400x400",
                "https://source.unsplash.com/random/500x500",
                "https://source.unsplash.com/random/501x501",
                "https://source.unsplash.com/random/502x502",
                "https://source.unsplash.com/random/502x502",
                "https://source.unsplash.com/random/503x503",
                "https://source.unsplash.com/random/505x505",
                "https://source.unsplash.com/random/506x506",
            ].map { URL(string: $0)! }
           
     
            ScrollView{
               
                LazyVGrid(columns: columns, spacing: 3){
                   
                    ForEach(0..<posters.count){posterIndex in
                        
                        
                        LoaderView(source: posters[posterIndex])
                            .padding(3)
                    }
                }.padding()
            }.navigationTitle("Loader")
        }
    }
}
