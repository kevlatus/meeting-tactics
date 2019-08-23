import {Component, ContentChild, EventEmitter, Input, OnChanges, OnInit, Output, SimpleChanges} from '@angular/core';
import {interval, Observable} from 'rxjs';
import {first, last, map, take} from 'rxjs/operators';

import {ErrGameStarted, RouletteMachine, RouletteState} from '../../models';

/**
 * Returns a random integer between min (inclusive) and max (inclusive).
 * The value is no lower than min (or the next integer greater than min
 * if min isn't an integer) and no greater than max (or the next integer
 * lower than max if max isn't an integer).
 * Using Math.round() will give you a non-uniform distribution!
 */
function getRandomInt(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

@Component({
  selector: 'app-roulette-game',
  templateUrl: './roulette-game.component.html',
  styleUrls: ['./roulette-game.component.scss']
})
export class RouletteGameComponent implements OnInit, OnChanges {
  private fSelections: string[] = [];

  @ContentChild(RouletteMachine, {static: true})
  private machine: RouletteMachine;

  /**
   * All items, which can be drawn in this roulette game.
   */
  @Input() public items: string[] = [];
  /**
   * The delay between each successive random draw.
   */
  @Input() public interval = 20;
  /**
   * The number of successive random draws in each round.
   */
  @Input() public iterations = 100;

  /**
   * Updates when the state of this roulette game changes.
   */
  @Output() public state = new EventEmitter<RouletteState>();
  /**
   * Updates the list of selected items after each round.
   */
  @Output() public selected = new EventEmitter<string[]>();

  private get selections(): string [] {
    return this.fSelections;
  }

  private set selections(newValue: string[]) {
    this.fSelections = newValue;

    if (this.items.length === 0) {
      this.state.emit('ready');
    } else if (this.remainingItems.length === 0) {
      this.state.emit('finished');
    } else {
      if (newValue.length === 0) {
        this.state.emit('ready');
      } else {
        this.state.emit('started');
      }
    }

    this.selected.emit(newValue);
  }

  /**
   * ⚠ currently a getter, which implies no calculation. If performance should become an issue,
   *    move to a function.
   */
  private get remainingItems(): string[] {
    return this.items.filter(i => !this.selections.includes(i));
  }

  private createRound$(): Observable<string> {
    return interval(this.interval).pipe(
      take(this.iterations),
      map(() => {
        return this.remainingItems[getRandomInt(0, this.remainingItems.length - 1)];
      }),
    );
  }

  private initGame() {
    if (this.selections.length > 0) {
      throw ErrGameStarted;
    }

    this.selections = [];
  }

  ngOnInit(): void {
    setTimeout(() => this.initGame());
  }

  ngOnChanges(changes: SimpleChanges): void {
    if (changes[Object.keys(changes)[0]].isFirstChange()) {
      return;
    }

    setTimeout(() => this.restart());
  }

  public play(): void {
    const gameRound$ = this.createRound$();
    gameRound$.pipe(first()).subscribe(() => this.state.emit('rolling'));
    gameRound$.subscribe(v => this.machine.itemSubject.next(v));
    gameRound$.pipe(last()).subscribe((v) => {
      this.selections = [...this.selections, v];
      this.machine.itemSubject.next(v);
    });
  }

  public reroll(): void {
    this.selections = [...this.selections].slice(0, -1);
  }

  public restart(): void {
    this.selections = [];
    this.machine.itemSubject.next('');
    this.initGame();
  }
}
