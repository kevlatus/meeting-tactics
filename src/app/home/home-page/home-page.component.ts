import { Component } from '@angular/core';

interface Tool {
  title: string;
  description: string;
  href: string;
}

@Component({
  selector: 'app-home-page',
  templateUrl: './home-page.component.html',
  styleUrls: ['./home-page.component.scss']
})
export class HomePageComponent {
  tools: Tool[] = [
    {
      title: 'Who\'s next? 🎲💬',
      description: 'Randomly select the next speaker from all participants.\n\nUseful for regular team meetings.',
      href: 'roulette/order'
    }
  ];
}
