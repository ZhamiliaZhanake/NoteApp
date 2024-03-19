//
//  SettingsTableViewCell.swift
//  NoteApp
//
//  Created by Zhamilia Zhanakeeva on 16/3/24.
//

import UIKit
enum SettingsType {
    case withRightButton
    case withSwitch
    case usual
}

struct Settings {
    var image: UIImage?
    var title: String
    var description: String
    var type: SettingsType
}

class SettingsCell: UITableViewCell {
    static var reuseId = "settings_cell"
    
    private lazy var bgView: UIView = {
       let view = UIView()
        view.backgroundColor = .tertiaryLabel
        return view
    }()
    
    private lazy var settingImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var settingLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private lazy var rightButton: UIButton = {
        let view = UIButton(type: .system)
        return view
    }()
    
    private lazy var switchView: UISwitch = {
        let view = UISwitch()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(settings: Settings) {
        settingImage.image = settings.image
        settingLabel.text = settings.title
        if settings.type == .withRightButton {
            rightButton.setTitle(settings.description, for: .normal)
            rightButton.setImage(UIImage(named: "Chevron"), for: .normal)
            rightButton.semanticContentAttribute = .forceRightToLeft
            switchView.isHidden = true
        } else if settings.type == .withSwitch {
            rightButton.isHidden = true
        } else if settings.type == .usual {
            switchView.isHidden = true
            rightButton.isHidden = true
        }
    }
    private func setupConstraints() {
        contentView.addSubview(bgView)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        contentView.addSubview(settingImage)
        settingImage.translatesAutoresizingMaskIntoConstraints = false
        settingImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        settingImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        settingImage.heightAnchor.constraint(equalToConstant: 24).isActive = true
        settingImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        contentView.addSubview(settingLabel)
        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        settingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        settingLabel.leadingAnchor.constraint(equalTo: settingImage.trailingAnchor, constant: 15).isActive = true
        settingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        contentView.addSubview(rightButton)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        rightButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        rightButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        rightButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        contentView.addSubview(switchView)
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        switchView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
}

