//
//  ComicCell.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 05.10.2022..
//


import UIKit
import PureLayout

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
        comicImageView.configureForAutoLayout()
        comicImageView.autoSetDimensions(to: CGSize(width: 80, height: 80))
        comicImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 20.0)
        comicImageView.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
    
    func setTitleLabelConstraints(){
        comicTitleLabel.configureForAutoLayout()
        comicTitleLabel.autoPinEdge(.left, to: .right, of: comicImageView, withOffset: 10)
        comicTitleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 20.0)
        comicTitleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
    
}


