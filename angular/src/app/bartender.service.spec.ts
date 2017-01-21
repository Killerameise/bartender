/* tslint:disable:no-unused-variable */

import { TestBed, async, inject } from '@angular/core/testing';
import { BartenderService } from './bartender.service';

describe('BartenderService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [BartenderService]
    });
  });

  it('should ...', inject([BartenderService], (service: BartenderService) => {
    expect(service).toBeTruthy();
  }));
});
