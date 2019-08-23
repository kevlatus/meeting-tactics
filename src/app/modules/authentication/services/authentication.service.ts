import {Injectable} from '@angular/core';
import {AngularFireAuth} from '@angular/fire/auth';
import {auth, User} from 'firebase/app';

import {environment} from 'src/environments/environment';
import {Observable} from 'rxjs';

declare var gapi: any;

@Injectable({
  providedIn: 'root'
})
export class AuthenticationService {
  private apiLoaded = false;
  public readonly user: Observable<User>;

  private initClient() {
    if (!this.apiLoaded) {
      gapi.load('client', () => {
        this.apiLoaded = true;

        gapi.client.init({
          apiKey: environment.firebase.apiKey,
          clientId: environment.oauthClientId,
          discoveryDocs: ['https://www.googleapis.com/discovery/v1/apis/calendar/v3/rest'],
          scope: 'https://www.googleapis.com/auth/calendar'
        });

        gapi.client.load('calendar', 'v3', () => null);
      });
    }
  }

  constructor(private afAuth: AngularFireAuth) {
    this.user = afAuth.user;
    this.initClient();
  }

  // public async promptLogin() {
  //   return await this.ngkDialog.auth({showMail: false})
  //     .toPromise()
  //     .then(result => {
  //       if (result && result.type === 'google') {
  //         return this.login();
  //       }
  //     });
  // }

  public async login() {
    const googleAuth = gapi.auth2.getAuthInstance();
    const googleUser = await googleAuth.signIn();

    const token = googleUser.getAuthResponse().id_token;
    const credential = auth.GoogleAuthProvider.credential(token);
    await this.afAuth.auth.signInWithCredential(credential);
  }

  public async logout() {
    return this.afAuth.auth.signOut();
  }
}
