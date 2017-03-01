import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';

import { AppComponent } from './app.component';
import { BaseListComponent } from './base-list/base-list.component';
import { ShotsComponent } from './shots/shots.component';
import { ShotDetailComponent } from './shots/shot-detail/shot-detail.component';

import { BartenderService } from './bartender.service';

@NgModule({
  declarations: [
    AppComponent,
    BaseListComponent,
    ShotsComponent,
    ShotDetailComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule
  ],
  providers: [BartenderService],
  bootstrap: [AppComponent]
})
export class AppModule { }
