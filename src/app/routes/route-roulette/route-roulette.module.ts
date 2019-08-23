import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {RouterModule, Routes} from '@angular/router';

import {RouteNames} from 'src/app/routes/names';

const routes: Routes = [
  {path: '', pathMatch: 'full', redirectTo: RouteNames.ROULETTE_ORDER},
  {
    path: RouteNames.ROULETTE_ORDER,
    loadChildren: () => import('./routes/route-order/route-order.module').then(m => m.RouteOrderModule)
  },
  {
    path: RouteNames.ROULETTE_ROLE,
    loadChildren: () => import('./routes/route-role/route-role.module').then(m => m.RouteRoleModule)
  }
];

@NgModule({
  declarations: [],
  imports: [
    CommonModule,
    RouterModule.forChild(routes),
  ]
})
export class RouteRouletteModule {
}
