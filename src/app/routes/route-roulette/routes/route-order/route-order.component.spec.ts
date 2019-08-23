import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { RouteOrderComponent } from './route-order.component';

describe('RouteOrderComponent', () => {
  let component: RouteOrderComponent;
  let fixture: ComponentFixture<RouteOrderComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ RouteOrderComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RouteOrderComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
