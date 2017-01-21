/* tslint:disable:no-unused-variable */
import { async, ComponentFixture, TestBed } from '@angular/core/testing';
import { By } from '@angular/platform-browser';
import { DebugElement } from '@angular/core';

import { ShotListComponent } from './shot-list.component';

describe('ShotListComponent', () => {
  let component: ShotListComponent;
  let fixture: ComponentFixture<ShotListComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ShotListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ShotListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
