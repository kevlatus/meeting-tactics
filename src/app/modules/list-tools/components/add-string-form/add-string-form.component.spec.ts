import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { AddStringFormComponent } from './add-string-form.component';

describe('AddStringFormComponent', () => {
  let component: AddStringFormComponent;
  let fixture: ComponentFixture<AddStringFormComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ AddStringFormComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AddStringFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
