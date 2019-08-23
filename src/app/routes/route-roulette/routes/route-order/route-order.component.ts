import {Component, ViewChild} from '@angular/core';

import {RouletteGameComponent} from 'src/app/modules/roulette';
import {canNext, canRestart, canStart, RouletteState} from 'src/app/modules/roulette/models';
import {CalendarService} from '../../../../modules/calendar/services/calendar.service';
import {AuthenticationService, ErrNotAuthenticated} from '../../../../modules/authentication';

@Component({
  selector: 'app-route-order',
  templateUrl: './route-order.component.html',
  styleUrls: ['./route-order.component.scss']
})
export class RouteOrderComponent {
  rouletteState: RouletteState;
  selectedItems: string[] = [];

  canStart = canStart;
  canRestart = canRestart;
  canNext = canNext;

  @ViewChild(RouletteGameComponent, {static: true})
  private rouletteGame: RouletteGameComponent;

  participants: string[] = [];

  constructor(private calendar: CalendarService, private auth: AuthenticationService) {
  }

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

  fromCalendar() {
    this.calendar.getEventsToday()
      .then(console.log);
    // .catch(err => {
    //   if (err === ErrNotAuthenticated) {
    //     this.auth.promptLogin();
    //   }
    // });
  }

  onReroll() {
    this.rouletteGame.reroll();
  }
}
