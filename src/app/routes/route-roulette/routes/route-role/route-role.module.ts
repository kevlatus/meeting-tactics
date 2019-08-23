import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {RouterModule, Routes} from '@angular/router';

import {RouteRoleComponent} from './route-role.component';

const routes: Routes = [
  {path: '', pathMatch: 'full', component: RouteRoleComponent},
];

@NgModule({
  declarations: [
    RouteRoleComponent
  ],
  imports: [
    CommonModule,
    RouterModule.forChild(routes),
  ]
})
export class RouteRoleModule {
}
