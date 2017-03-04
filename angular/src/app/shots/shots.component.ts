import { Component, OnInit } from '@angular/core';
import { Shot } from '../shot';
import { DrinkInfo } from '../drink-info';
import { BartenderService } from '../bartender.service';
import { Observable } from 'rxjs/Rx';

@Component({
  selector: 'app-shots',
  templateUrl: './shots.component.html',
  styleUrls: ['./shots.component.css']
})
export class ShotsComponent implements OnInit {
  errorMessage: string;
  message: string;
  shotsInfoList: DrinkInfo[];
  selectedShotLink: DrinkInfo;
  selectedShot: Shot;
  shotsList: Shot[];
  title: string = 'Shots';

  constructor(public bartenderService: BartenderService) { }

  ngOnInit() {
    this.bartenderService.getShotsInfoList().subscribe(
      shotsInfoList => this.shotsInfoList = shotsInfoList,
      error => this.errorMessage = <any>error
    );
  }

  onShotSelected(event) {
    this.bartenderService.getShot(event).subscribe(
      selectedShot => this.selectedShot = selectedShot,
      error => this.errorMessage = <any>error
    );
  }

  onShotOrder(event) {
    this.bartenderService.makeShot(event.shot.link, event.quantity).subscribe(
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
