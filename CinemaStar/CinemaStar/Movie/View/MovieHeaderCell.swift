// MovieHeaderCell.swift
// Copyright © RoadMap. All rights reserved.

import SnapKit
import UIKit

/// Верхняя ячейка экрана фильмов
final class MovieHeaderCell: UICollectionViewCell {
    // MARK: - Constants

    static let identifier = "MovieHeaderCell"

    enum Constants {
        static let labelRegular = "Смотри исторические фильмы на "
        static let labelBold = "CINEMA STAR"
    }

    // MARK: - Visual Components

    private let label: UILabel = {
        let label = UILabel()
        label.font = .interMedium(ofSize: 20)
        let labelText = "\(Constants.labelRegular)"
        let boldAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.interBold(ofSize: 20)]
        let attributedString = NSMutableAttributedString(string: labelText + Constants.labelBold)
        attributedString.addAttributes(
            boldAttributes,
            range: NSRange(location: labelText.count, length: Constants.labelBold.count)
        )
        label.attributedText = attributedString
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    // MARK: - Private Methods

    private func setupCell() {
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
    }
}
