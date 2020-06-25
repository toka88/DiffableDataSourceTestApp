//
//  CountryCellTableViewCell.swift
//  DiffableDataSourceTestApp
//
//  Created by Goran Tokovic on 24/06/2020.
//  Copyright © 2020 Goran Tokovic. All rights reserved.
//

import AlamofireImage
import UIKit

final class CountryCellTableViewCell: UITableViewCell {

    private static let placeholder: UIImage = UIImage.coloredImage(color: .gray)

    @IBOutlet weak var flagImageView: UIImageView! {
        didSet {
            flagImageView.backgroundColor = .white
            flagImageView.layer.borderWidth = 1
            flagImageView.layer.borderColor = UIColor.gray.cgColor
        }
    }
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var polulationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        selectionStyle = .none
    }

    func updateData(_ country: Country) {
        countryLabel.text = country.name
        cityLabel.text = country.capital

        if let population = country.population {
            polulationLabel.text = NumberFormatter.separatedHundreds.string(from: NSNumber(value: population))
        } else {
            polulationLabel.text = "N/A"
        }

        if let code = country.alpha2Code,
            let url = URL(string: "https://www.countryflags.io/\(code.lowercased())/flat/64.png") {
            flagImageView.af.setImage(withURL: url, placeholderImage: type(of: self).placeholder, imageTransition: .crossDissolve(0.3))
        } else {
            flagImageView.image = type(of: self).placeholder
        }
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
