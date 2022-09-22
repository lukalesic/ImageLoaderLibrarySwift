//
//  LoaderView.swift
//  LoaderPrototype5
//
//  Created by Luka Lešić on 15.09.2022..
//


/*
 let alert =  UIAlertController(title: "Alert", message: "No internet connection", preferredStyle: .alert)
 alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
 NSLog("The \"OK\" alert occured.")
 }))
 
 self.present(alert, animated: true, completion: nil)
 
 */

import SwiftUI

struct LoaderView: View {
    
    private let dispatchGroup = DispatchGroup()
    let semaphore = DispatchSemaphore(value: 3)
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
            print(error)
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
