import { Component, OnInit } from '@angular/core';
import { Cocktail } from '../cocktail';
import { DrinkInfo } from '../drink-info';
import { BartenderService } from '../bartender.service';
import { Observable } from 'rxjs/Rx';

@Component({
  selector: 'app-cocktails',
  templateUrl: './cocktails.component.html',
  styleUrls: ['./cocktails.component.css']
})
export class CocktailsComponent implements OnInit {
  errorMessage: string;
  message: string;
  cocktailsInfoList: DrinkInfo[];
  selectedCocktailLink: DrinkInfo;
  selectedCocktail: Cocktail;
  cocktailsList: Cocktail[];
  title: string = 'Cocktails';

  constructor(public bartenderService: BartenderService) { }

  ngOnInit() {
    this.bartenderService.getCocktailsInfoList().subscribe(
      cocktailsInfoList => this.cocktailsInfoList = cocktailsInfoList,
      error => this.errorMessage = <any>error
    );
  }

  onCocktailSelected(event) {
    this.bartenderService.getCocktail(event).subscribe(
      selectedCocktail => this.selectedCocktail = selectedCocktail,
      error => this.errorMessage = <any>error
    );
  }

  onCocktailOrder(event) {
    this.bartenderService.makeCocktail(event.cocktail.link).subscribe(
      message => this.message = message,
      error => this.errorMessage = error,
      () => {
        setTimeout(() => {
          this.clearMessages();
        }, 3000);
      }
    )
  }

  clearMessages() {
    this.errorMessage = "";
    this.message = "";
  }
}