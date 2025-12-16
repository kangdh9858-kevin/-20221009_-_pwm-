//
//  expense.swift
//  personal_wealth_manager
//
//  Created by dsu_student on 2025/12/02.
//

import Foundation
import CoreData

// 1. Core Data 엔티티임을 명시하고 NSManagedObject를 상속
@objc(Expense)
public class Expense: NSManagedObject {
    // ⚠️ 경고: 이 클래스 내부에는 속성(amount, date, memo)과 관계(category)를 정의할 필요가 없습니다.
    // (Xcode가 자동으로 생성하는 Expense+CoreDataProperties.swift 파일에 정의됨)
}

// Expense 모델은 초기 데이터가 필요 없으므로, Core Data 클래스 외에 별도의 extension은 필요 없습니다.
