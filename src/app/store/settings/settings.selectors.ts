import {createSelector} from '@ngrx/store';

import {AppState} from 'src/app/store';

const featureSelector = (state: AppState) => state.settings;

export const selectAppTitle = createSelector(
  featureSelector,
  settings => settings.title,
);
