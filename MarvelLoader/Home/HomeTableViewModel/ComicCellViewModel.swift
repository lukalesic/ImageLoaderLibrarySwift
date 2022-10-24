//
//  ComicCellViewModel.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 23.10.2022..
//

import Foundation
import UIKit
import Combine

class ComicCellViewModel: ObservableObject {
    
     var photoURL: URL?
     var comic: Comic?
     @Published var comicTitleLabel: String?
     var comicImageView = UIImageView()
    
    func generateURL(comic: Comic?) -> URL? {
        let path = comic?.thumbnail?.path ?? ""
        let ext = comic?.thumbnail?.ext ?? ""
        let imagePath = path + "." + ext
        photoURL = URL(string: imagePath)!
        return photoURL

    }
   
    func setTitle(comic: Comic?) {
            self.comicTitleLabel = comic?.title
    }
    
    func generateTitle(comic: Comic?) -> String? {
        return comic?.title ?? ""
    }
    
    func configureImageView(comicImageView: UIImageView) {
        comicImageView.layer.cornerRadius = 10
        comicImageView.clipsToBounds = true
    }
    
    func configureTitleLabel(comicTitleLabel: UILabel){
        comicTitleLabel.numberOfLines = 0
    }

    func setImageConstraints(comicImageView: UIImageView){
        comicImageView.configureForAutoLayout()
        comicImageView.autoSetDimension(.width, toSize: 80)
        comicImageView.autoPinEdges(toSuperviewMarginsExcludingEdge: .right)
    }
    
    func setTitleLabelConstraints(comicTitleLabel: UILabel, comicImageView: UIImageView){
        comicTitleLabel.configureForAutoLayout()
        comicTitleLabel.autoPinEdge(.left, to: .right, of: comicImageView, withOffset: 10)
        comicTitleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 20.0)
        comicTitleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
}
