import {Component, EventEmitter, Output} from '@angular/core';
import {FormControl, FormGroup, Validators} from '@angular/forms';

@Component({
  selector: 'app-add-string-form',
  templateUrl: './add-string-form.component.html',
  styleUrls: ['./add-string-form.component.scss']
})
export class AddStringFormComponent {
  form = new FormGroup({
    name: new FormControl('', [Validators.required]),
  });

  @Output() public newItem = new EventEmitter<string>();

  onSubmit() {
    const {name} = this.form.value;
    this.newItem.emit(name);
    this.form.reset();
  }

  onPaste(e: ClipboardEvent) {
    const data = e.clipboardData.getData('text');
    if (data && data.includes('\n')) {
      const items = data.split('\n');
      for (const i of items) {
        this.newItem.emit(i);
      }
      e.preventDefault();
    }
  }
}
