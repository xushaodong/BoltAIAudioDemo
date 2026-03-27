# Harmony 音乐播放器

一个使用 ArkTS 语言开发的精美鸿蒙音乐播放器应用。

## 功能特性

- 播放、暂停、停止音乐
- 上一首、下一首切换
- 播放模式切换（顺序、单曲循环、随机）
- 进度条拖动控制
- 播放列表管理
- 精美的 UI 设计

## 技术栈

- ArkTS 语言
- HarmonyOS AVPlayer API
- 声明式 UI 开发
- 响应式状态管理

## 快速开始

1. 使用 DevEco Studio 打开项目
2. 连接 HarmonyOS 设备或模拟器
3. 点击运行按钮

详细说明请查看 `PROJECT_GUIDE.md`

## 项目结构

```
├── entry/src/main/ets/
│   ├── components/      # UI 组件
│   ├── data/           # 数据层
│   ├── model/          # 数据模型
│   ├── pages/          # 页面
│   ├── service/        # 业务服务
│   └── utils/          # 工具类
```

## 音乐资源

项目包含 5 首示例音乐，详见 `MUSIC_RESOURCES.md`