/* tslint:disable:no-unused-variable */
import { async, ComponentFixture, TestBed } from '@angular/core/testing';
import { By } from '@angular/platform-browser';
import { DebugElement } from '@angular/core';

import { ShotsComponent } from './shots.component';

describe('ShotsComponent', () => {
  let component: ShotsComponent;
  let fixture: ComponentFixture<ShotsComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ShotsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ShotsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
