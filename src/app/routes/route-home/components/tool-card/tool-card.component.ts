import {Component, Input} from '@angular/core';

@Component({
  selector: 'app-tool-card',
  templateUrl: './tool-card.component.html',
  styleUrls: ['./tool-card.component.scss']
})
export class ToolCardComponent {
  @Input() public title: string;
  @Input() public description: string;
}
