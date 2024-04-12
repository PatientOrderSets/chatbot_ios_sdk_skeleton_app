//
//  ConfigurationCell.swift
//  NativeSdkTest
//
//  Created by Suhail Thajudeen on 12/04/24.
//

import UIKit

class ConfigurationCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var defaultButton: UISwitch!
    @IBOutlet weak var deleteIcon: UIImageView!
    
    weak var delegate: ConfigurationTableViewCellDelegate?
    var indexPath: IndexPath?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        name.lineBreakMode = .byWordWrapping
        name.numberOfLines=2

        // Enable user interaction for the UIImageView
        deleteIcon.isUserInteractionEnabled = true
        
        // Add tap gesture recognizer to the UIImageView
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(deleteButtonTapped))
        deleteIcon.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    @IBAction func radioButtonTapped(_ sender: UISwitch) {
        guard let indexPath = indexPath else { return }
        delegate?.didSelectDefaultConfiguration(at: indexPath)
    }
    
    @objc func deleteButtonTapped() {
        guard let indexPath = indexPath else { return }
        delegate?.didTapDeleteConfiguration(at: indexPath)
    }
    
}


protocol ConfigurationTableViewCellDelegate: AnyObject {
    func didSelectDefaultConfiguration(at indexPath: IndexPath)
    func didTapDeleteConfiguration(at indexPath: IndexPath)
}
