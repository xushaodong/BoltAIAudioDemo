import media from '@ohos.multimedia.media';
import { Song, PlayState, PlayMode } from '../model/MusicModel';

export class MusicPlayerService {
  private avPlayer: media.AVPlayer | null = null;
  private currentSong: Song | null = null;
  private playlist: Song[] = [];
  private currentIndex: number = 0;
  private playMode: PlayMode = PlayMode.SEQUENCE;
  private playState: PlayState = PlayState.IDLE;

  private onStateChangeCallback: ((state: PlayState) => void) | null = null;
  private onTimeUpdateCallback: ((currentTime: number, duration: number) => void) | null = null;
  private onSongChangeCallback: ((song: Song | null, index: number) => void) | null = null;

  async initialize(): Promise<void> {
    try {
      this.avPlayer = await media.createAVPlayer();
      this.setupListeners();
    } catch (error) {
      console.error('Failed to create AVPlayer:', error);
      this.playState = PlayState.ERROR;
    }
  }

  private setupListeners(): void {
    if (!this.avPlayer) return;

    this.avPlayer.on('stateChange', async (state: string) => {
      console.info(`AVPlayer state changed to: ${state}`);

      switch (state) {
        case 'playing':
          this.playState = PlayState.PLAYING;
          this.notifyStateChange(PlayState.PLAYING);
          break;
        case 'paused':
          this.playState = PlayState.PAUSED;
          this.notifyStateChange(PlayState.PAUSED);
          break;
        case 'stopped':
          this.playState = PlayState.STOPPED;
          this.notifyStateChange(PlayState.STOPPED);
          break;
        case 'completed':
          await this.handlePlaybackCompleted();
          break;
        case 'error':
          this.playState = PlayState.ERROR;
          this.notifyStateChange(PlayState.ERROR);
          break;
      }
    });

    this.avPlayer.on('timeUpdate', (time: number) => {
      if (this.onTimeUpdateCallback && this.avPlayer) {
        this.onTimeUpdateCallback(time, this.avPlayer.duration);
      }
    });

    this.avPlayer.on('error', (error) => {
      console.error('AVPlayer error:', error);
      this.playState = PlayState.ERROR;
      this.notifyStateChange(PlayState.ERROR);
    });
  }

  setPlaylist(songs: Song[]): void {
    this.playlist = songs;
  }

  async playSong(song: Song, index: number): Promise<void> {
    if (!this.avPlayer) {
      await this.initialize();
    }

    try {
      if (this.playState !== PlayState.IDLE && this.playState !== PlayState.STOPPED) {
        await this.avPlayer?.reset();
      }

      this.currentSong = song;
      this.currentIndex = index;

      if (this.avPlayer) {
        this.avPlayer.url = song.audioUrl;
        await this.avPlayer.prepare();
        await this.avPlayer.play();
      }

      this.notifySongChange(song, index);
    } catch (error) {
      console.error('Failed to play song:', error);
      this.playState = PlayState.ERROR;
      this.notifyStateChange(PlayState.ERROR);
    }
  }

  async play(): Promise<void> {
    if (!this.avPlayer) return;

    try {
      if (this.playState === PlayState.PAUSED) {
        await this.avPlayer.play();
      } else if (this.currentSong) {
        await this.playSong(this.currentSong, this.currentIndex);
      } else if (this.playlist.length > 0) {
        await this.playSong(this.playlist[0], 0);
      }
    } catch (error) {
      console.error('Failed to play:', error);
    }
  }

  async pause(): Promise<void> {
    if (!this.avPlayer || this.playState !== PlayState.PLAYING) return;

    try {
      await this.avPlayer.pause();
    } catch (error) {
      console.error('Failed to pause:', error);
    }
  }

  async stop(): Promise<void> {
    if (!this.avPlayer) return;

    try {
      await this.avPlayer.stop();
      this.playState = PlayState.STOPPED;
    } catch (error) {
      console.error('Failed to stop:', error);
    }
  }

  async next(): Promise<void> {
    if (this.playlist.length === 0) return;

    let nextIndex: number;

    if (this.playMode === PlayMode.SHUFFLE) {
      nextIndex = Math.floor(Math.random() * this.playlist.length);
    } else {
      nextIndex = (this.currentIndex + 1) % this.playlist.length;
    }

    await this.playSong(this.playlist[nextIndex], nextIndex);
  }

  async previous(): Promise<void> {
    if (this.playlist.length === 0) return;

    let prevIndex: number;

    if (this.playMode === PlayMode.SHUFFLE) {
      prevIndex = Math.floor(Math.random() * this.playlist.length);
    } else {
      prevIndex = (this.currentIndex - 1 + this.playlist.length) % this.playlist.length;
    }

    await this.playSong(this.playlist[prevIndex], prevIndex);
  }

  async seek(time: number): Promise<void> {
    if (!this.avPlayer) return;

    try {
      await this.avPlayer.seek(time);
    } catch (error) {
      console.error('Failed to seek:', error);
    }
  }

  async handlePlaybackCompleted(): Promise<void> {
    if (this.playMode === PlayMode.LOOP_ONE && this.currentSong) {
      await this.playSong(this.currentSong, this.currentIndex);
    } else {
      await this.next();
    }
  }

  setPlayMode(mode: PlayMode): void {
    this.playMode = mode;
  }

  getPlayMode(): PlayMode {
    return this.playMode;
  }

  getCurrentSong(): Song | null {
    return this.currentSong;
  }

  getCurrentIndex(): number {
    return this.currentIndex;
  }

  getPlayState(): PlayState {
    return this.playState;
  }

  getPlaylist(): Song[] {
    return this.playlist;
  }

  onStateChange(callback: (state: PlayState) => void): void {
    this.onStateChangeCallback = callback;
  }

  onTimeUpdate(callback: (currentTime: number, duration: number) => void): void {
    this.onTimeUpdateCallback = callback;
  }

  onSongChange(callback: (song: Song | null, index: number) => void): void {
    this.onSongChangeCallback = callback;
  }

  private notifyStateChange(state: PlayState): void {
    if (this.onStateChangeCallback) {
      this.onStateChangeCallback(state);
    }
  }

  private notifySongChange(song: Song | null, index: number): void {
    if (this.onSongChangeCallback) {
      this.onSongChangeCallback(song, index);
    }
  }

  async release(): Promise<void> {
    if (this.avPlayer) {
      await this.avPlayer.release();
      this.avPlayer = null;
    }
  }
}

export const musicPlayerService = new MusicPlayerService();
