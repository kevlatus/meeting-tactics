import {ModuleWithProviders, NgModule} from '@angular/core';
import {AngularFireAuthModule} from '@angular/fire/auth';

import {AuthenticationService} from './services/authentication.service';


@NgModule({
  declarations: [],
  imports: [
    AngularFireAuthModule,
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
