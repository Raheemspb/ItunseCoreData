//
//  AlbumDetailsViewController.swift
//  ItunseCoreData
//
//  Created by Рахим Габибли on 24.07.2024.
//

import Foundation
import UIKit

class AlbumDetailsViewController: UIViewController {

    let albumImage = UIImageView()
    let artistName = UILabel()
    let trackCount = UILabel()
    let tracksStackView = UIStackView()
    var album: Album?
    override func viewDidLoad() {
        super.viewDidLoad()
        setModel()
        setup()
    }

    private func setup() {
        view.addSubview(albumImage)
        view.addSubview(artistName)
        view.addSubview(trackCount)
        view.addSubview(tracksStackView)
        view.backgroundColor = .white
        tracksStackView.backgroundColor = .cyan
        albumImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.height.width.equalTo(120)
        }

        artistName.snp.makeConstraints { make in
            make.top.equalTo(albumImage)
            make.leading.equalTo(albumImage.snp.trailing).inset(-20)
        }

        trackCount.snp.makeConstraints { make in
            make.top.equalTo(artistName.snp.bottom).inset(-15)
            make.leading.equalTo(albumImage.snp.trailing).inset(-20)
        }

        tracksStackView.snp.makeConstraints { make in
            make.top.equalTo(trackCount.snp.bottom).inset(-5)
            make.leading.equalTo(albumImage.snp.trailing).inset(-20)
            make.trailing.equalToSuperview().inset(20)
        }
    }

    private func setupStackView() {
        tracksStackView.axis = .vertical
        tracksStackView.alignment = .leading
        tracksStackView.spacing = 3
    }

    private func setModel() {
        guard let album = album else { return }

        artistName.text = album.artistName
        trackCount.text = "\(album.trackCount) tracks"
        guard let imageUrl = URL(string: album.artworkUrl100) else { return }

        DispatchQueue.global(qos: .utility).async {
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }

            DispatchQueue.main.async {
                self.albumImage.image = UIImage(data: imageData)
            }
        }
    }

//    func confiqure(indexPath: IndexPath) {
//        guard let imageUrl = URL(string: viewController.albums[indexPath.item].artworkUrl100) else { return }
//        DispatchQueue.global().async {
//            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
//
//            DispatchQueue.main.async {
//                self.albumImage.image = UIImage(data: imageData)
//            }
//        }
//
//    }


}
