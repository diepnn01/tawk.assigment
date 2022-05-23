//
//  UserItemCell.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 22/05/2022.
//

import UIKit
import Combine
class UserItemCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var noteIcon: UIImageView!
    var viewModel: UsersCellViewModel?
    var stores = Set<AnyCancellable>()
    override func prepareForReuse() {
        super.prepareForReuse()
        stores = Set<AnyCancellable>()
        viewModel = nil
        contentView.backgroundColor = UIColor.white
        avatarImageView.image = UIImage(named: "default_avatar")
        noteIcon.isHidden = true

    }
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = 22
        avatarImageView.clipsToBounds = true
    }
    
    func setUserInfo(_ userId: String) {
        self.showSkeletons()
        viewModel = UsersCellViewModelImpl(model: UsersCellModel(id: userId), api: AppDependency.shared.appApi, persistence: AppDependency.shared.persistence)
        viewModel?.onGetUser
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] user in
                self?.nameLabel.backgroundColor = .clear
                self?.userNameLabel.backgroundColor = .clear
                self?.avatarImageView.backgroundColor = .clear
                self?.nameLabel.text = user?.name ?? "name"
                self?.userNameLabel.text = user?.login ?? "username"
                self?.avatarImageView.loadImage(url: user?.avatarURL ?? "")
            }).store(in: &stores)
        viewModel?.onGetNote
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] note in
                self?.noteIcon.isHidden = (note ?? "").isEmpty
            }).store(in: &stores)
        viewModel?.onCheckSelected
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] selected in
                self?.contentView.backgroundColor = selected ? UIColor.gray:UIColor.white
            }).store(in: &stores)
        
        viewModel?.loadData()
    }
    
    func showSkeletons() {
        nameLabel.text = ""
        userNameLabel.text = ""
        nameLabel.backgroundColor = .lightGray
        userNameLabel.backgroundColor = .lightGray
        avatarImageView.backgroundColor = .lightGray
        avatarImageView.image = nil
        noteIcon.isHidden = true
    }
}
