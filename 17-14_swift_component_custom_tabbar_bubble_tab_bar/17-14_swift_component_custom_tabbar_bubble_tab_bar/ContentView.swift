//
//  ContentView.swift
//  17-14_swift_component_custom_tabbar_bubble_tab_bar
//
//  Created by 于鹏 on 2025/2/5.
//

import SwiftUI

// MARK: - 主内容视图
struct ContentView: View {
    var body: some View {
        Home()
    }
}

// MARK: - 主页面视图
struct MainView : View {
    // MARK: Properties
    @Binding var detail : Bool
    @Binding var currentTabName: String
    
    var body: some View {
        VStack {
            HStack {
                Text("Hi,")
                    .font(.title)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                
                Text("BeeDev!")
                    .font(.title)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    self.detail.toggle()
                }, label: {
                    Image(systemName: "message.fill")
                        .font(.title)
                        .foregroundColor(.orange)
                })
            }
            .padding()
            Spacer()
            Text(self.currentTabName)
                .font(.title)
                .foregroundColor(.orange)
            Spacer()
        }
    }
}


struct DetailView : View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer() // 添加上方的 Spacer
                Text("详情")
                    .fontWeight(.bold)
                    .font(.title)
                  Spacer() // 添加下方的 Spacer
            }
            .padding()
            .frame(width:geometry.size.width, height: geometry.size.height)
            
        }
    }
}

// MARK: - 首页容器视图
struct Home : View {
    // MARK: Properties
    @State var index: Int = 0
    @State var detail = false
    @State var currentTabName = "首页"
    
    var body: some View {
        VStack(spacing: 0) {
            
            if !self.detail {
                MainView(detail: self.$detail,currentTabName: self.$currentTabName)
            }
            else {
                DetailView()
            }
            
            // MARK: 自定义标签栏
            CustomNavigation(index: self.$index, detail: self.$detail, currentTabName: self.$currentTabName, title: self.detail ? "Hi BeeDev" : "")
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

// MARK: - 自定义导航栏
struct CustomNavigation : View {
    // MARK: Properties
    @Binding var index: Int
    @Binding var detail : Bool
    @Binding var currentTabName : String
    var title = ""
    
    var body: some View {
        HStack {
            if !self.detail {
                // MARK: 为何要使用For 循环 ？
                // MARK: CustomNavigation 中的 HStack 如果包含多个条件和嵌套的 Button，这可能导致编译器在推断类型时变得缓慢。
                ForEach(0..<4) { i in
                    self.createButton(index: i,currentTabName: self.currentTabName)
                    if i < 3 { Spacer() } // 在按钮之间添加间隔
                }
            } else {
                Button(action: {
                    self.detail.toggle()
                }, label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .foregroundColor(.white)
                })
                
                Image("pic")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .padding(.horizontal, 8)
                
                Text(self.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "ellipsis.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                })
            }
        }
        .padding(.vertical)
        .padding(.horizontal,self.detail ? 20 : 25)
        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
        .background(Color.orange)
        .cornerRadius(25)
        .animation(.default)
    }


    // 创建按钮的函数
    // MARK: - 辅助方法
    private func createButton(index: Int,currentTabName: String) -> some View {
        // MARK: 标签栏配置
        let titles = ["首页", "查询", "新增", "收藏"]
        let images = ["house", "magnifyingglass", "plus", "heart.fill"]
        
       
        return Button(action: {
            self.index = index
            self.currentTabName = titles[index]
        }, label: {
            HStack(spacing: 15) {
                Image(systemName: images[index])
                if self.index == index {
                    Text(titles[index])
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
        })
        .foregroundColor(.white)
        .background(Color.red.opacity(self.index == index ? 1 : 0))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - 预览
#Preview {
    ContentView()
}
