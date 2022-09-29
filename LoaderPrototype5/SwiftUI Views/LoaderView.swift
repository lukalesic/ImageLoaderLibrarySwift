//
//  LoaderView.swift
//  LoaderPrototype5
//
//  Created by Luka Lešić on 15.09.2022..
//

import SwiftUI
import Dispatch
import Foundation

struct LoaderView: View {
    
    private let source: URLRequest
    @State private var image: UIImage?
    
    @Environment(\.imageLoader) private var imageLoader
    
    init(source: URL){
        self.init(source: URLRequest(url: source))
    }
    
    init(source: URLRequest) {
        self.source = source
    }
    
    var body: some View {
        
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                // .scaledToFill()
                    .frame(width: 115, height: 150)
                    .cornerRadius(12.0)
            }
            else {
                ZStack{
                    placeholder()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
        }
        .task {
            await loadImage(at: source)
            print("Image loaded")
        }
    }
    
    func loadImage(at source: URLRequest) async {
        do {
            image = try await imageLoader.loadImage(source)
        } catch {
            print("error in loaderView")
            image = UIImage(systemName: "scribble")!
        }
    }
    
}

struct placeholder: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12.0)
            .frame(width:80, height: 100)
            .foregroundColor(Color.init(hue: 0.0, saturation: 0.0, brightness: 84.0))
    }
}
