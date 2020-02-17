import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ItemSelectionColumnsComponent } from './item-selection-columns.component';

describe('ItemSelectionColumnsComponent', () => {
  let component: ItemSelectionColumnsComponent;
  let fixture: ComponentFixture<ItemSelectionColumnsComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ItemSelectionColumnsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ItemSelectionColumnsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
