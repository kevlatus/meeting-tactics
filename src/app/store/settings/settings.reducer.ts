import {Action, createReducer, on} from '@ngrx/store';

import {setTitleAction} from './settings.actions';

export interface SettingsState {
  title: string;
}

const initialState: SettingsState = {
  title: 'Meeting Tools',
};

const reducer = createReducer(
  initialState,
  on(setTitleAction, ((state, action) => ({...state, title: action.title}))),
);

export function settingsReducer(state: SettingsState, action: Action): SettingsState {
  return reducer(state, action);
}
