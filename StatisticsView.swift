//
//  StatisticsView.swift
//  personal_wealth_manager
//
//  Created by dsu_student on 2025/12/09.
//

import Foundation

// 📁 StatisticsData.swift (또는 StatisticsView.swift 상단)

// 카테고리별 합계 금액을 저장하는 구조체
struct CategoryTotal: Identifiable {
    let id = UUID()
    let categoryName: String
    let totalAmount: Double
    let colorHex: String
}

// 기간 선택을 위한 Enum
enum TimePeriod: String, CaseIterable, Identifiable {
    case daily = "일별"
    case weekly = "주별"
    case monthly = "월별"
    
    var id: String { self.rawValue }
}
