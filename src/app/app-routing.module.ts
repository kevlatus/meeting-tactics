import {NgModule} from '@angular/core';
import {Routes, RouterModule} from '@angular/router';

import {RouteNames} from './routes';

const routes: Routes = [
  {
    path: RouteNames.HOME, pathMatch: 'full',
    loadChildren: () => import('./routes/route-home/route-home.module').then(m => m.RouteHomeModule)
  },
  {
    path: RouteNames.ROULETTE,
    loadChildren: () => import('./routes/route-roulette/route-roulette.module').then(m => m.RouteRouletteModule)
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {
}
