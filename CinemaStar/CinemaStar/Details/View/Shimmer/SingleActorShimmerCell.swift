// SingleActorShimmerCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шиммер ячейка актера
final class SingleActorShimmerCell: UICollectionViewCell {
    // MARK: - Constants

    static let identifier = "SingleActorShimmerCell"

    // MARK: - Visual Components

    private let actorImageView: UIView = {
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
        actorImageView.shimmerOn()
    }

    // MARK: - Private Methods

    private func setupCell() {
        contentView.addSubview(actorImageView)
    }

    private func createConstraints() {
        actorImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
