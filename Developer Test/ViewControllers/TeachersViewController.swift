//
//  TeachersViewController.swift
//  Developer Test
//
//  Created by Marko Meden User on 06/07/2023.
//

import UIKit
import Localize_Swift

class TeachersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var teachers: [Teacher] = []
    var schools: [School] = []
    var teacherDescriptions: [Description] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
        fetchTeachers()
        changeLanguage()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeLanguage), name: NSNotification.Name(rawValue: "changeLanguage"), object: nil)
        
    }
    
    @objc private func changeLanguage() {
        #if DEBUG
        tabBarItem.title = "Teachers - DEV".localized()
        #else
        tabBarItem.title = "Teachers".localized()
        #endif
        tableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
                teachers = []
                schools = []
                teacherDescriptions = []
                
                teachers = try await fetchTeachersFromAPI()
                
//                print(teachers)
                
                for item in teachers {
                    schools.append(try await fetchSchool(id: item.school_id))
                }
//                print(schools)
                
                for item in teachers {
                    teacherDescriptions.append(try await fetchTeacherDescription(id: item.id))
                }
//                print(teacherDescriptions)
                
                tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = AppManager.shared.instantiateViewController(viewController: "DetailsViewController", storyboard: "Main") as! DetailsViewController
        viewController.teacher = teachers[indexPath.row]
        viewController.school = schools[indexPath.row]
        viewController.description_ = teacherDescriptions[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension TeachersViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teachers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeacherCardTableViewCell", for: indexPath) as! TeacherCardTableViewCell
        cell.setupCell(teacher: teachers[indexPath.row], school: schools[indexPath.row], description: teacherDescriptions[indexPath.row])
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
    
    func fetchSchool(id: Int) async throws -> School {
        let url = URL(string: "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/schools/\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(School.self, from: data)
        return decoded
    }
    
    func fetchTeacherDescription(id: Int) async throws -> Description {
        let url = URL(string: "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/teachers/\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(Description.self, from: data)
        return decoded
    }
}
