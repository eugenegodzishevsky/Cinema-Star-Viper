// SimilarMoviesShimmerCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шиммер ячейка коллекции похожего фильма
final class SimilarMoviesShimmerCell: UITableViewCell {
    // MARK: - Constants

    static let identifier = "SimilarMoviesShimmerCell"

    // MARK: - Visual Components

    private let movieLabelView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()

    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        return collectionView
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupCollectionView()
        createConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
        setupCollectionView()
        createConstraints()
    }

    // MARK: - Life Cycle

    override func layoutSubviews() {
        super.layoutSubviews()
        movieLabelView.shimmerOn()
    }

    // MARK: - Private Methods

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.allowsSelection = false
        collectionView.register(
            SingleSimilarMovieShimmerCell.self,
            forCellWithReuseIdentifier: SingleSimilarMovieShimmerCell.identifier
        )
    }

    private func setupCell() {
        backgroundColor = .clear
        contentView.addSubview(movieLabelView)
        contentView.addSubview(collectionView)
    }

    private func createConstraints() {
        movieLabelView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-140)
            make.top.equalTo(contentView).offset(16)
            make.height.equalTo(20)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(movieLabelView.snp.bottom).offset(8)
            make.leading.equalTo(contentView)
            make.height.equalTo(248)
            make.trailing.equalTo(contentView)
            make.bottom.equalTo(contentView)
        }
    }
}

// MARK: - SimilarMoviesCell + UICollectionViewDataSource

extension SimilarMoviesShimmerCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SingleSimilarMovieShimmerCell.identifier,
            for: indexPath
        ) as? SingleSimilarMovieShimmerCell
        else { return UICollectionViewCell() }
        return cell
    }
}

// MARK: - SimilarMoviesCell + UICollectionViewDelegate

extension SimilarMoviesShimmerCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
}

// MARK: - SimilarMoviesCell + UICollectionViewDelegateFlowLayout

extension SimilarMoviesShimmerCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: 170, height: 248)
    }

    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        insetForSectionAt _: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }
}
