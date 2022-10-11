//
//  ComicCell.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 05.10.2022..
//

import UIKit
import SDWebImage

class ComicCell: UITableViewCell {
    
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
    
    func setData(comicBookModel: ComicBookModel?){
        comicTitleLabel.text = comicBookModel?.title
        
        let request = URL(string: generatedURL)!
        
        guard let path = comicBookModel?.thumbnail?.path, let ext = comicBookModel?.thumbnail?.ext else {return}
        let imagePath = path + "." + ext
        let imageURL = URL(string: imagePath)!
        
           comicImageView.sd_setImage(with: URL(string: imagePath), placeholderImage: nil, options: .continueInBackground) { (image, error, cache, url) in
        }

  
        
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
        comicImageView.widthAnchor.constraint(equalTo: comicImageView.heightAnchor, multiplier: 16/9).isActive = true
    }
    
    func setTitleLabelConstraints(){
        comicTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        comicTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        comicTitleLabel.leadingAnchor.constraint(equalTo: comicImageView.trailingAnchor, constant: 20).isActive = true
        comicTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        comicTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
}
