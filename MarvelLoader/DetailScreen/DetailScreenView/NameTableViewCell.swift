//
//  NameTableViewCell.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 12.10.2022..
//

import UIKit
import PureLayout

class NameTableViewCell: UITableViewCell {
    let loader = Loader()
    
    var titleLabel = UILabel()
    
    func configureTitleLabel(){
        titleLabel.numberOfLines = 0
        titleLabel.font = titleLabel.font.withSize(23)
    }
    
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(container)
        configureTitleLabel()
        setPhotoConstraints()
        setTitleConstraints()
    }
    
    func updateWith(viewModel: NameTableCellViewModel) {
        loadImageFromServer(url: viewModel.photoURL!)
        titleLabel.text = viewModel.title
    }
    
    func loadImageFromServer(url: URL) {
        Task {
            do{
                let downloadedImage = try await loader.loadImage(url: url)
                self.coverPhoto.image = downloadedImage
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
       titleLabel.configureForAutoLayout()
        titleLabel.autoPinEdge(.left, to: .right, of: container, withOffset: 10)
        titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 20.0)
        titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
   }
    
}
