import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatDialogModule } from '@angular/material/dialog';
import { MatIconModule } from '@angular/material/icon';
import { MatListModule } from '@angular/material/list';

import { ListToolsModule } from 'src/app/modules/list-tools';
import { RouletteModule } from 'src/app/modules/roulette';
import { OrderRoutingModule } from './order-routing.module';
import { OrderPageComponent } from './order-page/order-page.component';
import { ItemSelectionColumnsComponent } from './item-selection-columns/item-selection-columns.component';


@NgModule({
  declarations: [OrderPageComponent, ItemSelectionColumnsComponent],
  imports: [
    CommonModule,
    MatButtonModule,
    MatCardModule,
    MatDialogModule,
    MatIconModule,
    MatListModule,

    OrderRoutingModule,
    ListToolsModule,
    RouletteModule,
  ]
})
export class OrderModule { }
