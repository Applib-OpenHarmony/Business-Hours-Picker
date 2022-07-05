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
import { BusinessDayAndTime } from './BusinessDayAndTime';

@Component
export struct BusinessPicker {
  private businessPickerModel: BusinessPickerModel = null
  @Link selectedBusinessModel: BusinessModel
  day: string [] = BusinessModel.dayArr
  arr: number[] = [0, 1, 2, 3, 4, 5, 6]
  bhTextColor: ResourceColor = '#000000'
  bhTextSize: number = 20
  bhTextStyle: string = 'calibri'
  bhFormat: number = 24
  bhTodayColor: ResourceColor = '#4e754d'

  aboutToAppear() {
    if (this.businessPickerModel == null) {
      this.businessPickerModel = new BusinessPickerModel(
        this.bhTextColor,
        this.bhTextSize,
        this.bhTextStyle,
        this.bhFormat,
        this.bhTodayColor,
        this.selectedBusinessModel
      )
    }
    this.bhTextColor = this.businessPickerModel.bhTextColor
    this.bhTextSize = this.businessPickerModel.bhTextSize
    this.bhTextStyle = this.businessPickerModel.bhTextStyle
    this.bhFormat = this.businessPickerModel.bhFormat
    this.bhTodayColor = this.businessPickerModel.bhTodayColor
    this.selectedBusinessModel = this.businessPickerModel.selectedBusinessModel
  }

  build() {
    Column() {
      ForEach(this.arr,
        item => {
          BusinessDayAndTime({
            dayIndex: item + 1,
            day: this.day[item],
            businessModel: $selectedBusinessModel,
            bhTextColor: this.bhTextColor,
            bhTextSize: this.bhTextSize,
            bhTextStyle: this.bhTextStyle,
            bhFormat: this.bhFormat,
            bhTodayColor: this.bhTodayColor
          })
        }
      )
    }.padding(20)
  }
}

class BusinessPickerModel {
  bhFormat: number = 24
  bhTextColor: ResourceColor = '#000000'
  bhTodayColor: ResourceColor = '#4e754d'
  bhTextSize: number = 20
  bhTextStyle: string = 'calibri'
  selectedBusinessModel: BusinessModel = null

  constructor(
    bhTextColor?: ResourceColor,
    bhTextSize?: number,
    bhTextStyle?: string,
    bhFormat?: number,
    bhTodayColor?: ResourceColor,
    selectedBusinessModel?: BusinessModel
  ) {
    if (bhTextColor && (bhTextColor != null)) this.bhTextColor = bhTextColor
    if (bhTextSize) this.bhTextSize = bhTextSize
    if (bhTextStyle && (bhTextStyle != null) && bhTextStyle.length > 0) this.bhTextStyle = bhTextStyle
    if (bhFormat) this.bhFormat = bhFormat
    if (bhTodayColor && (bhTodayColor != null))  this.bhTodayColor = bhTodayColor
    if (selectedBusinessModel && (selectedBusinessModel != null)) {
      this.selectedBusinessModel = selectedBusinessModel
    }
    else {
      this.selectedBusinessModel = new BusinessModel()
    }
  }
}