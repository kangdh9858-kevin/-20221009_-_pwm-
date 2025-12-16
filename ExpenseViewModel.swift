//
//  ExpenseViewModel.swift
//  personal_wealth_manager
//
//  Created by dsu_student on 2025/12/02.
//

// 데이터를 조회, 추가, 수정 
// 📁 ExpenseViewModel.swift (최종 수정)
import Foundation
import CoreData
import SwiftUI // SwiftUI는 ObservableObject 때문에 필요

class ExpenseViewModel: ObservableObject {
    
    private var context: NSManagedObjectContext?
    
    func setContext(context: NSManagedObjectContext) {
        self.context = context
        initializeCategories()
    }
    
    // MARK: - 지출 CRUD (FR-3.1.1, FR-3.1.3)
    
    func saveExpense(amount: Double, date: Date, memo: String, category: Category?) {
        guard let context = self.context else { return }
        
        // 🚨 수정: Core Data 객체 생성 및 속성 할당
        let newExpense = Expense(context: context)
        newExpense.amount = amount
        newExpense.date = date
        newExpense.memo = memo
        newExpense.category = category // 관계 설정
        
        do {
            try context.save()
        } catch {
            print("Error saving expense: \(error.localizedDescription)")
        }
    }

    // ... (deleteExpense 함수는 이전 코드가 맞음)
    
    // MARK: - 초기 카테고리 설정 (FR-3.1.4)

    private func initializeCategories() {
        guard let context = self.context else { return }
        
        do {
            // 🚨 수정: Core Data의 NSFetchRequest 사용
            let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
            let existingCategories = try context.fetch(fetchRequest)
            
            if existingCategories.isEmpty {
                // 🚨 수정: Category.initialCategoryData 사용
                for data in Category.initialCategoryData {
                    let newCategory = Category(context: context)
                    newCategory.name = data.name
                    newCategory.colorHex = data.colorHex
                    // *Core Data는 속성이 Optional일 수 있으므로, name과 colorHex를 언래핑 없이 사용 시
                    // nil coalescing (`data.name ?? ""`) 등을 고려해야 하지만,
                    // CategoryData는 Non-optional로 정의되어 있다고 가정합니다.
                }
                
                try context.save()
            }
        } catch {
            print("Failed to initialize categories: \(error.localizedDescription)")
        }
    }
}
