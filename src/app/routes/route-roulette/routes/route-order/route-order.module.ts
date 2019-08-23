import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {MatButtonModule} from '@angular/material/button';
import {MatCardModule} from '@angular/material/card';
import {MatDialogModule} from '@angular/material/dialog';
import {MatIconModule} from '@angular/material/icon';
import {MatListModule} from '@angular/material';
import {MatTooltipModule} from '@angular/material/tooltip';
import {RouterModule, Routes} from '@angular/router';
import {NgkComponentsModule} from 'ngk-components';

import {AuthenticationModule} from 'src/app/modules/authentication';
import {CalendarModule} from 'src/app/modules/calendar/calendar.module';
import {ListToolsModule} from 'src/app/modules/list-tools';
import {RouletteModule} from 'src/app/modules/roulette';

import {RouteOrderComponent} from './route-order.component';
import {ItemSelectionColumnsComponent} from './item-selection-columns/item-selection-columns.component';

const routes: Routes = [
  {path: '', pathMatch: 'full', component: RouteOrderComponent},
];

@NgModule({
  declarations: [
    RouteOrderComponent,
    ItemSelectionColumnsComponent
  ],
  imports: [
    CommonModule,
    MatButtonModule,
    MatCardModule,
    MatDialogModule,
    MatIconModule,
    MatListModule,
    MatTooltipModule,
    RouterModule.forChild(routes),
    NgkComponentsModule,

    AuthenticationModule,
    CalendarModule,
    ListToolsModule,
    RouletteModule,
  ]
})
export class RouteOrderModule {
}
