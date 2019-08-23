import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {ReactiveFormsModule} from '@angular/forms';
import {MatButtonModule} from '@angular/material/button';
import {MatInputModule} from '@angular/material/input';
import {MatListModule} from '@angular/material/list';
import {MatIconModule} from '@angular/material/icon';

import {StringListComponent} from './components/string-list/string-list.component';
import {AddStringFormComponent} from './components/add-string-form/add-string-form.component';


@NgModule({
  declarations: [
    AddStringFormComponent,
    StringListComponent,
  ],
  imports: [
    CommonModule,
    MatButtonModule,
    MatIconModule,
    MatInputModule,
    MatListModule,
    ReactiveFormsModule,
  ],
  exports: [
    AddStringFormComponent,
    StringListComponent,
  ]
})
export class ListToolsModule {
}
