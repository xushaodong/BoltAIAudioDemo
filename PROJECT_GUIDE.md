# 鸿蒙音乐播放器项目指南

## 项目概述

这是一个使用 ArkTS 语言开发的鸿蒙音乐播放器应用，采用最新的 HarmonyOS API，实现了完整的音乐播放功能。

## 项目结构

```
project/
├── entry/src/main/
│   ├── ets/
│   │   ├── components/          # UI组件
│   │   │   ├── PlayerControls.ets    # 播放控制组件
│   │   │   ├── ProgressBar.ets       # 进度条组件
│   │   │   └── SongItem.ets          # 歌曲列表项组件
│   │   ├── data/                # 数据层
│   │   │   └── SongData.ets          # 音乐数据
│   │   ├── entryability/        # 应用入口
│   │   │   └── EntryAbility.ets      # 主入口
│   │   ├── model/               # 数据模型
│   │   │   └── MusicModel.ets        # 音乐相关模型定义
│   │   ├── pages/               # 页面
│   │   │   └── Index.ets             # 主页面
│   │   ├── service/             # 业务服务
│   │   │   └── MusicPlayerService.ets # 播放器核心服务
│   │   └── utils/               # 工具类
│   │       └── TimeUtils.ets         # 时间格式化工具
│   ├── resources/               # 资源文件
│   │   └── base/
│   │       ├── element/         # 颜色、字符串等
│   │       └── profile/         # 配置文件
│   └── module.json5             # 模块配置
├── build-profile.json5          # 构建配置
└── package.json                 # 项目配置
```

## 核心功能

### 1. 音乐播放控制
- **播放/暂停**: 点击中央播放按钮
- **上一首/下一首**: 点击左右切歌按钮
- **播放模式**: 支持顺序播放、单曲循环、随机播放
- **进度控制**: 拖动进度条跳转播放位置

### 2. 播放器服务 (MusicPlayerService)
使用 HarmonyOS 的 `media.AVPlayer` API 实现：
- 音频播放状态管理
- 播放队列管理
- 播放模式切换
- 播放进度更新
- 事件监听和回调

### 3. 用户界面
- **播放器主界面**: 大封面展示，精美的播放控制
- **播放列表**: 显示所有歌曲，支持点击切换
- **实时更新**: 播放状态、进度、歌曲信息实时同步
- **暗色主题**: 参照主流音乐应用的深色设计

## 技术特点

### 1. ArkTS 语言规范
- 严格遵守 ArkTS 语法规范
- 使用声明式 UI 语法
- 响应式状态管理(@State, @Prop)
- 组件化开发

### 2. AVPlayer API 使用
```typescript
// 创建播放器
this.avPlayer = await media.createAVPlayer();

// 设置音频源
this.avPlayer.url = song.audioUrl;

// 准备播放
await this.avPlayer.prepare();

// 开始播放
await this.avPlayer.play();

// 暂停
await this.avPlayer.pause();

// 跳转
await this.avPlayer.seek(time);
```

### 3. 状态管理
使用观察者模式实现播放状态同步：
- onStateChange: 播放状态变化回调
- onTimeUpdate: 播放进度更新回调
- onSongChange: 歌曲切换回调

## 如何运行

### 环境要求
1. HarmonyOS DevEco Studio 4.0 或更高版本
2. HarmonyOS SDK API 10 或更高版本
3. HarmonyOS 设备或模拟器

### 运行步骤
1. 使用 DevEco Studio 打开项目
2. 等待项目索引完成
3. 连接 HarmonyOS 设备或启动模拟器
4. 点击运行按钮（Run）或使用快捷键

### 注意事项
- 确保设备已开启开发者模式
- 首次运行需要安装应用到设备
- 网络播放需要授予网络权限

## 音乐资源

项目包含 5 首示例音乐：
1. 夜的钢琴曲 - 石进
2. 星空 - 理查德·克莱德曼
3. 雨的印记 - Yiruma
4. 天空之城 - 久石让
5. 月光 - 贝多芬

详细信息请查看 `MUSIC_RESOURCES.md`

## UI 设计参考

本应用 UI 设计参考了主流音乐应用：
- **配色方案**: 深色背景 + 绿色强调色（类似 Spotify）
- **布局设计**: 大封面展示 + 底部控制栏
- **交互体验**: 流畅的切换动画和即时反馈
- **视觉层次**: 清晰的信息层级和视觉引导

## 扩展功能建议

1. **歌词显示**: 添加滚动歌词功能
2. **收藏功能**: 实现歌曲收藏和管理
3. **搜索功能**: 添加歌曲搜索能力
4. **播放历史**: 记录播放历史
5. **均衡器**: 添加音效调节
6. **主题切换**: 支持多种主题颜色
7. **本地扫描**: 扫描设备本地音乐文件

## 常见问题

### 1. 音频无法播放
- 检查网络连接
- 确认音频 URL 可访问
- 查看控制台错误日志

### 2. 进度条不更新
- 确认 timeUpdate 事件监听正常
- 检查播放器状态

### 3. 应用无法安装
- 检查签名配置
- 确认设备系统版本
- 查看 DevEco Studio 日志

## 许可证

MIT License
