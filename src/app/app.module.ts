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
import { ServiceWorkerModule } from '@angular/service-worker';

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
    ServiceWorkerModule.register('ngsw-worker.js', { enabled: environment.production }),
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule {
}
