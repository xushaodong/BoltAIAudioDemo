# 音乐播放器资源说明

本项目为鸿蒙音乐播放器应用，包含以下音乐素材资源：

## 音乐列表

### 1. 夜的钢琴曲
- **艺术家**: 石进
- **专辑**: 夜的钢琴曲
- **时长**: 4分5秒
- **封面**: 钢琴主题图片
- **音频URL**: https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3

### 2. 星空
- **艺术家**: 理查德·克莱德曼
- **专辑**: 浪漫钢琴曲
- **时长**: 3分18秒
- **封面**: 星空夜景图片
- **音频URL**: https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3

### 3. 雨的印记
- **艺术家**: Yiruma
- **专辑**: First Love
- **时长**: 3分41秒
- **封面**: 雨滴主题图片
- **音频URL**: https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3

### 4. 天空之城
- **艺术家**: 久石让
- **专辑**: 宫崎骏动画音乐集
- **时长**: 4分27秒
- **封面**: 天空城堡图片
- **音频URL**: https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3

### 5. 月光
- **艺术家**: 贝多芬
- **专辑**: 贝多芬钢琴奏鸣曲
- **时长**: 5分1秒
- **封面**: 月光主题图片
- **音频URL**: https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3

## 资源使用说明

### 封面图片
所有封面图片均来自 Pexels 免费图片库，均为高质量的专业摄影作品。

### 音频文件
音频文件使用 SoundHelix 提供的示例音乐文件，这些是自动生成的音乐，可免费用于测试和演示目的。

注意：在实际应用中，您需要：
1. 将音频文件下载到本地或使用您自己的音乐资源
2. 更新 SongData.ets 中的 audioUrl 为实际的文件路径
3. 确保拥有音乐文件的合法使用权限

## 本地资源配置（可选）

如需使用本地音频资源：

1. 将音频文件放置在 `entry/src/main/resources/rawfile/` 目录下
2. 更新 SongData.ets 中的 audioUrl，例如：
   ```typescript
   audioUrl: 'file:///data/storage/el1/bundle/entry/resources/rawfile/song1.mp3'
   ```

或使用资源管理器方式：
```typescript
audioUrl: $rawfile('song1.mp3').toString()
```
