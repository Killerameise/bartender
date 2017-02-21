import { Injectable } from '@angular/core';
import { Http, Response, Headers, RequestOptions } from "@angular/http";
import 'rxjs/Rx';

@Injectable()
export class BartenderService {

  private baseUrl: string = 'http://192.168.5.119:8080/bartender/rest/interface/v1/'
  private shotsUrl: string = this.baseUrl + 'shots/'

  constructor(private http: Http) { }

  getShotsInfoList() {
    return this.http.get(this.shotsUrl).map((res: Response) => res.json());
  }

  getShot(shotDetailUrl) {
    return this.http.get(shotDetailUrl).map((res: Response) => res.json());
  }

  makeShot(shotMakeUrl, quantity) {
    let headers = new Headers({ 'Content-Type': 'application/json' });
    let body = JSON.stringify({
      centiliter: quantity,
    });
    let options = new RequestOptions({ headers: headers });
    return this.http.post(shotMakeUrl, body, options).map((res: Response) => res.json());
  }
};
