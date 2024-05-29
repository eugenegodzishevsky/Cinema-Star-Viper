// DetailsCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с описанием  фильма
final class DetailsCell: UITableViewCell {
    // MARK: - Constants

    static let identifier = "DetailsCell"

    // MARK: - Visual Components

    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.font = .inter(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 5
        return label
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .inter(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()

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

    func setupLabel(movieDetails: MovieDetails) {
        detailsLabel.text = movieDetails.description
        infoLabel.text = "\(movieDetails.year ?? 0) / \(movieDetails.country ?? "") / \(movieDetails.contentType ?? "")"
    }

    // MARK: - Private Methods

    private func setupCell() {
        backgroundColor = .clear
        contentView.addSubview(detailsLabel)
        contentView.addSubview(infoLabel)
    }

    private func createConstraints() {
        detailsLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.top.equalTo(contentView).offset(16)
            make.height.equalTo(100)
        }
        infoLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.top.equalTo(detailsLabel.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.bottom.equalTo(contentView)
        }
    }
}
