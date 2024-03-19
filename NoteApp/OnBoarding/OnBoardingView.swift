//
//  OnBoardingView.swift
//  NoteApp
//
//  Created by Zhamilia Zhanakeeva on 19/3/24.
//

import UIKit

class OnBoardingView: UIViewController, UICollectionViewDataSource {
    let screens: [Screens] = [
        Screens(image: UIImage(named: "firstScreen"), title: "Welcome to The Note", description: "Welcome to The Note - your new companion for tasks, goals, health - all in one place. Let's get started!"),
        Screens(image: UIImage(named: "secondScreen"), title: "Set Up Your Profile", description: "Now that you're with us, let's get to know each other better. Fill out your profile, share your interests, and set your goals."),
        Screens(image: UIImage(named: "lastScreen"), title: "Dive into The Note", description: "You're fully equipped to dive into the world of The Note. Remember, we're here to assist you every step of the way. Ready to start? Let's go")]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return cv
    }()
    
    private lazy var skipButton: UIButton = {
        let view = UIButton()
        view.setTitle("Skip", for: .normal)
        view.setTitleColor(.systemRed, for: .normal)
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        let view = UIButton()
        view.setTitle("Next", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .systemRed
        view.layer.cornerRadius = 20
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
   private func setupConstraints() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.dataSource = self
        collectionView.register(OnBoardingCell.self, forCellWithReuseIdentifier: OnBoardingCell.reuseId)
        
        view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        view.addSubview(skipButton)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor).isActive = true
        skipButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCell.reuseId, for: indexPath) as! OnBoardingCell
        cell.setData(screen: screens[indexPath.row])
        return cell
    }
    
    @objc private func skipButtonTapped() {
        let vc = HomeView()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func nextButtonTapped() {
        let vc = HomeView()
        navigationController?.pushViewController(vc, animated: true)
    }
}
