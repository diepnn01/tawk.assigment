//
//  UserDetailViewController.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 22/05/2022.
//

import UIKit
import Combine
class UserDetailViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var basicInfoView: UserBasicInfoView!
    @IBOutlet weak var noteTextView: UITextView!
    var viewModel: UserDetailViewModel!
    var stores = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getUserDetail()
        handleViewModel()
    }

    func handleViewModel() {
        self.viewModel.onGetUser
            .receive(on: DispatchQueue.main)
            .sink { user in
            self.avatarImageView.loadImage(url: user?.avatarURL ?? "")
            self.basicInfoView.setData(user: user)
            self.title = user?.name
        }.store(in: &stores)
        self.viewModel.onGetNote
            .receive(on: DispatchQueue.main)
            .sink { note in
                self.noteTextView.text = note
        }.store(in: &stores)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        self.noteTextView.resignFirstResponder()
        viewModel.saveNote(with: noteTextView.text)
        self.navigationController?.popViewController(animated: true)
    }
}
