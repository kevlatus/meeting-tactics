import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PickEventDialogComponent } from './pick-event-dialog.component';

describe('PickEventDialogComponent', () => {
  let component: PickEventDialogComponent;
  let fixture: ComponentFixture<PickEventDialogComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PickEventDialogComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PickEventDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
