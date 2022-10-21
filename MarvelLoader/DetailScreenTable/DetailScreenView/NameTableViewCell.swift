//
//  NameTableViewCell.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 12.10.2022..
//

import UIKit
import PureLayout

class NameTableViewCell: UITableViewCell, ImageDownloading {
    let loader = Loader()
    var NameTableViewModel = NameTableCellViewModel()
    
    var titleName = UILabel()
    var container = UIView()
    var coverPhoto = UIImageView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        displayLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func displayLayout(){
        titleName = NameTableViewModel.setupTitle(titleName)
        container = NameTableViewModel.setupContainer(container)
        coverPhoto = NameTableViewModel.setupCoverPhoto(coverPhoto)
        
        contentView.addSubview(titleName)
        contentView.addSubview(container)
        
        NameTableViewModel.setPhotoConstraints(container: container, coverPhoto: coverPhoto)
        NameTableViewModel.setTitleConstraints(container: container, titleName: titleName)
    }
    
    func loadImageFromServer(comic: Comic?, imageView: UIImageView) {
        Task {
            do{
                let url = NameTableViewModel.generateURL(comic: comic)!
                let downloadedImage = try await loader.loadImage(url: url)
                imageView.image = downloadedImage as! UIImage
            }
            catch{
                print("error")
            }
        }
    }

    func setComicData(comic: Comic?){
        // ovo prvo u viewmodel def, izbaciti  ikakvu comic funckionalnost
        titleName.text = comic?.title
        loadImageFromServer(comic: comic, imageView: coverPhoto)
    }
    
}
