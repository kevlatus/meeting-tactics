import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatCardModule } from '@angular/material/card';

import { HomeRoutingModule } from './home-routing.module';
import { HomePageComponent } from './home-page/home-page.component';
import { IntroSectionComponent } from './intro-section/intro-section.component';
import { ToolCardComponent } from './tool-card/tool-card.component';


@NgModule({
  declarations: [
    HomePageComponent,
    IntroSectionComponent,
    ToolCardComponent,
  ],
  imports: [
    CommonModule,
    MatCardModule,

    HomeRoutingModule
  ]
})
export class HomeModule { }
