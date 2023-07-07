//
//  StudentsViewController.swift
//  Developer Test
//
//  Created by Marko Meden User on 06/07/2023.
//

import UIKit

class StudentsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var students: [Student] = []
    var schools: [School] = []
    var studentDescription: [Description] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
        fetchStudents()
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
                
                students = try await fetchStudentsFromAPI()
//                print(students)
                
                for item in students {
                    schools.append(try await fetchSchool(id: item.school_id))
                }
//                print(schools)
                
                for item in students {
                    studentDescription.append(try await fetchStudentDescription(id: item.id))
                }
//                print(studentDescription)
                
                tableView.reloadData()
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
        cell.setupCell(student: students[indexPath.row], school: schools[indexPath.row], description: studentDescription[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

extension StudentsViewController {
    func fetchStudentsFromAPI() async throws -> [Student] {
        let url = URL(string: "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/students")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode([Student].self, from: data)
        return decoded
    }
    
    func fetchSchool(id: Int) async throws -> School {
        let url = URL(string: "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/schools/\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(School.self, from: data)
        return decoded
    }
    
    func fetchStudentDescription(id: Int) async throws -> Description {
        let url = URL(string: "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/students/\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(Description.self, from: data)
        return decoded
    }
}
