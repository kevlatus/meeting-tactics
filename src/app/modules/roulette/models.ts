import {Subject} from 'rxjs';

export abstract class RouletteMachine {
  itemSubject: Subject<string> = new Subject<string>();
}

export type RouletteState = 'ready' | 'rolling' | 'started' | 'finished';

export const ErrGameStarted = new Error('Game is already started.');

export function canStart(state: RouletteState): boolean {
  return state === 'ready';
}

export function canRestart(state: RouletteState): boolean {
  return ['started', 'finished'].includes(state);
}

export function canNext(state: RouletteState): boolean {
  return state === 'started';
}
