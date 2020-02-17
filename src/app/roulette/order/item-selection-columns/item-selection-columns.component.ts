import { Component, SimpleChanges, Input } from '@angular/core';

@Component({
  selector: 'app-item-selection-columns',
  templateUrl: './item-selection-columns.component.html',
  styleUrls: ['./item-selection-columns.component.scss']
})
export class ItemSelectionColumnsComponent {
  nonSelectedItems: string[] = [];

  @Input() public items: string[] = [];
  @Input() public selectedItems: string[] = [];

  ngOnChanges(changes: SimpleChanges): void {
    this.nonSelectedItems = this.items.filter(v => !this.selectedItems.includes(v));
  }
}
