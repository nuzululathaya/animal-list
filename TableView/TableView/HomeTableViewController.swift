//
//  HomeTableViewController.swift
//  TableView
//
//  Created by Nuzulul Athaya on 07/06/22.
//

import UIKit

class HomeTableViewController: UITableViewController{
    
    var animalList = Animal.listV2()
    
    private lazy var animalTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        title = "Animal"
        setupTableView()
    }
    
    private func setupTableView() {
        animalTableView.delegate = self
        animalTableView.dataSource = self
        animalTableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")

        view.addSubview(animalTableView)

        NSLayoutConstraint.activate([
            animalTableView.topAnchor.constraint(equalTo: view.topAnchor),
            animalTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            animalTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            animalTableView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])

    }

    private func reloadDataTableView() {
        let animals: [Animal] = Animal.listV2()
        animalList = animals
        animalTableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animalList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "CustomCell", for:indexPath)
        guard let listCell = cell as? CustomCell else {
            return cell
        }
        
        let currentAnimal: Animal
        currentAnimal = animalList[indexPath.row]
        
        listCell.fill(with: currentAnimal)
        return listCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailHome()
        let row: Int = indexPath.row
        let animal: Animal = animalList[row]
        vc.animalDetail = animal
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}


class CustomCell: UITableViewCell{
    
    private lazy var animalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var animalTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    private lazy var animalTypeLabel: UILabel = {
       let typeLabel = UILabel()
        typeLabel.numberOfLines = 0
        typeLabel.adjustsFontSizeToFitWidth = true
        typeLabel.font = .systemFont(ofSize: 16, weight: .regular)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
       return typeLabel
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        addSubview(animalImageView)
        addSubview(animalTitleLabel)
        addSubview(animalTypeLabel)

        NSLayoutConstraint.activate([
            animalImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            animalImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            animalImageView.heightAnchor.constraint(equalToConstant: 85),
            animalImageView.widthAnchor.constraint(equalToConstant: 85),

            animalTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            animalTitleLabel.leadingAnchor.constraint(equalTo: animalImageView.trailingAnchor, constant: 10),

            animalTypeLabel.topAnchor.constraint(equalTo: animalTitleLabel.bottomAnchor, constant: 7),
            animalTypeLabel.leadingAnchor.constraint(equalTo: animalImageView.trailingAnchor, constant: 10),
            animalTypeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
    }

    func fill(with animal: Animal) {
        animalImageView.loadImage(resource: animal.photoUrlString)
        animalTitleLabel.text = animal.name
        animalTypeLabel.text = animal.typeOfFood.rawValue
    }

}
