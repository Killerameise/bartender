import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';
import { RouterModule } from '@angular/router';

import { AppComponent } from './app.component';
import { BaseListComponent } from './base-list/base-list.component';
import { ShotsComponent } from './shots/shots.component';
import { ShotDetailComponent } from './shots/shot-detail/shot-detail.component';
import { CocktailsComponent } from './cocktails/cocktails.component';
import { CocktailDetailComponent } from './cocktails/cocktail-detail/cocktail-detail.component';

import { BartenderService } from './bartender.service';

const appRoutes = [
  { path: 'shots', component: ShotsComponent },
  { path: 'cocktails', component: CocktailsComponent },
  { 
    path: '',
    redirectTo: '/shots',
    pathMatch: 'full'
  }
];

@NgModule({
  declarations: [
    AppComponent,
    BaseListComponent,
    ShotsComponent,
    ShotDetailComponent,
    CocktailsComponent,
    CocktailDetailComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    RouterModule.forRoot(appRoutes)
  ],
  providers: [BartenderService],
  bootstrap: [AppComponent]
})
export class AppModule { }
