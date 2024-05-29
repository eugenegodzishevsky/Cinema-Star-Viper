// MovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный экран приложения
final class MovieViewController: UIViewController {
    // MARK: - Visual Components

    private let gradientLayer = CAGradientLayer()

    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        return collectionView
    }()

    // MARK: - Public Properties

    var viewModel: MovieViewModelProtocol? {
        didSet {
            viewModel?.updateCollectionView = collectionView.reloadData
            viewModel?.moviesRequest()
        }
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addGradientLayer()
        setupCollectionView()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.backgroundColor = .white
        view.layer.addSublayer(gradientLayer)
        navigationController?.navigationBar.isHidden = true
        navigationItem.backButtonTitle = ""
    }

    private func addGradientLayer() {
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.gradientUp.cgColor, UIColor.gradientDown.cgColor]
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(
            MovieCell.self,
            forCellWithReuseIdentifier: MovieCell.identifier
        )
        collectionView.register(
            MovieHeaderCell.self,
            forCellWithReuseIdentifier: MovieHeaderCell.identifier
        )
        collectionView.register(
            MovieShimmerCell.self,
            forCellWithReuseIdentifier: MovieShimmerCell.identifier
        )

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
        }
    }
}

// MARK: - MovieViewController + UICollectionViewDataSource

extension MovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel?.state {
        case .loading:
            return 20
        case let .data(movies):
            return movies.count
        default:
            return 1
        }
    }

    // swiftlint:disable all

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MovieHeaderCell.identifier,
                for: indexPath
            ) as? MovieHeaderCell else { return UICollectionViewCell() }
            return cell

        default:
            switch viewModel?.state {
            case .loading:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MovieShimmerCell.identifier,
                    for: indexPath
                ) as? MovieShimmerCell else { return UICollectionViewCell() }
                return cell

            case let .data(movies):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MovieCell.identifier,
                    for: indexPath
                ) as? MovieCell else { return UICollectionViewCell() }
                cell.setupLabel(movieData: movies[indexPath.item - 1])

                guard let url = movies[indexPath.item - 1].imageURL else { break }
                cell.cellID = indexPath
                viewModel?.fetchMovieImage(url: url) { imageData in
                    if cell.cellID == indexPath {
                        cell.setupImage(imageData: imageData)
                    }
                }
                // swiftlint:enable all

                return cell
            case .noData:
                return UICollectionViewCell()
            case .error:
                return UICollectionViewCell()
            default:
                return UICollectionViewCell()
            }
        }

        return UICollectionViewCell()
    }
}

// MARK: - MovieViewController + UICollectionViewDelegate

extension MovieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.openDetailsScreen(filmNumber: indexPath.item - 1)
    }
}

// MARK: - MovieViewController + UICollectionViewDelegateFlowLayout

extension MovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: view.frame.width, height: 50)
        default:
            return CGSize(width: (view.frame.width - 50) / 2, height: 248)
        }
    }

    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        insetForSectionAt _: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        minimumLineSpacingForSectionAt _: Int
    ) -> CGFloat {
        14
    }
}
