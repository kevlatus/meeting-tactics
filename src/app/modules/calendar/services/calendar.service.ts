import {Injectable} from '@angular/core';

import {AuthenticationService, ErrNotAuthenticated} from 'src/app/modules/authentication';
import {take} from 'rxjs/operators';
import {CalendarEvent, fromGoogleCalendar} from '../lib/calendar';

declare var gapi: any;

function getTodayStart() {
  const now = new Date();
  return new Date(now.getFullYear(), now.getMonth(), now.getDate());
}

function getTodayEnd() {
  const now = new Date();
  return new Date(now.getFullYear(), now.getMonth(), now.getDate(), 23, 59, 59);
}

@Injectable({
  providedIn: 'root'
})
export class CalendarService {
  private async ensureAuth(): Promise<void> {
    return await this.auth.user
      .pipe(take(1))
      .toPromise()
      .then(user => {
        if (!user) {
          throw ErrNotAuthenticated;
        }
      });
  }

  constructor(private auth: AuthenticationService) {
  }

  public async getEventsToday(): Promise<CalendarEvent[]> {
    return await this.ensureAuth()
      .then(async () => await gapi.client.calendar.events.list({
          calendarId: 'primary',
          timeMin: getTodayStart().toISOString(),
          timeMax: getTodayEnd().toISOString(),
          showDeleted: false,
          singleEvents: true,
          maxResults: 250,
          orderBy: 'startTime'
        })
      ).then(result => result.result.items.map(fromGoogleCalendar));
  }
}
