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

    var titleName: UILabel = {
        let name = UILabel()
        name.numberOfLines = 0
        name.text = "Placeholder text"
        name.font = name.font.withSize(23)

        return name
    }()
    
    var container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemMint
        view.clipsToBounds = true
        return view
    }()
    
    var coverPhoto: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemBlue
      //  image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
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
        contentView.addSubview(titleName)
        contentView.addSubview(container)
        setPhotoConstraints()
        setTitleConstraints()
    }
    
    private func setPhotoConstraints(){
        container.configureForAutoLayout()
        container.autoSetDimensions(to: CGSize(width: 120, height: 120))
        container.autoPinEdges(toSuperviewMarginsExcludingEdge: .right)
        
        container.addSubview(coverPhoto)
        coverPhoto.configureForAutoLayout()
        coverPhoto.autoCenterInSuperview()
        coverPhoto.autoMatch(.height, to: .height, of: container)
        coverPhoto.autoMatch(.width, to: .width, of: container)
    }
    
    private func setTitleConstraints(){
        titleName.configureForAutoLayout()
        titleName.autoPinEdge(.left, to: .right, of: container, withOffset: 10)
        titleName.autoPinEdge(toSuperviewEdge: .right, withInset: 20.0)
        titleName.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
    
    func loadImageFromServer(comic: Comic?, imageView: UIImageView) {
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
    

    func setComicData(comic: Comic?){
        titleName.text = comic?.title
        loadImageFromServer(comic: comic, imageView: coverPhoto)
    }
    
}
