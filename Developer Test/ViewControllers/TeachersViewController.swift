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
    let servicesView = ServicesView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        servicesView.delegate = self
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
        servicesView.configureLabels()
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
                do {
                    teachers = try await fetchTeachersFromAPI()
                } catch {
                    self.showErrorDialogNoInternet()
                }
                //                print(teachers)
                tableView.reloadData()
                
                for item in teachers {
                    schools.append(try await fetchSchool(id: item.school_id))
                }
                //                print(schools)
                tableView.reloadData()
                
                for item in teachers {
                    teacherDescriptions.append(try await fetchTeacherDescription(id: item.id))
                }
                //                print(teacherDescriptions)
                //                tableView.reloadData()
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
        if teacherDescriptions.count > indexPath.row {
            print(teacherDescriptions.count)
            print(indexPath.row)
            let viewController = AppManager.shared.instantiateViewController(viewController: "DetailsViewController", storyboard: "Main") as! DetailsViewController
            viewController.teacher = teachers[indexPath.row]
            viewController.school = schools[indexPath.row]
            viewController.description_ = teacherDescriptions[indexPath.row]
            self.navigationController?.pushViewController(viewController, animated: true)
        }
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
        cell.setupCell(teacher: teachers[indexPath.row])
        if !schools.isEmpty {
            cell.setupCell(school: schools[indexPath.row])
        }
        if !teacherDescriptions.isEmpty {
            cell.setupCell(description: teacherDescriptions[indexPath.row])
        }
        cell.setupIndex(index: indexPath.row)
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
}

extension TeachersViewController {
    func fetchTeachersFromAPI() async throws -> [Teacher] {
        let url = URL(string: Environment.teachersAPI)!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode([Teacher].self, from: data)
        return decoded
    }
    
    func fetchSchool(id: Int) async throws -> School {
        let url = URL(string: "\(Environment.schoolsAPI)\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(School.self, from: data)
        return decoded
    }
    
    func fetchTeacherDescription(id: Int) async throws -> Description {
        let url = URL(string: "\(Environment.studentsAPI)/\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(Description.self, from: data)
        return decoded
    }
}

extension TeachersViewController : ContactCellDelegate {
    func buttonPressed(index: Int) {
        print("selected contact with index \(index)")
        let window = UIApplication.shared.windows.last!
        window.addSubview(servicesView)
    }
}

//extension TeachersViewController : ContactViewDelegate {
//    func buttonPressed() {
//        self.view.addSubview(servicesView)
//    }
//}

extension TeachersViewController : ServiceLabelDelegate {
    func cancelPressed() {
        servicesView.removeFromSuperview()
    }
}
