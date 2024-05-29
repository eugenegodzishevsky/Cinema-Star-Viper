// MovieNameShimmerCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с названием
final class MovieNameShimmerCell: UITableViewCell {
    // MARK: - Constants

    static let identifier = "MovieNameShimmerCell"

    // MARK: - Visual Components

    private let movieImageView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()

    private let movieLabelView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()

    private let watchMovieButtonView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
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

    // MARK: - Life Cycle

    override func layoutSubviews() {
        super.layoutSubviews()
        movieImageView.shimmerOn()
        movieLabelView.shimmerOn()
        watchMovieButtonView.shimmerOn()
    }

    // MARK: - Private Methods

    private func setupCell() {
        backgroundColor = .clear
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieLabelView)
        contentView.addSubview(watchMovieButtonView)
    }

    private func createConstraints() {
        movieImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(16)
            make.height.equalTo(200)
            make.width.equalTo(170)
        }
        movieLabelView.snp.makeConstraints { make in
            make.centerY.equalTo(movieImageView)
            make.leading.equalTo(movieImageView.snp.trailing).offset(16)
            make.height.equalTo(90)
            make.trailing.equalTo(contentView).offset(-16)
        }
        watchMovieButtonView.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(16)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.height.equalTo(48)
            make.bottom.equalTo(contentView)
        }
    }
}
