import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { DrinkInfo } from '../drink-info';

@Component({
  selector: 'app-base-list',
  templateUrl: './base-list.component.html',
  styleUrls: ['./base-list.component.css']
})
export class BaseListComponent implements OnInit {

  @Input() drinksInfoList: DrinkInfo[];
  @Output() selectedDrinkLink: EventEmitter<string> = new EventEmitter();

  constructor() { }

  ngOnInit() {
  }

  onDrinkSelected(drinkInfo: DrinkInfo) {
    this.selectedDrinkLink.emit(drinkInfo.link);
  }

}
