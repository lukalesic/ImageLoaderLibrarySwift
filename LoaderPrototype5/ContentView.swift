//
//  ContentView.swift
//  LoaderPrototype5
//
//  Created by Luka Lešić on 15.09.2022..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Loader")
                        }.tag("home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
