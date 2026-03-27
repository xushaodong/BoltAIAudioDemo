import { Song, PlayState, PlayMode } from '../model/MusicModel';
import { musicPlayerService } from '../service/MusicPlayerService';
import { SONG_LIST } from '../data/SongData';
import { PlayerControls } from '../components/PlayerControls';
import { ProgressBar } from '../components/ProgressBar';
import { SongItem } from '../components/SongItem';

@Entry
@Component
struct Index {
  @State currentSong: Song | null = null;
  @State currentTime: number = 0;
  @State duration: number = 0;
  @State playState: PlayState = PlayState.IDLE;
  @State playMode: PlayMode = PlayMode.SEQUENCE;
  @State currentIndex: number = 0;
  @State showPlaylist: boolean = false;

  async aboutToAppear() {
    await musicPlayerService.initialize();
    musicPlayerService.setPlaylist(SONG_LIST);

    musicPlayerService.onStateChange((state: PlayState) => {
      this.playState = state;
    });

    musicPlayerService.onTimeUpdate((current: number, total: number) => {
      this.currentTime = current;
      this.duration = total;
    });

    musicPlayerService.onSongChange((song: Song | null, index: number) => {
      this.currentSong = song;
      this.currentIndex = index;
    });

    if (SONG_LIST.length > 0) {
      this.currentSong = SONG_LIST[0];
    }
  }

  async aboutToDisappear() {
    await musicPlayerService.release();
  }

  build() {
    Column() {
      Row() {
        Text('Harmony Music')
          .fontSize(24)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)

        Blank()

        Button({ type: ButtonType.Circle }) {
          Text('☰')
            .fontSize(24)
            .fontColor('#FFFFFF')
        }
        .width(40)
        .height(40)
        .backgroundColor('transparent')
        .onClick(() => {
          this.showPlaylist = !this.showPlaylist;
        })
      }
      .width('100%')
      .height(60)
      .padding({ left: 20, right: 20 })
      .backgroundColor('#1E1E1E')

      if (!this.showPlaylist) {
        this.buildPlayerView();
      } else {
        this.buildPlaylistView();
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#121212')
  }

  @Builder
  buildPlayerView() {
    Column() {
      Blank().height(40)

      Image(this.currentSong?.coverUrl || '')
        .width(280)
        .height(280)
        .borderRadius(12)
        .objectFit(ImageFit.Cover)
        .shadow({
          radius: 30,
          color: '#000000',
          offsetX: 0,
          offsetY: 10
        })

      Blank().height(40)

      Column() {
        Text(this.currentSong?.title || '未播放')
          .fontSize(24)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.currentSong?.artist || '')
          .fontSize(16)
          .fontColor('#B3B3B3')
          .margin({ top: 8 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .width('80%')
      .margin({ top: 20, bottom: 20 })

      Blank().height(20)

      ProgressBar({
        currentTime: this.currentTime,
        duration: this.duration,
        onSeek: (time: number) => {
          musicPlayerService.seek(time);
        }
      })

      Blank().height(30)

      PlayerControls({
        playState: this.playState,
        playMode: this.playMode,
        onPlay: async () => {
          await musicPlayerService.play();
        },
        onPause: async () => {
          await musicPlayerService.pause();
        },
        onPrevious: async () => {
          await musicPlayerService.previous();
        },
        onNext: async () => {
          await musicPlayerService.next();
        },
        onModeChange: () => {
          const modes = [PlayMode.SEQUENCE, PlayMode.LOOP_ONE, PlayMode.SHUFFLE];
          const currentModeIndex = modes.indexOf(this.playMode);
          const nextMode = modes[(currentModeIndex + 1) % modes.length];
          this.playMode = nextMode;
          musicPlayerService.setPlayMode(nextMode);
        }
      })

      Blank()
    }
    .width('100%')
    .layoutWeight(1)
  }

  @Builder
  buildPlaylistView() {
    Column() {
      Row() {
        Text('播放列表')
          .fontSize(20)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)

        Blank()

        Text(`共${SONG_LIST.length}首`)
          .fontSize(14)
          .fontColor('#B3B3B3')
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 20, bottom: 10 })

      List({ space: 4 }) {
        ForEach(SONG_LIST, (song: Song, index: number) => {
          ListItem() {
            SongItem({
              song: song,
              index: index,
              isPlaying: this.currentIndex === index && this.playState === PlayState.PLAYING,
              onItemClick: async () => {
                await musicPlayerService.playSong(song, index);
                this.showPlaylist = false;
              }
            })
          }
        }, (song: Song) => song.id.toString())
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Auto)
      .edgeEffect(EdgeEffect.Spring)
      .padding({ left: 10, right: 10 })

      if (this.currentSong) {
        Row() {
          Image(this.currentSong.coverUrl)
            .width(50)
            .height(50)
            .borderRadius(4)
            .objectFit(ImageFit.Cover)
            .margin({ right: 12 })

          Column() {
            Text(this.currentSong.title)
              .fontSize(14)
              .fontColor('#FFFFFF')
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })

            Text(this.currentSong.artist)
              .fontSize(12)
              .fontColor('#B3B3B3')
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .margin({ top: 2 })
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Button({ type: ButtonType.Circle }) {
            Text(this.playState === PlayState.PLAYING ? '⏸' : '▶')
              .fontSize(20)
              .fontColor('#FFFFFF')
          }
          .width(50)
          .height(50)
          .backgroundColor('#1DB954')
          .onClick(async () => {
            if (this.playState === PlayState.PLAYING) {
              await musicPlayerService.pause();
            } else {
              await musicPlayerService.play();
            }
          })
        }
        .width('100%')
        .height(80)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#1E1E1E')
        .borderRadius({ topLeft: 12, topRight: 12 })
        .onClick(() => {
          this.showPlaylist = false;
        })
      }
    }
    .width('100%')
    .layoutWeight(1)
  }
}
