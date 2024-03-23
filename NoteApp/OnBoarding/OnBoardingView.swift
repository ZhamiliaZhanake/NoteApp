//
//  OnBoardingView.swift
//  NoteApp
//
//  Created by Zhamilia Zhanakeeva on 19/3/24.
//

import UIKit
protocol OnboardingViewDelegate: AnyObject {
    func isOnBoardShown(isShown: Bool)
}

class OnBoardingView: UIViewController {
    let screens: [Screens] = [
        Screens(image: UIImage(named: "firstScreen"), title: "Welcome to The Note", description: "Welcome to The Note - your new companion for tasks, goals, health - all in one place. Let's get started!"),
        Screens(image: UIImage(named: "secondScreen"), title: "Set Up Your Profile", description: "Now that you're with us, let's get to know each other better. Fill out your profile, share your interests, and set your goals."),
        Screens(image: UIImage(named: "lastScreen"), title: "Dive into The Note", description: "You're fully equipped to dive into the world of The Note. Remember, we're here to assist you every step of the way. Ready to start? Let's go")]
    
    var currentIndex = 0
    weak var delegate: OnboardingViewDelegate?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.dataSource = self
        cv.register(OnBoardingCell.self, forCellWithReuseIdentifier: OnBoardingCell.reuseId)
        cv.delegate = self
        return cv
    }()
    
    private lazy var pageControl: UIPageControl = {
      let view = UIPageControl()
        view.numberOfPages = screens.count
        view.currentPage = 0
        view.currentPageIndicatorTintColor = .black
        view.pageIndicatorTintColor = .gray
        return view
    }()
    
    private lazy var skipButton: UIButton = {
        let view = UIButton()
        view.setTitle("Skip", for: .normal)
        view.setTitleColor(.systemRed, for: .normal)
        view.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        let view = UIButton()
        view.setTitle("Next", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .systemRed
        view.layer.cornerRadius = 20
        view.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        if UserDefaults.standard.bool(forKey: "OnBoardingShown") {
            delegate?.isOnBoardShown(isShown: true)
        } else {
            UserDefaults.standard.set(true, forKey: "OnBoardingShown")
            delegate?.isOnBoardShown(isShown: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.overrideUserInterfaceStyle = .light
    }
    
    private func setupConstraints() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -150).isActive = true
        
        view.addSubview(skipButton)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor).isActive = true
        skipButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
    }
    
    @objc private func skipButtonTapped() {
        delegate?.isOnBoardShown(isShown: true)
        let vc = HomeView()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func nextButtonTapped() {
        currentIndex += 1
        if currentIndex < 3 {
            collectionView.isPagingEnabled = false
            collectionView.scrollToItem(at: IndexPath(row: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
            collectionView.isPagingEnabled = true
            pageControl.currentPage = currentIndex
        } else {
            UserDefaults.standard.setValue(true, forKey: "OnBoardingShown")
            delegate?.isOnBoardShown(isShown: true)
            navigationController?.pushViewController(HomeView(), animated: true)
        }
    }
}
extension OnBoardingView:  UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCell.reuseId, for: indexPath) as! OnBoardingCell
        cell.setData(screen: screens[indexPath.row])
        return cell
    }
}
    
extension OnBoardingView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
