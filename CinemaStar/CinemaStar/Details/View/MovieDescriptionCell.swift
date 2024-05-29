// MovieDescriptionCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка фильма
final class MovieDescriptionCell: UITableViewCell {
    // MARK: - Constants

    static let identifier = "MovieNameCell"

    enum Constants {
        static let watchMovieText = "Смотреть"
        static let starSymbol = "\u{2B50}"
    }

    // MARK: - Visual Components

    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()

    private let movieLabel: UILabel = {
        let label = UILabel()
        label.font = .interBold(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    private let watchMovieButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.watchMovieText, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .inter(ofSize: 16)
        button.layer.cornerRadius = 12
        button.backgroundColor = .gradientDown
        return button
    }()

    // MARK: - Private Properties

    private var watchButton: VoidHandler?

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        createConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
        createConstraints()
    }

    // MARK: - Public Methods

    func setupLabel(movieDetails: MovieDetails, buttonHandler: @escaping VoidHandler) {
        let nameLabel = "\(movieDetails.movieName)\n \(Constants.starSymbol) "
        let regularAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.inter(ofSize: 16)]
        let attributedString = NSMutableAttributedString(string: nameLabel + (movieDetails.movieRating ?? ""))
        attributedString.addAttributes(
            regularAttributes,
            range: NSRange(location: nameLabel.count, length: movieDetails.movieRating?.count ?? 0)
        )
        movieLabel.attributedText = attributedString
        watchButton = buttonHandler
    }

    func setupImage(imageData: Data) {
        movieImageView.image = UIImage(data: imageData)
    }

    // MARK: - Private Methods

    private func setupCell() {
        backgroundColor = .clear
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieLabel)
        contentView.addSubview(watchMovieButton)
        watchMovieButton.addTarget(self, action: #selector(watchMoviePressed), for: .touchUpInside)
    }

    private func createConstraints() {
        movieImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(16)
            make.height.equalTo(200)
            make.width.equalTo(170)
        }
        movieLabel.snp.makeConstraints { make in
            make.centerY.equalTo(movieImageView)
            make.leading.equalTo(movieImageView.snp.trailing).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
        }
        watchMovieButton.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(16)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.height.equalTo(48)
            make.bottom.equalTo(contentView)
        }
    }

    @objc private func watchMoviePressed() {
        watchButton?()
    }
}
