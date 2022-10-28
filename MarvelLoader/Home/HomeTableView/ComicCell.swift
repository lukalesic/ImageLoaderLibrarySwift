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
     var titleLabel = UILabel()
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
    }
    
    func configureTitleLabel(){
        titleLabel.numberOfLines = 0
    }
    
    func setImageConstraints(){
        comicImageView.configureForAutoLayout()
        comicImageView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 0), excludingEdge: .right)
        
          NSLayoutConstraint.autoSetPriority(UILayoutPriority(rawValue: 999)) {
            comicImageView.autoSetDimensions(to: CGSize(width: 80, height: 80))
        }
    }
    
    func setTitleLabelConstraints(){
        titleLabel.configureForAutoLayout()
        titleLabel.autoPinEdge(.left, to: .right, of: comicImageView, withOffset: 10)
        titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 20)

        titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
}



