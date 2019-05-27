import UIKit

var dataJsonEmployee = """
[
{
"id": "id01",
"name": "you_know_who",
"job_title": "new Dev",
"age": 16,
"mentor": {
"id": "id987",
"name": "Hạnh",
"position": "PM",
"age": 20
}
},
{
"id": "id02",
"name": "Hướng",
"job_title": "Fresher cứng",
"age": 19,
"mentor": {
"id": "id089",
"name": "Bắc",
"job_title": "Team Lít",
"age": 25
}
},
{
"id": "id987",
"name": "Hạnh",
"job_title": "PM",
"age": 20,
"mentee": {
"name": "TuanB",
"position": "new Dev",
"age": 16
}
},
{
"id": "id0981",
"name": "Nam",
"job_title": "Dev",
"age": 25,
"mentor": {
"id": "id321",
"name": "Hanh",
"position": "PM",
"age": 20
}
},
{
"id": "id089",
"name": "Bắc",
"job_title": "Team Lít",
"age": 25,
"mentor": {
"id": "id321",
"name": "Kiên",
"position": "SM",
"age": 27
},
"mentee": {
"id": "id02",
"name": "Hướng",
"job_title": "Fresher cứng",
"age": 19
}
}
]
"""

class Employee {
    var id: String!
    var name: String!
    var job_title: String!
    var age: Int!
    var mentor: Employee!
    var mentee: Employee!
    
    init() {
    }
    
    init(id: String!, name: String!, job_title: String!, age: Int!, mentor: Employee!) {
        self.id = id
        self.name = name
        self.job_title = job_title
        self.age = age
        self.mentor = mentor
    }
    
    init(id: String!, name: String!, job_title: String!, age: Int!, mentee: Employee!) {
        self.id = id
        self.name = name
        self.job_title = job_title
        self.age = age
        self.mentee = mentee
    }
}


class EmployeeManager {
    class func getDataEmployee(dataJsonEmployee: String!) -> [Employee] {
        var employeeArr = [Employee]()
        if let dataString = dataJsonEmployee, let data = dataString.data(using: .utf8) {
            do {
                var arrayData = try JSONSerialization.jsonObject(with: data, options: []) as?  [AnyObject]
                if let arrayData = arrayData {
                    for employee  in arrayData {
                        //get employeeData
                        if let empoyeeDic = employee as? [String: AnyObject] {
                            let employeeItem = convetDatatoEmployeeClass(employeeDict: empoyeeDic)
                            // get mentor
                            if let metor = empoyeeDic["mentor"] as? [String: AnyObject] {
                                let mentorModel = convetDatatoEmployeeClass(employeeDict: metor)
                                employeeItem.mentor = mentorModel
                            }
                            // get mentee
                            if let mentee = empoyeeDic["mentee"] as? [String: AnyObject] {
                                let menteeModel = convetDatatoEmployeeClass(employeeDict: mentee)
                                employeeItem.mentee = menteeModel
                            }
                            employeeArr.append(employeeItem)
                        }
                        
                        
                    }
                }
                
                
            } catch let error {
                print(error)
            }
        }
        return employeeArr
    }
    
    class func convetDatatoEmployeeClass(employeeDict: [String: AnyObject]) -> Employee {
        
        let employeeModel = Employee()
        if let id = employeeDict["id"] as? String {
            employeeModel.id = id
        }
        
        if let name = employeeDict["name"] as? String {
            employeeModel.name = name
        }
        
