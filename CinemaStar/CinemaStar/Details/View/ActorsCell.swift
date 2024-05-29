// ActorsCell.swift
// Copyright © RoadMap. All rights reserved.

import SnapKit
import UIKit

/// Ячейка с актерами
final class ActorsCell: UITableViewCell {
    // MARK: - Constants

    static let identifier = "ActorsCell"

    enum Constants {
        static let actorsLabelText = "Актеры и съемочная группа"
        static let languageLabelText = "Язык"
    }

    // MARK: - Visual Components

    private let actorsLabel: UILabel = {
        let label = UILabel()
        label.font = .interBold(ofSize: 14)
        label.text = Constants.actorsLabelText
        label.textColor = .white
        return label
    }()

    private let languageLabel: UILabel = {
        let label = UILabel()
        label.font = .interBold(ofSize: 14)
        label.text = Constants.languageLabelText
        label.textColor = .white
        return label
    }()

    private let movieLanguageLabel: UILabel = {
        let label = UILabel()
        label.font = .inter(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()

    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        return collectionView
    }()

    // MARK: - Public Properties

    var fetchImage: ((_ url: URL, _ comletion: @escaping DataHandler) -> Void)? {
        didSet {
            self.collectionView.reloadData()
        }
    }

    // MARK: - Private Properties

    private var movieActors: [MovieActor]? {
        didSet {
            collectionView.reloadData()
        }
    }

    private var languageLabelConstraint: Constraint?
    private var languageNameLabelConstraint: Constraint?
    private var languageLabelTopConstraint: Constraint?

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

    func setInfo(movieDetails: MovieDetails) {
        movieActors = movieDetails.actors
        if movieDetails.language != nil {
            movieLanguageLabel.text = movieDetails.language
            languageLabelConstraint?.activate()
            languageLabelTopConstraint?.activate()
            languageNameLabelConstraint?.activate()
        } else {
            languageLabelConstraint?.update(offset: 0)
            languageLabelTopConstraint?.update(offset: 0)
            languageNameLabelConstraint?.update(offset: 0)
        }
    }

    // MARK: - Private Methods

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(
            SingleActorCell.self,
            forCellWithReuseIdentifier: SingleActorCell.identifier
        )
    }

    private func setupCell() {
        backgroundColor = .clear
        contentView.addSubview(actorsLabel)
        contentView.addSubview(languageLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(movieLanguageLabel)
    }

    private func createConstraints() {
        actorsLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.top.equalTo(contentView).offset(16)
            make.height.equalTo(20)
        }
        languageLabel.snp.makeConstraints { make in
            languageLabelTopConstraint = make.leading.equalTo(contentView).offset(16).constraint
            make.top.equalTo(collectionView.snp.bottom).offset(14)
            languageLabelConstraint = make.height.equalTo(20).constraint
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(actorsLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView)
            make.height.equalTo(98)
            make.trailing.equalTo(contentView)
        }
        movieLanguageLabel.snp.makeConstraints { make in
            make.top.equalTo(languageLabel.snp.bottom).offset(4)
            make.leading.equalTo(contentView).offset(16)
            languageNameLabelConstraint = make.height.equalTo(20).constraint
            make.bottom.equalTo(contentView)
        }
    }
}

// MARK: - ActorsCell + UICollectionViewDataSource

extension ActorsCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SingleActorCell.identifier,
            for: indexPath
        ) as? SingleActorCell
        else { return UICollectionViewCell() }
        cell.setupLabel(actorName: movieActors?[indexPath.item].name)
        guard let url = movieActors?[indexPath.item].imageURL,
              let url = URL(string: url) else { return UICollectionViewCell() }
        cell.cellID = indexPath
        fetchImage?(url) { imageData in
            if cell.cellID == indexPath {
                cell.setupImage(imageData: imageData)
            }
        }

        return cell
    }
}

// MARK: - ActorsCell + UICollectionViewDelegate

extension ActorsCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieActors?.count ?? 0
    }
}

// MARK: - ActorsCell + UICollectionViewDelegateFlowLayout

extension ActorsCell: UICollectionViewDelegateFlowLayout {
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
