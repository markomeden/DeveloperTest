//
//  TeachersViewController.swift
//  Developer Test
//
//  Created by Marko Meden User on 06/07/2023.
//

import UIKit

class TeachersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
        fetchTeachers()
    }
    

    // MARK: - Setup
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TeacherCardTableViewCell", bundle: nil), forCellReuseIdentifier: String(describing: TeacherCardTableViewCell.self))
    }
    
    func fetchTeachers() {
        Task {
            do {
                let teachers = try await fetchTeachersFromAPI()
                print(teachers)
            } catch {
                print(error)
            }
        }
    }
}

extension TeachersViewController : UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}

extension TeachersViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeacherCardTableViewCell", for: indexPath) as! TeacherCardTableViewCell
        cell.selectionStyle = .none
        return cell
    }
}

extension TeachersViewController {
    func fetchTeachersFromAPI() async throws -> [Teacher] {
        let url = URL(string: "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/teachers")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode([Teacher].self, from: data)
        return decoded
    }
}
