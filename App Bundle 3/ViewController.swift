//
//  ViewController.swift
//  App Bundle 3
//
//  Created by lilit on 30.07.25.
//
import UIKit


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var images: [UIImage] = []
    var config: AppConfiguration?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        config = ConfigLoader.loadConfiguration()
        images = ImageLoader.loadImages(maxCount: config?.numberOfImagesToDisplay ?? 5)

        titleLabel.text = config?.appTitle ?? "Title"
        welcomeLabel.text = config?.welcomeMessage ?? "Body!"

        view.addSubview(titleLabel)
        view.addSubview(welcomeLabel)
        view.addSubview(collectionView)

        setupLayout()
        titleLabel.backgroundColor = .red.withAlphaComponent(0.2)
        welcomeLabel.backgroundColor = .green.withAlphaComponent(0.2)
        collectionView.backgroundColor = .blue.withAlphaComponent(0.1)
        ConfigLoader.printJson()

    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            welcomeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            collectionView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        let imageView = UIImageView(image: images[indexPath.item])
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = cell.contentView.bounds
        cell.contentView.addSubview(imageView)

        return cell
    }


    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let padding: CGFloat = 10
        let width = (collectionView.bounds.width - padding) / 2
        return CGSize(width: width, height: width * 0.75)
    }
}

