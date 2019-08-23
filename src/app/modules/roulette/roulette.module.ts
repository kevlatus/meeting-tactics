import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';

import {RouletteBoxComponent} from './components/roulette-box/roulette-box.component';
import {RouletteGameComponent} from './components/roulette-game/roulette-game.component';


@NgModule({
  declarations: [
    RouletteBoxComponent,
    RouletteGameComponent,
  ],
  imports: [
    CommonModule
  ],
  exports: [
    RouletteBoxComponent,
    RouletteGameComponent,
  ]
})
export class RouletteModule {
}
