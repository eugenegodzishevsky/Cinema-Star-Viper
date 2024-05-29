// MovieShimmerCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с шиммером загрузки фильма
final class MovieShimmerCell: UICollectionViewCell {
    // MARK: - Constants

    static let identifier = "MovieShimmerCell"

    // MARK: - Visual Components

    private let movieImageView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()

    private let movieLabelView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    // MARK: - Life Cycle

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        movieImageView.shimmerOn()
        movieLabelView.shimmerOn()
    }

    // MARK: - Private Methods

    private func configureUI() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieLabelView)

        movieImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
            make.height.equalTo(200)
        }

        movieLabelView.snp.makeConstraints { make in
            make.width.equalTo(contentView)
            make.top.equalTo(movieImageView.snp.bottom).offset(10)
            make.bottom.equalTo(contentView)
            make.height.equalTo(40)
        }

        movieImageView.shimmerOn()
        movieLabelView.shimmerOn()
    }
}
