//
//  ComicCell.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 05.10.2022..
//

import UIKit
import PureLayout

class ComicCell: UITableViewCell {
    
    private var comicImageView = UIImageView()
    private var titleLabel = UILabel()
    let loader = Loader()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(comicImageView)
        contentView.addSubview(titleLabel)
        
        configureImageView()
        configureTitleLabel()
        setImageConstraints()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateWith(viewModel: ComicCellViewModel) {
        loadImageFromServer(url: viewModel.photoURL!)
        titleLabel.text = viewModel.title
    }
    
    
    func loadImageFromServer(url: URL) {
        Task {
            do{
                let downloadedImage = try await loader.loadImage(url: url)
                self.comicImageView.image = downloadedImage
            }
            catch{
                print("")
            }
        }
    }
    
    func configureImageView() {
        comicImageView.layer.cornerRadius = 10
        comicImageView.clipsToBounds = true
        comicImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureTitleLabel(){
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setImageConstraints(){
        comicImageView.configureForAutoLayout()
        comicImageView.autoSetDimensions(to: CGSize(width: 80, height: 80))
        comicImageView.autoPinEdge(.left, to: .left, of: contentView, withOffset: 20)
        comicImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        comicImageView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)

        comicImageView.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
    
    func setTitleLabelConstraints(){
        titleLabel.configureForAutoLayout()
        titleLabel.autoPinEdge(.left, to: .right, of: comicImageView, withOffset: 10)
        titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 20)

        titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
}



