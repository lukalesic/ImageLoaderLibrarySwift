//
//  ComicCell.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 05.10.2022..
//

import UIKit
import PureLayout
import Combine

class ComicCell: UITableViewCell {
    
    var comicCellViewModel = ComicCellViewModel()
    let loader = Loader()
    
    private var cancellables: Set<AnyCancellable> = []
    
    var comicImageView = UIImageView()
    var titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        displayLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func displayLayout(){
        addSubview(comicImageView)
        addSubview(titleLabel)
        comicCellViewModel.configureImageView(comicImageView: comicImageView)
        comicCellViewModel.configureTitleLabel(comicTitleLabel: titleLabel)
        comicCellViewModel.setImageConstraints(comicImageView: comicImageView)
        comicCellViewModel.setTitleLabelConstraints(comicTitleLabel: titleLabel, comicImageView: comicImageView)
        
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
    
    func bind(){
        comicCellViewModel.$comicTitleLabel
            .sink { [weak self] title in
                self?.titleLabel.text = title
                
        }.store(in: &cancellables)
    }
    
    
    func setTitle(title: String?){
        titleLabel.text = title
    }
        
}


