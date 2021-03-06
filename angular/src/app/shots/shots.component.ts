import { Component, OnInit } from '@angular/core';
import { Shot } from '../shot';
import { ShotInfo } from '../shot-info';
import { BartenderService } from '../bartender.service';

@Component({
  selector: 'app-shots',
  templateUrl: './shots.component.html',
  styleUrls: ['./shots.component.css']
})
export class ShotsComponent implements OnInit {
  errorMessage: string;
  message: string;
  shotsInfoList: ShotInfo[];
  selectedShotLink: ShotInfo;
  selectedShot: Shot;
  shotsList: Shot[];

  constructor(public bartenderService: BartenderService) { }

  ngOnInit() {
    this.bartenderService.getShotsInfoList().subscribe(
      shotsInfoList => this.shotsInfoList = shotsInfoList,
      error => this.errorMessage = <any> error
    );
  }

  onShotSelected(event) {
    this.bartenderService.getShot(event).subscribe(
      selectedShot => this.selectedShot = selectedShot,
      error => this.errorMessage = <any> error
    );
  }

  onShotOrder(event) {
    this.bartenderService.makeShot(event.shot.link, event.quantity).subscribe(
      message => this.message = message,
      error => this.errorMessage = error
    );
    console.log(this.message);
  }

}
