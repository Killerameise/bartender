import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { Shot } from '../../shot';
import { ShotOrder } from '../../shot-order';

@Component({
  selector: 'app-shot-detail',
  templateUrl: './shot-detail.component.html',
  styleUrls: ['./shot-detail.component.css']
})
export class ShotDetailComponent implements OnInit {

  @Input() shot: Shot;
  @Output() shotOrder: EventEmitter<ShotOrder> = new EventEmitter();

  constructor() { }

  ngOnInit() {
  }

  orderShot(quantity: number) {
    this.shotOrder.emit({
      shot: this.shot,
      quantity: quantity
    });
  }

}
