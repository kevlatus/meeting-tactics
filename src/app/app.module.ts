import {BrowserModule} from '@angular/platform-browser';
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';
import {NgModule} from '@angular/core';
import {AngularFireModule} from '@angular/fire';
import {MatToolbarModule} from '@angular/material/toolbar';
import {StoreModule} from '@ngrx/store';
import {NgkComponentsModule} from 'ngk-components';

import {environment} from '../environments/environment';
import {AppComponent} from './app.component';
import {rootReducer} from './store';
import {AppRoutingModule} from './app-routing.module';
import {AuthenticationModule} from './modules/authentication';
import {CalendarModule} from './modules/calendar/calendar.module';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    MatToolbarModule,
    StoreModule.forRoot(rootReducer),
    NgkComponentsModule,
    AngularFireModule.initializeApp(environment.firebase),

    AppRoutingModule,
    AuthenticationModule.forRoot(),
    CalendarModule.forRoot(),
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule {
}
