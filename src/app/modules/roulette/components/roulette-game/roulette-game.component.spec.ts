import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { RouletteGameComponent } from './roulette-game.component';

describe('RouletteGameComponent', () => {
  let component: RouletteGameComponent;
  let fixture: ComponentFixture<RouletteGameComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ RouletteGameComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RouletteGameComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
