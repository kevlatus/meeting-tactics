import {ActionReducerMap} from '@ngrx/store';

import {settingsReducer, SettingsState} from './settings/settings.reducer';

export interface AppState {
  settings: SettingsState;
}

export const rootReducer: ActionReducerMap<AppState> = {
  settings: settingsReducer,
};
