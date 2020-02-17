import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { NgModule } from '@angular/core';
import { AngularFireModule } from '@angular/fire';
import { AngularFireAnalyticsModule, CONFIG, UserTrackingService } from '@angular/fire/analytics';
import { MatToolbarModule } from '@angular/material/toolbar';
import { ServiceWorkerModule } from '@angular/service-worker';
import { StoreModule } from '@ngrx/store';
import { ScullyLibModule } from '@scullyio/ng-lib';

import { environment } from '../environments/environment';
import { AppComponent } from './app.component';
import { rootReducer } from './store';
import { AppRoutingModule } from './app-routing.module';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    MatToolbarModule,
    StoreModule.forRoot(rootReducer),
    AngularFireModule.initializeApp(environment.firebase),
    AngularFireAnalyticsModule,
    ScullyLibModule,
    ServiceWorkerModule.register('ngsw-worker.js', { enabled: environment.production }),

    AppRoutingModule,
  ],
  providers: [
    UserTrackingService,
    {
      provide: CONFIG, useValue: {
        send_page_view: true,
        anonymize_ip: true
      }
    }
  ],
  bootstrap: [AppComponent]
})
export class AppModule {
}
