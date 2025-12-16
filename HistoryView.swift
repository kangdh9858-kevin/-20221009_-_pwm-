//
//  HistoryView.swift
//  personal_wealth_manager
//
//  Created by dsu_student on 2025/12/09.
//

import SwiftUI
import CoreData

struct HistoryView: View {
    // 1. @FetchRequest: Core Data에서 Expense 객체를 불러오도록 요청합니다.
    //    - sortDescriptors: 날짜를 기준으로 내림차순 정렬 (가장 최근 내역이 위로)
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.date, order: .reverse)],
        animation: .default
    )
    private var expenses: FetchedResults<Expense>

    // 2. ViewModel 참조: 삭제 로직을 처리하기 위해 필요합니다.
    @ObservedObject var viewModel: ExpenseViewModel
    
    // Core Data 컨텍스트 접근: @FetchRequest의 삭제 기능을 위해 필요
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationView {
            List {
                // 내역이 없을 경우 메시지 표시
                if expenses.isEmpty {
                    VStack(alignment: .center) {
                        Spacer()
                        Text("소비 내역이 없습니다.")
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    // 3. 내역을 반복하여 표시
                    ForEach(expenses) { expense in
                        // 지출 항목을 표시하는 Row
                        ExpenseRow(expense: expense)
                    }
                    // 4. 삭제 기능 구현
                    .onDelete(perform: deleteExpenses)
                }
            }
            .navigationTitle("소비 내역")
        }
    }
    
    // 5. 삭제 로직
    private func deleteExpenses(offsets: IndexSet) {
        offsets.forEach { index in
            let expenseToDelete = expenses[index]
            // ViewModel의 삭제 함수를 호출합니다.
            viewModel.deleteExpense(expense: expenseToDelete)
        }
    }
}

// MARK: - Row Subview

// 목록에서 개별 지출 내역을 표시하는 서브 뷰
struct ExpenseRow: View {
    @ObservedObject var expense: Expense

    var body: some View {
        HStack {
            // 카테고리 이름 (nil일 경우 "분류 없음" 표시)
            Text(expense.category?.name ?? "분류 없음")
                .font(.caption)
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                // 카테고리 색상 표시 (Category 엔티티의 colorHex를 사용하여 배경색 설정 필요)
                .background(Color.gray)
                .cornerRadius(10)

            // 메모
            Text(expense.memo ?? "")
                .lineLimit(1)
                .truncationMode(.tail)

            Spacer()

            // 금액
            Text("-\(Int(expense.amount).formatted())원")
                .foregroundColor(.red)
                .font(.headline)
        }
    }
}
