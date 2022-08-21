//
//  ViewController.swift
//  test int
//
//  Created by Артём Скрипкин on 21.08.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        view.backgroundColor = .white
        blurView.configure(image: avatarImage)
    }
    
    private func layout() {
        layoutTableView()
        layoutBlurView()
    }
    
    private func layoutTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func layoutBlurView() {
        view.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: tableView.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            blurView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            blurView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor)
        ])
    }
    
    fileprivate lazy var blurView: BlurView = .fromNib(BlurView.self)

    private lazy var tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.registerHeaderFooterNib(HeaderView.self)
        return $0
    }(UITableView())
    
    fileprivate let avatarImage: UIImage = UIImage(named: "IMG_5935") ?? UIImage()
    private var isShowed = false
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Test"
        cell.isUserInteractionEnabled = !isShowed
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueHeaderFooter(HeaderView.self)
        header.configure(label: "Hello!", image: avatarImage)
        header.delegate = self
        return header
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        vc.navigationItem.title = "Info Test"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

//MARK: - HeaderViewDelegate

extension ViewController: HeaderViewDelegate {
    func didTapAvatar(frame: CGRect) {
        blurView.animateQuickLook(from: frame)
    }
}
