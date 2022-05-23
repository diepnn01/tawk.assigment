//
//  UserBasicInfoView.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 22/05/2022.
//

import UIKit

class UserBasicInfoView: BaseXibView {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var blogLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var infoContainerView: UIStackView!
    override func setUpUI() {
        self.infoContainerView.layer.borderWidth = 1
        self.infoContainerView.layer.borderColor = UIColor.gray.cgColor
    }
    
    func setData(user: UserEntity?) {
        nameLabel.text = "Name: \(user?.name ?? "")"
        companyLabel.text = "Company: \(user?.company ?? "")"
        blogLabel.text = "Blog: \(user?.blog ?? "")"
        followerLabel.text = "Followers: \(user?.followers ?? 0)"
        followingLabel.text = "Following: \(user?.following ?? 0)"
    }
}
