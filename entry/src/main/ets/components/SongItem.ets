import { Song } from '../model/MusicModel';
import { TimeUtils } from '../utils/TimeUtils';

@Component
export struct SongItem {
  @Prop song: Song;
  @Prop isPlaying: boolean = false;
  @Prop index: number = 0;
  onItemClick: () => void = () => {};

  build() {
    Row() {
      Text((this.index + 1).toString())
        .fontSize(16)
        .fontColor(this.isPlaying ? '#1DB954' : '#B3B3B3')
        .width(40)
        .textAlign(TextAlign.Center)

      Image(this.song.coverUrl)
        .width(50)
        .height(50)
        .borderRadius(4)
        .objectFit(ImageFit.Cover)
        .margin({ right: 12 })

      Column() {
        Text(this.song.title)
          .fontSize(16)
          .fontColor(this.isPlaying ? '#1DB954' : '#FFFFFF')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .fontWeight(this.isPlaying ? FontWeight.Bold : FontWeight.Normal)

        Text(`${this.song.artist} - ${this.song.album}`)
          .fontSize(13)
          .fontColor('#B3B3B3')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text(TimeUtils.formatDuration(this.song.duration))
        .fontSize(13)
        .fontColor('#B3B3B3')
        .margin({ left: 12 })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor(this.isPlaying ? '#1E1E1E' : 'transparent')
    .borderRadius(8)
    .onClick(() => {
      this.onItemClick();
    })
  }
}
