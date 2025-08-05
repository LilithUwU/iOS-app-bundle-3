import UIKit


class ViewController: UIViewController {

    private var appConfig: AppConfig?

    private func makeLabel(fontSize: CGFloat, weight: UIFont.Weight, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        label.textColor = textColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }

    private lazy var titleLabel = makeLabel(fontSize: 34, weight: .bold, textColor: .label)
    private lazy var descriptionLabel = makeLabel(fontSize: 17, weight: .regular, textColor: .secondaryLabel)

    private let imageStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground

        setupUI()
        loadAndApplyConfiguration()
    }

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(imageStackView)

        [titleLabel, descriptionLabel, imageStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            imageStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageStackView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }

    private func loadAndApplyConfiguration() {
        appConfig = ConfigLoader.loadConfig()

        guard let config = appConfig else {
            titleLabel.text = "Error"
            descriptionLabel.text = "Failed to load configuration."
            return
        }

        titleLabel.text = config.appName
        descriptionLabel.text = config.appDescription

        let images = loadImages(using: config)
        displayImages(images)
    }

    private func loadImages(using config: AppConfig) -> [UIImage] {
        let selectedNames = Array(config.imageNames.prefix(config.features.numberOfImagesToShow))
        return selectedNames.compactMap { UIImage(named: $0) }
    }

    private func displayImages(_ images: [UIImage]) {
        imageStackView.arrangedSubviews.forEach {
            imageStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        guard let config = appConfig else { return }

        for image in images {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.tintColor = .systemBlue
            imageView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: config.features.imageSize),
                imageView.heightAnchor.constraint(equalToConstant: config.features.imageSize)
            ])

            imageStackView.addArrangedSubview(imageView)
        }
    }
}
