import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { RouletteBoxComponent } from './roulette-box.component';

describe('RouletteBoxComponent', () => {
  let component: RouletteBoxComponent;
  let fixture: ComponentFixture<RouletteBoxComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ RouletteBoxComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RouletteBoxComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
