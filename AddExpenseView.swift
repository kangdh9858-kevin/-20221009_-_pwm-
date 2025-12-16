//
//  AddExpenseView.swift
//  personal_wealth_manager
//
//  Created by dsu_student on 2025/12/02.
//

import Foundation

import SwiftUI
import CoreData 

struct AddExpenseView: View {
    @ObservedObject var viewModel: ExpenseViewModel
    
    @Query var categories: [Category] // 카테고리 목록을 SwiftData에서 쿼리
    
    @State private var amount: Double?
    @State private var selectedCategory: Category?
    @State private var date: Date = Date()
    @State private var memo: String = ""
    
    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            Form {
                // 1. 금액 입력
                Section("금액") {
                    TextField("0.00", value: $amount, format: .currency(code: "KRW"))
                        .keyboardType(.decimalPad)
                }

                // 2. 카테고리 선택
                Section("분류") {
                    Picker("카테고리", selection: $selectedCategory) {
                        Text("선택 안 함").tag(nil as Category?)
                        ForEach(categories) { category in
                            Text(category.name).tag(category as Category?)
                        }
                    }
                }

                // 3. 날짜 및 시간 선택 (FR-3.1.2)
                Section("날짜") {
                    DatePicker("날짜 및 시간", selection: $date)
                }

                // 4. 메모 입력
                Section("메모") {
                    TextField("지출에 대한 간단한 설명", text: $memo)
                }
                
                // 저장 버튼
                Button("지출 저장") {
                    saveExpense()
                }
                .disabled(amount == nil || amount! <= 0 || selectedCategory == nil) // 유효성 검사
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("➕ 새 지출 기록")
            .alert("저장 성공", isPresented: $showingAlert) {
                Button("확인", role: .cancel) { /* 초기화 로직은 저장 함수에 포함 */ }
            }
        }
    }

    private func saveExpense() {
        guard let finalAmount = amount, finalAmount > 0, let finalCategory = selectedCategory else { return }

        viewModel.saveExpense(
            amount: finalAmount,
            date: date,
            memo: memo,
            category: finalCategory
        )
        
        // 입력 필드 초기화
        amount = nil
        date = Date()
        memo = ""
        // selectedCategory는 초기화하지 않고 마지막 사용 카테고리를 유지하는 것도 UX적으로 좋습니다.
        
        showingAlert = true
    }
}
