//
//  OnBoardingCell.swift
//  NoteApp
//
//  Created by Zhamilia Zhanakeeva on 19/3/24.
//

import UIKit
struct Screens {
    var image: UIImage?
    var title: String
    var description: String
}

class OnBoardingCell: UICollectionViewCell {
    static var reuseId = "cv_cell"
    
    private lazy var containerView: UIView = {
       let view = UIView()
        return view
    }()
    
    private lazy var screenImage: UIImageView = {
       let view = UIImageView()
        return view
    }()
    
    private lazy var screenTitle: UILabel = {
       let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .bold)
        return view
    }()
    
    private lazy var screenDescription: UILabel = {
       let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 16, weight: .regular)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        containerView.addSubview(screenImage)
        screenImage.translatesAutoresizingMaskIntoConstraints = false
        screenImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 100).isActive = true
        screenImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        screenImage.heightAnchor.constraint(equalToConstant: 140).isActive = true
        screenImage.widthAnchor.constraint(equalToConstant: 211).isActive = true
        
        containerView.addSubview(screenTitle)
        screenTitle.translatesAutoresizingMaskIntoConstraints = false
        screenTitle.topAnchor.constraint(equalTo: screenImage.bottomAnchor, constant: 30).isActive = true
        screenTitle.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        containerView.addSubview(screenDescription)
        screenDescription.translatesAutoresizingMaskIntoConstraints = false
        screenDescription.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 20).isActive = true
        screenDescription.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        screenDescription.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 10).isActive = true
    }
    
    func setData(screen: Screens) {
        screenImage.image = screen.image
        screenTitle.text = screen.title
        screenDescription.text = screen.description
    }
}