        if let job = employeeDict["job_title"] as? String
        {
            
            employeeModel.job_title = job
        }
        if let age = employeeDict["age"] as? Int {
            employeeModel.age = age
        }
        return employeeModel
    }
    // addMentor
    class func addMentor(idEmp: String!, mentor: Employee!, empArr: [Employee]!) -> Employee! {
        if let idEmp = idEmp,
            let mentor = mentor,
            let  empArr = empArr {
            for employee in empArr {
                if employee.id == idEmp {
                    if let haveMentor =  employee.mentor {
                        print("Da co mentor ko the them")
                        return nil
                    }
                    // neu chua co mentor thi them mentor
                    employee.mentor = mentor
                    print("addmenttor: \(mentor.name)")
                    return employee
                }
            }
        }
        return nil
    }
    // addMentee
    class func addMentee(idEmp: String!, mentee: Employee!, empArr: [Employee]!) -> Employee! {
        if let idEmp = idEmp,
            let mentee = mentee,
            let  empArr = empArr {
            for employee in empArr {
                if employee.id == idEmp {
                    if let haveMentor =  employee.mentee {
                        print("Da co mentee ko the them")
                        return nil
                    }
                    // neu chua co mentor thi them mentor
                    employee.mentee = mentee
                    print("addmentee: \(mentee.name)")
                    return employee
                }
            }
        }
        return nil
    }
    // deleteMentor
    class func deleteMentor(id: String!, empArr: [Employee]!) -> Employee! {
        if let idEmployee = id,
            let empArr = empArr  {
            for employee in empArr {
                if employee.id == idEmployee {
                    employee.mentor = nil
                    return employee
                }
            }
        }
        return nil
    }
    // deleteMentee
    class func deleteMentee(id: String!, empArr: [Employee]!) -> Employee! {
        if let idEmployee = id,
            let empArr = empArr  {
            for employee in empArr {
                if employee.id == idEmployee {
                    employee.mentee = nil
                    return employee
                }
            }
        }
        return nil
    }
    
    // editMentor
    class func editMentor(id: String!, mentor: Employee!, empArr: [Employee]!) -> Employee! {
        if let idEmployee = id,
            let mentor = mentor,
            let empArr = empArr  {
            for employee in empArr {
                if employee.id == idEmployee {
                    employee.mentor = mentor
                    return employee
                }
            }
        }
        return nil
    }
    // editMentee
    class func editMentee(id: String!, mentee: Employee!, empArr: [Employee]!) -> Employee! {
        if let idEmployee = id,
            let mentee = mentee,
            let empArr = empArr  {
            for employee in empArr {
                if employee.id == idEmployee {
                    employee.mentee = mentee
                    return employee
                }
            }
        }
        return nil
    }
    
}

let emArra = EmployeeManager.getDataEmployee(dataJsonEmployee: dataJsonEmployee)


// KET QUA:
// Add new mentor
let newMentor = Employee.init(id: "1234", name: "Dung", job_title: "Dev", age: 23, mentor: nil)
let new = EmployeeManager.addMentor(idEmp: "id987", mentor: newMentor, empArr: emArra)
print("Da them new mentor ten: \(new?.mentor.name ?? "")")

// add new mentee
let newMentee = Employee.init(id: "1353", name: "Hai", job_title: "Dev", age: 23, mentor: nil)
let add_employee = EmployeeManager.addMentee(idEmp: "id987", mentee: newMentor, empArr: emArra)
print("Da them new mentee: \(add_employee?.mentor?.name ?? "")")

// delete mentor
let deleteMentor = EmployeeManager.deleteMentor(id: "id02", empArr: emArra)
print("Xoa Mentor: \(deleteMentor?.mentor)")

// delete mentee
let deleteMetee = EmployeeManager.deleteMentee(id: "id02", empArr: emArra)
print("Xoa Metee: \(deleteMentor?.mentee)")

// edit mentor
let edit_mentor = Employee.init(id: "id089", name: "DungLe", job_title: "Android", age: 11, mentor: nil)
let editMentor = EmployeeManager.editMentor(id: "id02", mentor: edit_mentor, empArr: emArra)
print("Edit success : \(editMentor?.mentor?.name ?? "")")

//edit mentee
let edit_mentee = Employee.init(id: "id02", name: "HoangLong", job_title: "ReactNative", age: 22, mentee: nil)
let editMentee = EmployeeManager.editMentee(id: "id089", mentee: edit_mentee, empArr: emArra)
print("Edit success : \(editMentee?.mentee?.name ?? "")")
