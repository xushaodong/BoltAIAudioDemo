export interface Song {
  id: number;
  title: string;
  artist: string;
  album: string;
  duration: number;
  coverUrl: string;
  audioUrl: string;
}

export enum PlayMode {
  SEQUENCE = 0,
  LOOP_ONE = 1,
  SHUFFLE = 2
}

export enum PlayState {
  IDLE = 'idle',
  PLAYING = 'playing',
  PAUSED = 'paused',
  STOPPED = 'stopped',
  ERROR = 'error'
}

export class PlayerState {
  currentSong: Song | null = null;
  currentTime: number = 0;
  duration: number = 0;
  playState: PlayState = PlayState.IDLE;
  playMode: PlayMode = PlayMode.SEQUENCE;
  playlist: Song[] = [];
  currentIndex: number = 0;
}
