// SingleActorCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка актеров
final class SingleActorCell: UICollectionViewCell {
    // MARK: - Constants

    static let identifier = "SingleActorCell"

    // MARK: - Visual Components

    private let actorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let actorNameLabel: UILabel = {
        let label = UILabel()
        label.font = .inter(ofSize: 8)
        label.textColor = .white
        label.textAlignment = .center
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

    func setupLabel(actorName: String?) {
        actorNameLabel.text = actorName
    }

    func setupImage(imageData: Data) {
        actorImageView.image = UIImage(data: imageData)
    }

    // MARK: - Private Methods

    private func setupCell() {
        contentView.addSubview(actorImageView)
        contentView.addSubview(actorNameLabel)
    }

    private func createConstraints() {
        actorImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.equalTo(contentView).offset(6)
            make.trailing.equalTo(contentView).offset(-6)
            make.height.equalTo(73)
        }
        actorNameLabel.snp.makeConstraints { make in
            make.width.equalTo(contentView)
            make.top.equalTo(actorImageView.snp.bottom)
            make.height.equalTo(25)
            make.bottom.equalTo(contentView)
        }
    }
}
