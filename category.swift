//
//  category.swift
//  personal_wealth_manager
//
//  Created by dsu_student on 2025/12/02.
//

import Foundation
import CoreData

// 1. Core Data 엔티티임을 명시하고 NSManagedObject를 상속
@objc(Category)
public class Category: NSManagedObject {
    // ⚠️ 경고: Core Data는 xcdatamodeld 파일을 통해 속성(name, colorHex)과 관계(expenses)를 관리합니다.
    // 따라서 이 기본 클래스 내부에는 @NSManaged 속성을 직접 정의할 필요가 없습니다.
    // (Xcode가 자동으로 생성하는 Category+CoreDataProperties.swift 파일에 정의됨)
}

// 초기 데이터를 관리하기 위한 extension (ViewModel에서 사용)
extension Category {
    // 임시 구조체: 초기 카테고리 데이터를 Swift 코드로 정의
    struct CategoryData {
        let name: String
        let colorHex: String
    }
    
    // ViewModel의 initializeCategories() 함수에서 사용할 초기 데이터
    static var initialCategoryData: [CategoryData] {
        return [
            CategoryData(name: "식비", colorHex: "#4CAF50"),
            CategoryData(name: "교통", colorHex: "#2196F3"),
            CategoryData(name: "쇼핑", colorHex: "#FF9800"),
            CategoryData(name: "문화생활", colorHex: "#2196F3"),
            CategoryData(name: "카페/간식", colorHex: "#FFB300"),
            CategoryData(name: "기타", colorHex: "#795548")
        ]
    }
}
