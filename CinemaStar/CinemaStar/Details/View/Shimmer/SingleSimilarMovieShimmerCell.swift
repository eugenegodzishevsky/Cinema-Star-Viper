// SingleSimilarMovieShimmerCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шиммер ячейка похожего фильма
final class SingleSimilarMovieShimmerCell: UICollectionViewCell {
    // MARK: - Constants

    static let identifier = "SingleSimilarMovieShimmerCell"

    // MARK: - Visual Components

    private let movieImageView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()

    private let movieNameLabelView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()

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

    // MARK: - Life Cycle

    override func layoutSubviews() {
        super.layoutSubviews()
        movieImageView.shimmerOn()
        movieNameLabelView.shimmerOn()
    }

    // MARK: - Private Methods

    private func setupCell() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieNameLabelView)
    }

    private func createConstraints() {
        movieImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
            make.height.equalTo(200)
            make.width.equalTo(170)
        }
        movieNameLabelView.snp.makeConstraints { make in
            make.width.equalTo(contentView)
            make.top.equalTo(movieImageView.snp.bottom).offset(8)
            make.height.equalTo(40)
            make.bottom.equalTo(contentView)
        }
    }
}
