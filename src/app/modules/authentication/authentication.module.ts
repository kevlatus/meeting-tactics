import {ModuleWithProviders, NgModule} from '@angular/core';
import {AngularFireAuthModule} from '@angular/fire/auth';
import {NgkComponentsModule} from 'ngk-components';

import {AuthenticationService} from './services/authentication.service';


@NgModule({
  declarations: [],
  imports: [
    AngularFireAuthModule,
    NgkComponentsModule,
  ],
  exports: []
})
export class AuthenticationModule {
  public static forRoot(): ModuleWithProviders {
    return {
      ngModule: AuthenticationModule,
      providers: [
        AuthenticationService,
      ],
    };
  }
}
