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
        addSubview(screenImage)
        screenImage.translatesAutoresizingMaskIntoConstraints = false
        screenImage.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        screenImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        screenImage.heightAnchor.constraint(equalToConstant: 140).isActive = true
        screenImage.widthAnchor.constraint(equalToConstant: 211).isActive = true
        
        addSubview(screenTitle)
        screenTitle.translatesAutoresizingMaskIntoConstraints = false
        screenTitle.topAnchor.constraint(equalTo: screenImage.bottomAnchor, constant: 30).isActive = true
        screenTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(screenDescription)
        screenDescription.translatesAutoresizingMaskIntoConstraints = false
        screenDescription.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 20).isActive = true
        screenDescription.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        screenDescription.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
    }
    
    func setData(screen: Screens) {
        screenImage.image = screen.image
        screenTitle.text = screen.title
        screenDescription.text = screen.description
    }
}
