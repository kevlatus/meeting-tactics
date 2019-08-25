import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {MatCardModule} from '@angular/material/card';
import {RouterModule, Routes} from '@angular/router';

import {RouteHomeComponent} from './route-home.component';
import { ToolCardComponent } from './components/tool-card/tool-card.component';
import { IntroSectionComponent } from './intro-section/intro-section.component';

const routes: Routes = [
  {path: '', pathMatch: 'full', component: RouteHomeComponent},
];

@NgModule({
  declarations: [RouteHomeComponent, ToolCardComponent, IntroSectionComponent],
  imports: [
    CommonModule,
    MatCardModule,
    RouterModule.forChild(routes),
  ]
})
export class RouteHomeModule {
}
