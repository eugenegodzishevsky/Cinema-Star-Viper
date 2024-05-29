// SimilarMoviesCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с похожими
final class SimilarMoviesCell: UITableViewCell {
    // MARK: - Constants

    static let identifier = "SimilarMoviesCell"

    enum Constants {
        static let watchMovieText = "Смотрите также"
    }

    // MARK: - Visual Components

    private let movieLabel: UILabel = {
        let label = UILabel()
        label.font = .interBold(ofSize: 14)
        label.text = Constants.watchMovieText
        label.textColor = .white
        return label
    }()

    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        return collectionView
    }()

    // MARK: - Public Properties

    var fetchImage: ((_ url: URL, _ completion: @escaping DataHandler) -> Void)? {
        didSet {
            self.collectionView.reloadData()
        }
    }

    // MARK: - Private Properties

    private var movies: [MovieData]? {
        didSet {
            collectionView.reloadData()
        }
    }

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

    // MARK: - Public Methods

    func setInfo(movies: [MovieData]) {
        self.movies = movies
    }

    // MARK: - Private Methods

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(
            SingleSimilarMovieCell.self,
            forCellWithReuseIdentifier: SingleSimilarMovieCell.identifier
        )
    }

    private func setupCell() {
        backgroundColor = .clear
        contentView.addSubview(movieLabel)
        contentView.addSubview(collectionView)
    }

    private func createConstraints() {
        movieLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.top.equalTo(contentView).offset(16)
            make.height.equalTo(20)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(movieLabel.snp.bottom).offset(8)
            make.leading.equalTo(contentView)
            make.height.equalTo(248)
            make.trailing.equalTo(contentView)
            make.bottom.equalTo(contentView)
        }
    }
}

// MARK: - SimilarMoviesCell + UICollectionViewDataSource

extension SimilarMoviesCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SingleSimilarMovieCell.identifier,
            for: indexPath
        ) as? SingleSimilarMovieCell
        else { return UICollectionViewCell() }
        cell.setupLabel(movieName: movies?[indexPath.item].movieName)
        guard let url = movies?[indexPath.item].imageURL else { return UICollectionViewCell() }
        cell.cellID = indexPath
        fetchImage?(url) { imageData in
            if cell.cellID == indexPath {
                cell.setupImage(imageData: imageData)
            }
        }

        return cell
    }
}

// MARK: - SimilarMoviesCell + UICollectionViewDelegate

extension SimilarMoviesCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies?.count ?? 0
    }
}

// MARK: - SimilarMoviesCell + UICollectionViewDelegateFlowLayout

extension SimilarMoviesCell: UICollectionViewDelegateFlowLayout {
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
