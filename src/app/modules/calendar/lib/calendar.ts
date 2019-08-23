export interface CalendarEvent {
  name: string;
  start: Date;
  end: Date;
  attendees: string[];
}

export function fromGoogleCalendar(obj: any): CalendarEvent {
  return {
    name: obj.summary,
    start: new Date(obj.start.datetime),
    end: new Date(obj.end.datetime),
    attendees: obj.attendees.map(v => v.email),
  };
}
