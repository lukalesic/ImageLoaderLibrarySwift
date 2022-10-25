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
    
    func loadImageFromServer(comic: Comic?, imageView: UIImageView) {
        Task {
            do{
                let url = NameTableViewModel.generateURL(comic: comic)!
                let downloadedImage = try await loader.loadImage(url: url)
                imageView.image = downloadedImage 
            }
            catch{
                print("error")
            }
        }
    }

    func setPhotoConstraints(){
       container.configureForAutoLayout()
       container.autoSetDimensions(to: CGSize(width: 120, height: 120))
       container.autoPinEdges(toSuperviewMarginsExcludingEdge: .right)
       
       container.addSubview(coverPhoto)
       coverPhoto.configureForAutoLayout()
       coverPhoto.autoMatch(.height, to: .height, of: container)
       coverPhoto.autoMatch(.width, to: .width, of: container)
   }
   
    func setTitleConstraints(){
       titleName.configureForAutoLayout()
       titleName.autoPinEdge(.left, to: .right, of: container, withOffset: 10)
       titleName.autoPinEdge(toSuperviewEdge: .right, withInset: 20.0)
       titleName.autoAlignAxis(toSuperviewAxis: .horizontal)
   }
    
    func setComicData(comic: Comic?){
        titleName.text = comic?.title
        loadImageFromServer(comic: comic, imageView: coverPhoto)
    }
    
}
