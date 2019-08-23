import {Component, EventEmitter, Input, Output} from '@angular/core';

@Component({
  selector: 'app-string-list',
  templateUrl: './string-list.component.html',
  styleUrls: ['./string-list.component.scss']
})
export class StringListComponent {
  private itemsValue: string[] = [];

  @Input() public editable = true;

  @Input()
  public get items(): string[] {
    return this.itemsValue;
  }

  public set items(v: string[]) {
    this.itemsValue = v;
  }

  @Output() public itemsChange = new EventEmitter<string[]>();

  delete(idx: number) {
    const copy = [...this.items];
    copy.splice(idx, 1);
    this.itemsChange.emit(copy);
  }
}
