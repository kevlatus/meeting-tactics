import {Component} from '@angular/core';
import {Store} from '@ngrx/store';
import {Observable} from 'rxjs';

import {AppState} from './store';
import {selectAppTitle} from './store/selectors';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title$: Observable<string>;

  constructor(store: Store<AppState>) {
    this.title$ = store.select(selectAppTitle);
  }
}
