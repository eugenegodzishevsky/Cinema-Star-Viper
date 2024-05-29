// MovieCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка фильма главного экрана
final class MovieCell: UICollectionViewCell {
    // MARK: - Constants

    static let identifier = "MovieCell"

    enum Constants {
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
        label.font = .interMedium(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Public Properties

    var cellID: IndexPath?

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        createConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
        createConstraints()
    }

    // MARK: - Public Methods

    func setupLabel(movieData: MovieData) {
        if movieData.movieName.count > 15 {
            let sliceMovieName = movieData.movieName.dropLast(movieData.movieName.count - 15)
            movieLabel.text = "\(sliceMovieName)...\n \(Constants.starSymbol) \(movieData.movieRating ?? "")"
        } else {
            movieLabel.text = "\(movieData.movieName)\n \(Constants.starSymbol) \(movieData.movieRating ?? "")"
        }
    }

    func setupImage(imageData: Data) {
        movieImageView.image = UIImage(data: imageData)
    }

    // MARK: - Private Methods

    private func setupCell() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieLabel)
    }

    private func createConstraints() {
        movieImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
            make.height.equalTo(200)
        }
        movieLabel.snp.makeConstraints { make in
            make.width.equalTo(contentView)
            make.top.equalTo(movieImageView.snp.bottom).offset(8)
            make.bottom.equalTo(contentView)
        }
    }
}
