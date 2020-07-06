//
//  CountryCellTableViewCell.swift
//  DiffableDataSourceTestApp
//
//  Created by Goran Tokovic on 24/06/2020.
//  Copyright © 2020 Goran Tokovic. All rights reserved.
//

//import AlamofireImage
import UIKit

final class CountryCellTableViewCell: UITableViewCell {

    private static let placeholder: UIImage = UIImage.coloredImage(color: .gray)

    private lazy var flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        label.numberOfLines = 0
        label.textColor = .text
        return label
    }()

    private lazy var capitalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .text
        return label
    }()

    private lazy var polulationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .text
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureContstraints()
        backgroundColor = .background
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureContstraints() {
        // Flag image view
        contentView.addSubview(flagImageView)
        NSLayoutConstraint.activate([
            flagImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            flagImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 20),
            flagImageView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: -20),
            flagImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            flagImageView.heightAnchor.constraint(equalToConstant: 70),
            flagImageView.widthAnchor.constraint(equalToConstant: 70),
        ])

        // Country Label
        contentView.addSubview(countryLabel)
        NSLayoutConstraint.activate([
            countryLabel.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor, constant: 10),
            countryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            countryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
        ])

        // Capital Label
        contentView.addSubview(capitalLabel)
        NSLayoutConstraint.activate([
            capitalLabel.leadingAnchor.constraint(equalTo: countryLabel.leadingAnchor),
            capitalLabel.trailingAnchor.constraint(equalTo: countryLabel.trailingAnchor),
            capitalLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor),
        ])

        // Population Label
        contentView.addSubview(polulationLabel)
        NSLayoutConstraint.activate([
            polulationLabel.leadingAnchor.constraint(equalTo: countryLabel.leadingAnchor),
            polulationLabel.trailingAnchor.constraint(equalTo: countryLabel.trailingAnchor),
            polulationLabel.topAnchor.constraint(equalTo: capitalLabel.bottomAnchor),
        ])
    }

    func updateData(_ country: Country) {
        countryLabel.text = country.name
        capitalLabel.text = country.capital

        if let population = country.population {
            polulationLabel.text = NumberFormatter.separatedHundreds.string(from: NSNumber(value: population))
        } else {
            polulationLabel.text = "N/A"
        }

//        if let code = country.alpha2Code,
//            let url = URL(string: "https://www.countryflags.io/\(code.lowercased())/flat/64.png") {
//            flagImageView.af.setImage(withURL: url, placeholderImage: type(of: self).placeholder, imageTransition: .crossDissolve(0.3))
//        } else {
//            flagImageView.image = type(of: self).placeholder
//        }
    }
}

private extension UIImage {
    static func coloredImage(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return UIImage() }
        return UIImage(cgImage: cgImage)
    }
}
