import { PlayState, PlayMode } from '../model/MusicModel';

@Component
export struct PlayerControls {
  @Prop playState: PlayState;
  @Prop playMode: PlayMode;
  onPlay: () => void = () => {};
  onPause: () => void = () => {};
  onPrevious: () => void = () => {};
  onNext: () => void = () => {};
  onModeChange: () => void = () => {};

  private getPlayModeIcon(): Resource {
    switch (this.playMode) {
      case PlayMode.SEQUENCE:
        return $r('app.media.icon');
      case PlayMode.LOOP_ONE:
        return $r('app.media.icon');
      case PlayMode.SHUFFLE:
        return $r('app.media.icon');
      default:
        return $r('app.media.icon');
    }
  }

  build() {
    Row() {
      Button({ type: ButtonType.Circle }) {
        Text(this.playMode === PlayMode.SEQUENCE ? '顺序' :
             this.playMode === PlayMode.LOOP_ONE ? '单曲' : '随机')
          .fontSize(12)
          .fontColor('#B3B3B3')
      }
      .width(50)
      .height(50)
      .backgroundColor('transparent')
      .onClick(() => {
        this.onModeChange();
      })

      Blank().width(20)

      Button({ type: ButtonType.Circle }) {
        Text('⏮')
          .fontSize(24)
          .fontColor('#FFFFFF')
      }
      .width(60)
      .height(60)
      .backgroundColor('#2A2A2A')
      .onClick(() => {
        this.onPrevious();
      })

      Blank().width(30)

      Button({ type: ButtonType.Circle }) {
        Text(this.playState === PlayState.PLAYING ? '⏸' : '▶')
          .fontSize(28)
          .fontColor('#FFFFFF')
      }
      .width(80)
      .height(80)
      .backgroundColor('#1DB954')
      .onClick(() => {
        if (this.playState === PlayState.PLAYING) {
          this.onPause();
        } else {
          this.onPlay();
        }
      })

      Blank().width(30)

      Button({ type: ButtonType.Circle }) {
        Text('⏭')
          .fontSize(24)
          .fontColor('#FFFFFF')
      }
      .width(60)
      .height(60)
      .backgroundColor('#2A2A2A')
      .onClick(() => {
        this.onNext();
      })

      Blank().width(20)

      Button({ type: ButtonType.Circle }) {
        Text('♥')
          .fontSize(20)
          .fontColor('#B3B3B3')
      }
      .width(50)
      .height(50)
      .backgroundColor('transparent')
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ left: 20, right: 20 })
  }
}
