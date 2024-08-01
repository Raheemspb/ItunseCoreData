//
//  CollectionViewCell.swift
//  ItunseCoreData
//
//  Created by Рахим Габибли on 24.07.2024.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    static let reuseId = "CollectionViewCell"

    var albumImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        image.contentMode = .scaleToFill

        return image
    }()

    var albumLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)

        return label
    }()

    var singerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    var trackCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(albumImage)
        contentView.addSubview(albumLabel)
        contentView.addSubview(singerLabel)
        contentView.addSubview(trackCountLabel)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        albumImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(60)
        }

        albumLabel.snp.makeConstraints { make in
            make.leading.equalTo(albumImage.snp.trailing).inset(-10)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(10)
        }

        singerLabel.snp.makeConstraints { make in
            make.leading.equalTo(albumLabel)
            make.trailing.equalToSuperview().inset(70)
            make.bottom.equalToSuperview().inset(10)
        }

        trackCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(singerLabel.snp.trailing).inset(-5)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    override func prepareForReuse() {
        albumImage.image = nil
        albumLabel.text = nil
        singerLabel.text = nil
        trackCountLabel.text = nil
    }
}
