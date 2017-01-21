import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { ShotInfo } from '../../shot-info';

@Component({
  selector: 'app-shot-list',
  templateUrl: './shot-list.component.html',
  styleUrls: ['./shot-list.component.css']
})
export class ShotListComponent implements OnInit {

  @Input() shotsInfoList: ShotInfo[];
  @Output() selectedShotLink: EventEmitter<string> = new EventEmitter();

  constructor() { }

  ngOnInit() {
  }

  onShotSelected(shotInfo: ShotInfo) {
    this.selectedShotLink.emit(shotInfo.link);
  }

}
