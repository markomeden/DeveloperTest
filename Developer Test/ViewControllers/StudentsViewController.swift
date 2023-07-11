//
//  StudentsViewController.swift
//  Developer Test
//
//  Created by Marko Meden User on 06/07/2023.
//

import UIKit
import Localize_Swift

class StudentsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var students: [Student] = []
    var schools: [School] = []
    var studentDescription: [Description] = []
    let servicesView = ServicesView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        servicesView.delegate = self
        setupTableView()
        fetchStudents()
        changeLanguage()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeLanguage), name: NSNotification.Name(rawValue: "changeLanguage"), object: nil)
    }
    
    @objc private func changeLanguage() {
        tabBarItem.title = "Students".localized()
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
    
    func fetchStudents() {
        Task {
            do {
                students = []
                schools = []
                studentDescription = []
                do {
                    students = try await fetchStudentsFromAPI()
                } catch {
                    self.showErrorDialogNoInternet()
                }
                //                print(students)
                tableView.reloadData()
                
                for item in students {
                    schools.append(try await fetchSchool(id: item.school_id))
                }
                //                print(schools)
                tableView.reloadData()
                
                for item in students {
                    studentDescription.append(try await fetchStudentDescription(id: item.id))
                }
                print(studentDescription)
                //                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
}

extension StudentsViewController : UITableViewDelegate {
    
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
        if studentDescription.count > indexPath.row {
            let viewController = AppManager.shared.instantiateViewController(viewController: "DetailsViewController", storyboard: "Main") as! DetailsViewController
            viewController.student = students[indexPath.row]
            viewController.school = schools[indexPath.row]
            viewController.description_ = studentDescription[indexPath.row]
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension StudentsViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeacherCardTableViewCell", for: indexPath) as! TeacherCardTableViewCell
        cell.setupCell(student: students[indexPath.row])
        if !schools.isEmpty {
            cell.setupCell(school: schools[indexPath.row])
        }
        if !studentDescription.isEmpty {
            cell.setupCell(description: studentDescription[indexPath.row])
        }
        cell.setupIndex(index: indexPath.row)
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
}

extension StudentsViewController {
    func fetchStudentsFromAPI() async throws -> [Student] {
        let url = URL(string: Environment.studentsAPI)!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode([Student].self, from: data)
        return decoded
    }
    
    func fetchSchool(id: Int) async throws -> School {
        let url = URL(string: "\(Environment.schoolsAPI)\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(School.self, from: data)
        return decoded
    }
    
    func fetchStudentDescription(id: Int) async throws -> Description {
        let url = URL(string: "\(Environment.studentsAPI)/\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(Description.self, from: data)
        return decoded
    }
}

extension StudentsViewController : ContactCellDelegate {
    func buttonPressed(index: Int) {
        print("selected contact with index \(index)")
        let window = UIApplication.shared.windows.last!
        window.addSubview(servicesView)
    }
}

//extension StudentsViewController : ContactViewDelegate {
//    func buttonPressed() {
//        self.view.addSubview(servicesView)
//    }
//}

extension StudentsViewController : ServiceLabelDelegate {
    func cancelPressed() {
        servicesView.removeFromSuperview()
    }
}
