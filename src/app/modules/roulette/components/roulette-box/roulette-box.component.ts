import {Component, forwardRef} from '@angular/core';

import {RouletteMachine} from '../../models';

@Component({
  selector: 'app-roulette-box',
  templateUrl: './roulette-box.component.html',
  styleUrls: ['./roulette-box.component.scss'],
  providers: [{provide: RouletteMachine, useExisting: forwardRef(() => RouletteBoxComponent)}],
})
export class RouletteBoxComponent extends RouletteMachine {
}
