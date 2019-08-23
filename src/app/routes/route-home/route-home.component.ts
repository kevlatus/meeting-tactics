import {Component} from '@angular/core';

import {RouteNames} from 'src/app/routes/names';

interface Tool {
  title: string;
  description: string;
  href: string;
}

@Component({
  selector: 'app-route-home',
  templateUrl: './route-home.component.html',
  styleUrls: ['./route-home.component.scss']
})
export class RouteHomeComponent {
  tools: Tool[] = [
    {title: 'Who\'s next?', description: '', href: RouteNames.ROULETTE_ORDER_FULL},
    // {title: 'Role Roulette', description: '', href: RouteNames.ROULETTE_ROLE_FULL},
  ];
}
