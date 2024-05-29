// DetailsShimmerCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с деталями
final class DetailsShimmerCell: UITableViewCell {
    // MARK: - Constants

    static let identifier = "DetailsShimmerCell"

    // MARK: - Visual Components

    private let detailsLabelView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()

    private let infoLabelView: UIView = {
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
        detailsLabelView.shimmerOn()
        infoLabelView.shimmerOn()
    }

    // MARK: - Private Methods

    private func setupCell() {
        backgroundColor = .clear
        contentView.addSubview(detailsLabelView)
        contentView.addSubview(infoLabelView)
    }

    private func createConstraints() {
        detailsLabelView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.top.equalTo(contentView).offset(16)
            make.height.equalTo(100)
        }
        infoLabelView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-140)
            make.top.equalTo(detailsLabelView.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.bottom.equalTo(contentView)
        }
    }
}
