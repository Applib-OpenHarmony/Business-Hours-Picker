/*
 * Copyright (C) 2022 Application Library Engineering Group
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { BusinessModel } from './BusinessModel';

@Component
export struct BusinessHoursWeekView {
  private businessHoursWeekViewModel = null
  private showBusinessModel: BusinessModel = undefined
  isToday = new Date().getDay()
  bhIcon: Resource = $r('app.media.calendar')
  bhIconPadding: number = 10
  bhTextColor: ResourceColor = '#000000'
  bhTextSize: number = 20
  bhTextStyle: string = 'calibri'
  bhTodayColor: ResourceColor = '#4e754d'
  bhTodayStyle: string = 'calibri'
  bhTodayTextSize: number = 20
  bhTodayIcon: Resource = $r('app.media.unlock')
  arr: number[] = [0, 1, 2, 3, 4, 5, 6]
  dayArr: string[] = BusinessModel.dayArr

  aboutToAppear() {
    this.showBusinessModel = new BusinessModel(this.showBusinessModel)
    if (this.businessHoursWeekViewModel == null) {
      this.businessHoursWeekViewModel = new BusinessHoursWeekViewModel(
        this.bhIcon,
        this.bhIconPadding,
        this.bhTextColor,
        this.bhTextSize,
        this.bhTextStyle,
        this.bhTodayColor,
        this.bhTodayStyle,
        this.bhTodayTextSize,
        this.bhTodayIcon,
        this.showBusinessModel
      )
    }
    this.bhIcon = this.businessHoursWeekViewModel.bhIcon
    this.bhIconPadding = this.businessHoursWeekViewModel.bhIconPadding
    this.bhTextColor = this.businessHoursWeekViewModel.bhTextColor
    this.bhTextSize = this.businessHoursWeekViewModel.bhTextSize
    this.bhTextStyle = this.businessHoursWeekViewModel.bhTextStyle
    this.bhTodayColor = this.businessHoursWeekViewModel.bhTodayColor
    this.bhTodayStyle = this.businessHoursWeekViewModel.bhTodayStyle
    this.bhTodayTextSize = this.businessHoursWeekViewModel.bhTodayTextSize
    this.bhTodayIcon = this.businessHoursWeekViewModel.bhTodayIcon
    this.showBusinessModel = this.businessHoursWeekViewModel.showBusinessModel
  }

  isWorking = (business: BusinessModel, dayInd: number): boolean => {
    if (business.getFromTime(dayInd) == "" && !business.isWorkingDay(dayInd)) {
      return false;
    }
    return true;
  }
  getFontStyle = (dayIndex: number): string => {
    if (dayIndex != this.isToday) {
      return this.bhTextStyle
    }
    else {
      return this.bhTodayStyle
    }
  }
  getFontSize = (dayIndex: number): number => {
    if (dayIndex != this.isToday) {
      return this.bhTextSize
    }
    else {
      return this.bhTodayTextSize
    }
  }
  getText = (business: BusinessModel, dayInd: number): string => {
    var a: string = ""
    if (!(business.getFromTime(dayInd) == "" && !business.isWorkingDay(dayInd))) {
      a = business.getFromTime(dayInd) + " - " + business.getToTime(dayInd)
    }
    return a;
  }
  getFontColor = (dayInd: number): ResourceColor => {
    if (dayInd != this.isToday) {
      return this.bhTextColor
    }
    else {
      return this.bhTodayColor
    }
  }
  getImage = (bus: BusinessModel, dayInd): Resource => {
    if (dayInd != this.isToday) {
      return this.bhIcon
    }
    else {
      return this.bhTodayIcon
    }
  }

  build() {
    Column({ space: 10 }) {
      ForEach(this.arr,
        item => {
          if (this.isWorking(this.showBusinessModel, item + 1)) {
            Row({ space: 10 }) {
              Image(this.getImage(this.showBusinessModel, item + 1)).width(20).height(20).objectFit(ImageFit.ScaleDown)
              Text(this.dayArr[item] + ", " + this.getText(this.showBusinessModel, item + 1))
                .fontSize(this.getFontSize(item + 1))
                .fontColor(this.getFontColor(item + 1))
                .fontFamily(this.getFontStyle(item + 1))
                .padding({ left: this.bhIconPadding })
            }.width('100%')
          }
        }
      )
    }.padding(20).backgroundColor(0xFFFFFF)
  }
}

class BusinessHoursWeekViewModel {
  bhIcon: Resource = $r('app.media.calendar')
  bhIconPadding: number = 10
  bhTextColor: ResourceColor = '#000000'
  bhTextSize: number = 20
  bhTextStyle: string = 'calibri'
  bhTodayColor: ResourceColor = '#4e754d'
  bhTodayStyle: string = 'calibri'
  bhTodayTextSize: number = 20
  bhTodayIcon: Resource = $r('app.media.unlock')
  showBusinessModel: BusinessModel = null

  constructor(
    bhIcon?: Resource,
    bhIconPadding?: number,
    bhTextColor?: ResourceColor,
    bhTextSize?: number,
    bhTextStyle?: string,
    bhTodayColor?: ResourceColor,
    bhTodayStyle?: string,
    bhTodayTextSize?: number,
    bhTodayIcon?: Resource,
    showBusinessModel?: BusinessModel
  ) {
    if (bhIcon && (bhIcon != null)) this.bhIcon = bhIcon
    if (bhIconPadding) this.bhIconPadding = bhIconPadding
    if (bhTextColor && (bhTextColor != null)) this.bhTextColor = bhTextColor
    if (bhTextSize) this, bhTextSize = bhTextSize
    if (bhTextStyle && (bhTextStyle != null) && (bhTextStyle.length > 0)) this.bhTextStyle = bhTextStyle
    if (bhTodayColor && (bhTodayColor != null)) this.bhTodayColor = bhTodayColor
    if (bhTodayStyle && (bhTodayStyle != null) && (bhTodayStyle.length > 0)) this.bhTodayStyle = bhTodayStyle
    if (bhTodayTextSize) this, bhTodayTextSize = bhTodayTextSize
    if (bhTodayIcon && (bhTodayIcon != null)) this.bhTodayIcon = bhTodayIcon
    if (showBusinessModel && (showBusinessModel != null)) {
      this.showBusinessModel = showBusinessModel
    }
    else {
      this.showBusinessModel = new BusinessModel()
    }
  }
}