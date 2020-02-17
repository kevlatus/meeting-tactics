import {ModuleWithProviders, NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {MatDialogModule} from '@angular/material/dialog';
import { MatButtonModule } from '@angular/material/button';
import { MatRippleModule } from '@angular/material/core';

import {AuthenticationModule} from 'src/app/modules/authentication';

import {PickEventDialogComponent} from './components/pick-event-dialog/pick-event-dialog.component';
import {CalendarService} from './services/calendar.service';

@NgModule({
  entryComponents: [
    PickEventDialogComponent,
  ],
  declarations: [
    PickEventDialogComponent
  ],
  imports: [
    CommonModule,
    MatDialogModule,
    MatRippleModule,
    MatButtonModule,

    AuthenticationModule,
  ]
})
export class CalendarModule {
  public static forRoot(): ModuleWithProviders {
    return {
      ngModule: CalendarModule,
      providers: [
        CalendarService,
      ]
    };
  }
}
