import {createAction} from '@ngrx/store';

enum ActionTypes {
  SET_TITLE = '[SETTINGS]SET_TITLE',
}

export const setTitleAction = createAction(
  ActionTypes.SET_TITLE,
  (title: string) => ({title}),
);
