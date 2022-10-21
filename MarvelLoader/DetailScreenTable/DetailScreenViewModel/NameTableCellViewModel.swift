//
//  NameTableCellViewModel.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 21.10.2022..
//

import Foundation
import UIKit

class NameTableCellViewModel {
    
    @Published var photoURL: URL?
    @Published var comics: Comic?
    
    func setupTitle(_ title: UILabel) -> UILabel {
        title.numberOfLines = 0
        title.text = "Placeholder text"
        title.font = title.font.withSize(23)
        return title
    }
    
    func setupContainer(_ view: UIView) -> UIView {
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemMint
        view.clipsToBounds = true
        return view
    }
    
    func setupCoverPhoto(_ image: UIImageView) -> UIImageView {
        image.backgroundColor = .systemBlue
        return image
    }

    
     func setPhotoConstraints(container: UIView, coverPhoto: UIImageView){
        container.configureForAutoLayout()
        container.autoSetDimensions(to: CGSize(width: 120, height: 120))
        container.autoPinEdges(toSuperviewMarginsExcludingEdge: .right)
        
        container.addSubview(coverPhoto)
        coverPhoto.configureForAutoLayout()
        coverPhoto.autoMatch(.height, to: .height, of: container)
        coverPhoto.autoMatch(.width, to: .width, of: container)
    }
    
     func setTitleConstraints(container: UIView, titleName: UILabel){
        titleName.configureForAutoLayout()
        titleName.autoPinEdge(.left, to: .right, of: container, withOffset: 10)
        titleName.autoPinEdge(toSuperviewEdge: .right, withInset: 20.0)
        titleName.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
    
    func generateURL(comic: Comic?) -> URL? {
       guard let path = comic?.thumbnail?.path, let ext = comic?.thumbnail?.ext else {return nil}
       let imagePath = path + "." + ext
       photoURL = URL(string: imagePath)!
       return photoURL
    }
    
    
}
