import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { Cocktail } from '../../cocktail';
import { CocktailOrder } from '../../cocktail-order';

@Component({
  selector: 'app-cocktail-detail',
  templateUrl: './cocktail-detail.component.html',
  styleUrls: ['./cocktail-detail.component.css']
})
export class CocktailDetailComponent implements OnInit {

  @Input() cocktail: Cocktail;
  @Output() cocktailOrder: EventEmitter<CocktailOrder> = new EventEmitter();

  constructor() { }

  ngOnInit() {
  }

  orderCocktail() {
    this.cocktailOrder.emit({
      cocktail: this.cocktail,
    });
  }
}

