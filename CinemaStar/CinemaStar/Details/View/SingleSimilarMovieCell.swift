// SingleSimilarMovieCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка похожего фильма
final class SingleSimilarMovieCell: UICollectionViewCell {
    // MARK: - Constants

    static let identifier = "SingleSimilarMovieCell"

    // MARK: - Visual Components

    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()

    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = .inter(ofSize: 16)
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

    func setupLabel(movieName: String?) {
        movieNameLabel.text = movieName
    }

    func setupImage(imageData: Data) {
        movieImageView.image = UIImage(data: imageData)
    }

    // MARK: - Private Methods

    private func setupCell() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieNameLabel)
    }

    private func createConstraints() {
        movieImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
            make.height.equalTo(200)
            make.width.equalTo(170)
        }
        movieNameLabel.snp.makeConstraints { make in
            make.width.equalTo(contentView)
            make.top.equalTo(movieImageView.snp.bottom).offset(8)
            make.height.equalTo(40)
            make.bottom.equalTo(contentView)
        }
    }
}
