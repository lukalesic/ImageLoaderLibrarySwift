//
//  ComicCell.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 05.10.2022..
//

import UIKit

class ComicCell: UITableViewCell, ImageDownloading {
    
    let loader = Loader()
    var comicImageView = UIImageView()
    var comicTitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(comicImageView)
        addSubview(comicTitleLabel)
        
        configureImageView()
        configureTitleLabel()
        setImageConstraints()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImageFromServer(comic: Comic?, imageView: UIImageView){
        guard let path = comic?.thumbnail?.path, let ext = comic?.thumbnail?.ext else {return}
        let imagePath = path + "." + ext
        let imageURL = URL(string: imagePath)!
        
        Task {
            do{
               let downloadedImage = try await loader.loadImage(url: imageURL)
                imageView.image = downloadedImage as! UIImage
            }
            catch{
                print("error")
            }
        }
        
    }
    
    func setData(comicBookModel: Comic?){
        comicTitleLabel.text = comicBookModel?.title
        loadImageFromServer(comic: comicBookModel, imageView: comicImageView)
    }
    
    func configureImageView() {
        comicImageView.layer.cornerRadius = 10
        comicImageView.clipsToBounds = true
        
    }
    
    func configureTitleLabel(){
        comicTitleLabel.numberOfLines = 0
        comicTitleLabel.adjustsFontSizeToFitWidth = true
    }

    func setImageConstraints(){
        comicImageView.translatesAutoresizingMaskIntoConstraints = false
        comicImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        comicImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        comicImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
      //  comicImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        comicImageView.widthAnchor.constraint(equalTo: comicImageView.heightAnchor, multiplier: 4/4).isActive = true
    }
    
    func setTitleLabelConstraints(){
        comicTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        comicTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        comicTitleLabel.leadingAnchor.constraint(equalTo: comicImageView.trailingAnchor, constant: 20).isActive = true
        comicTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        comicTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
}


