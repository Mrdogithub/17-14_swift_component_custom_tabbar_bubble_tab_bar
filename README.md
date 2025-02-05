关键字: 自定义标签 | 视图切换 | 

![效果](./images/17-14.gif)
# 介绍
展示底部tabbar 在激活状态下显示图标对应文本。可跳转到新页面，同时显示另一个tabbar

# 功能 & Thinking

## 1. animation(.defulat) 的动画意图是什么
使用 animation(.default) 的主要目的是为了提升用户界面的交互性和美观性，使得视图的变化更加流畅和易于理解。
#### 意图和用途
1. 平滑过渡：当视图的状态发生变化（例如，属性的更新、视图的添加或删除）时，使用 animation(.default) 可以使这些变化看起来更加平滑和自然，而不是突然发生。
>
2. 增强用户体验：通过动画，用户可以更容易地理解界面元素的变化。例如，当按钮被点击时，相关视图的变化会通过动画来提示用户。
>
3. 默认动画效果：.default 是 SwiftUI 提供的一个预设动画，通常是一个简单的线性动画，持续时间和曲线都是系统默认的。它可以快速应用于视图，而无需手动定义动画的具体参数。

## 2.在逻辑分支中的视图渲染注意事项

> The compiler is unable to type-check this expression in reasonable time; try breaking up the expression into distinct sub-expressions 
> 这个错误通常是由于 Swift 编译器在处理复杂的视图层次结构时遇到性能问题。

``` swift 
// MARK: 最佳实践：对于复杂的视图层级，建议将其抽取为独立的子视图组件
HStack {
    if !self.detail {
        // 使用一个函数来创建按钮
        ForEach(0..<4) { i in
            self.createButton(index: i)
            if i < 3 { Spacer() } // 在按钮之间添加间隔
        }
    } else {
        // ... existing code for detail view ...
    }
}
```
在 SwiftUI 中，当处理包含条件分支的视图渲染时，需要注意以下几个重要点：
1. 视图一致性 ：
- 不同分支的视图层级结构应该保持相对一致
- 避免在不同分支中出现过大的视图结构差异，这可能会导致动画过渡不自然
2. 性能考虑 ：
- 条件分支中的视图会被 SwiftUI 持续监控状态变化
- **对于复杂的视图层级，建议将其抽取为独立的子视图组件**
3. 状态管理 ：
- 确保状态变量（如这里的 detail ）的变化能够正确触发视图更新
- 注意状态变量的作用域和生命周