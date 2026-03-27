import { TimeUtils } from '../utils/TimeUtils';

@Component
export struct ProgressBar {
  @Prop currentTime: number = 0;
  @Prop duration: number = 0;
  onSeek: (time: number) => void = () => {};

  private get progress(): number {
    if (this.duration === 0) return 0;
    return (this.currentTime / this.duration) * 100;
  }

  build() {
    Column() {
      Row() {
        Text(TimeUtils.formatTime(this.currentTime))
          .fontSize(12)
          .fontColor('#B3B3B3')

        Blank()

        Text(TimeUtils.formatTime(this.duration))
          .fontSize(12)
          .fontColor('#B3B3B3')
      }
      .width('100%')
      .padding({ left: 20, right: 20, bottom: 8 })

      Slider({
        value: this.currentTime,
        min: 0,
        max: this.duration > 0 ? this.duration : 100,
        step: 1000,
        style: SliderStyle.OutSet
      })
        .blockColor('#FFFFFF')
        .trackColor('#404040')
        .selectedColor('#1DB954')
        .showSteps(false)
        .showTips(false)
        .trackThickness(4)
        .onChange((value: number) => {
          this.onSeek(value);
        })
        .width('90%')
        .margin({ left: 20, right: 20 })
    }
    .width('100%')
  }
}
