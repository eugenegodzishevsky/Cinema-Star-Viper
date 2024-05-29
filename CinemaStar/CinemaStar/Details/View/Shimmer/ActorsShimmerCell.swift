// ActorsShimmerCell.swift
// Copyright © RoadMap. All rights reserved.

import SnapKit
import UIKit

/// Шиммер ячейка коллекции актеров
final class ActorsShimmerCell: UITableViewCell {
    // MARK: - Constants

    static let identifier = "ActorsShimmerCell"

    // MARK: - Visual Components

    private let actorsLabelView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()

    private let languageLabelView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()

    private let movieLanguageLabelView: UIView = {
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
        actorsLabelView.shimmerOn()
        languageLabelView.shimmerOn()
        movieLanguageLabelView.shimmerOn()
    }

    // MARK: - Private Methods

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.allowsSelection = false
        collectionView.register(
            SingleActorShimmerCell.self,
            forCellWithReuseIdentifier: SingleActorShimmerCell.identifier
        )
    }

    private func setupCell() {
        backgroundColor = .clear
        contentView.addSubview(actorsLabelView)
        contentView.addSubview(languageLabelView)
        contentView.addSubview(collectionView)
        contentView.addSubview(movieLanguageLabelView)
    }

    private func createConstraints() {
        actorsLabelView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-140)
            make.top.equalTo(contentView).offset(16)
            make.height.equalTo(20)
        }
        languageLabelView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-140)
            make.top.equalTo(collectionView.snp.bottom).offset(14)
            make.height.equalTo(20)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(actorsLabelView.snp.bottom).offset(10)
            make.leading.equalTo(contentView)
            make.height.equalTo(98)
            make.trailing.equalTo(contentView)
        }
        movieLanguageLabelView.snp.makeConstraints { make in
            make.top.equalTo(languageLabelView.snp.bottom).offset(4)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-140)
            make.height.equalTo(20)
            make.bottom.equalTo(contentView)
        }
    }
}

// MARK: - ActorsCell + UICollectionViewDataSource

extension ActorsShimmerCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SingleActorShimmerCell.identifier,
            for: indexPath
        ) as? SingleActorShimmerCell
        else { return UICollectionViewCell() }
        return cell
    }
}

// MARK: - ActorsCell + UICollectionViewDelegate

extension ActorsShimmerCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
}

// MARK: - ActorsCell + UICollectionViewDelegateFlowLayout

extension ActorsShimmerCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: 60, height: 98)
    }

    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        insetForSectionAt _: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 22)
    }
}
