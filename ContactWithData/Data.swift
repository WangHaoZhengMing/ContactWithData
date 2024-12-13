//
//  Data.swift
//  ContactWithData
//
//  Created by 郝明翰 on 2024/12/13.
//

import Foundation
// MARK: - ContactRelation 枚举
enum ContactRelation: String, Codable, CaseIterable {
    case family = "Family"
    case friend = "Friend"
    case colleague = "Colleague"
    case classmate = "Classmate"
    case other = "Other"
    
    var localizedName: String {
        switch self {
        case .family: return "家人"
        case .friend: return "朋友"
        case .colleague: return "同事"
        case .classmate: return "同学"
        case .other: return "其他"
        }
    }
}
// MARK: - Contact 结构体
struct Contact: Codable {
    let id: Int
    var firstName: String
    var lastName: String
    var phoneNumbers: [String]
    var emailAddresses: [String]
    var address: String?
    var relation: ContactRelation
    var isFavorite: Bool
}

// 导出数据到 JSON 文件
func exportContactsToJSON(contacts: [Contact], to filename: String) {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    do {
        let data = try encoder.encode(contacts)
        let url = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent(filename)
        try data.write(to: url)
        print("Contacts exported to \(filename)")
    } catch {
        print("Failed to export contacts: \(error)")
    }
}

// 从 JSON 文件导入数据
func importContactsFromJSON(from filename: String) -> [Contact]? {
    let decoder = JSONDecoder()
    do {
        let url = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent(filename)
        let data = try Data(contentsOf: url)
        let contacts = try decoder.decode([Contact].self, from: data)
        print("Contacts imported from \(filename)")
        return contacts
    } catch {
        print("Failed to import contacts: \(error)")
        return nil
    }
}

// 示例使用
let contacts = [
    Contact(id: 1, firstName: "John", lastName: "Doe", phoneNumbers: ["123-456-7890"], emailAddresses: ["john.doe@example.com"], address: "123 Main St", relation: .friend, isFavorite: false),
    Contact(id: 2, firstName: "Jane", lastName: "Doe", phoneNumbers: ["987-654-3210"], emailAddresses: ["jane.doe@example.com"], address: "456 Elm St", relation: .colleague, isFavorite: true)
]

let filename = "contacts.json"

// 导出联系人到 JSON 文件
exportContactsToJSON(contacts: contacts, to: filename)

// 从 JSON 文件导入联系人
if let importedContacts = importContactsFromJSON(from: filename) {
    for contact in importedContacts {
        print("Imported contact: \(contact.firstName) \(contact.lastName)")
    }
}
