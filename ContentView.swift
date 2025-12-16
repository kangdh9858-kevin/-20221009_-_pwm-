//
//  ContentView.swift
//  personal_wealth_manager
//
//  Created by dsu_student on 2025/12/02.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @StateObject private var viewModel = ExpenseViewModel()
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        TabView {
            // 탭 1: 지출 입력
            AddExpenseView(viewModel: viewModel)
                .tabItem {
                    Label("입력", systemImage: "plus.circle.fill")
                }

            // 탭 2: 소비 내역 조회
            HistoryView(viewModel: viewModel)
                .tabItem {
                    Label("내역", systemImage: "list.bullet.clipboard.fill")
                }

            // 탭 3: 통계/시각화
            StatisticsView()
                .tabItem {
                    Label("통계", systemImage: "chart.pie.fill")
                }
        }
        .onAppear {
            // CoreData context를 ViewModel에 연결
            viewModel.setContext(context: viewContext)
        }
    }
}
