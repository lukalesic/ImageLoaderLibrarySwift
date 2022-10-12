//
//  NameTableViewCell.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 12.10.2022..
//

import UIKit

class NameTableViewCell: UITableViewCell {
    
    var titleName: UILabel = {
        let name = UILabel()
        name.numberOfLines = 0
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Placeholder text"
        return name
    }()
    
    var container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemMint
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var coverPhoto: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemBlue
        image.translatesAutoresizingMaskIntoConstraints = false
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
        
        container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        container.widthAnchor.constraint(equalToConstant: 120).isActive = true
        container.heightAnchor.constraint(equalToConstant: 120).isActive = true

        
        var height = titleName.constraints.filter{$0.firstAttribute == .height}.first?.constant ?? 60
        height = 120 / 2
        
        titleName.leadingAnchor.constraint(equalTo: container.trailingAnchor, constant: 10).isActive = true
        titleName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        titleName.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: titleName.bottomAnchor, constant: height + 20).isActive = true

        
    }
}
