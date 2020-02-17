import { Component, ViewChild } from '@angular/core';

import { RouletteState, canStart, canRestart, canNext, RouletteGameComponent } from 'src/app/modules/roulette';


@Component({
  selector: 'app-order-page',
  templateUrl: './order-page.component.html',
  styleUrls: ['./order-page.component.scss']
})
export class OrderPageComponent {
  rouletteState: RouletteState;
  selectedItems: string[] = [];

  canStart = canStart;
  canRestart = canRestart;
  canNext = canNext;

  @ViewChild(RouletteGameComponent, { static: true })
  private rouletteGame: RouletteGameComponent;

  participants: string[] = [];

  onNewItem(item: string) {
    this.participants = [...this.participants, item];
  }

  onStart() {
    this.rouletteGame.play();
  }

  onStateChange(state: RouletteState) {
    this.rouletteState = state;
  }

  onRestart() {
    this.rouletteGame.restart();
  }

  onSelectedChange(selectedItems: string[]) {
    this.selectedItems = selectedItems;
  }

  onReroll() {
    this.rouletteGame.reroll();
  }
}
