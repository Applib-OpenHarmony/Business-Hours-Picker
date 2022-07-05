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
import { a12, a24 } from './values'

@CustomDialog
export struct TimeSelectorDialog {
  time: string
  where: string
  dayInd: number
  format: number
  callback: (selIndex, where, dayInd) => void
  arr12 = a12
  arr24 = a24
  controller: CustomDialogController

  build() {
    Column() {
      List({ initialIndex: 0 }) {
        if (this.format == 24) {
          ForEach(this.arr24, (item) => {
            ListItem() {
              Text(item)
                .fontSize(16)
                .width('100%')
                .padding(10)
                .textAlign(TextAlign.Center)
                .backgroundColor(0xFFFFFF)
                .onClick(() => {
                  this.callback(item, this.where, this.dayInd)
                  this.controller.close()
                })
            }
          }, item => item)
        }
        else {
          ForEach(this.arr12, (item) => {
            ListItem() {
              Text(item)
                .fontSize(16)
                .width('100%')
                .padding(10)
                .textAlign(TextAlign.Center)
                .backgroundColor(0xFFFFFF)
                .onClick(() => {
                  this.callback(item, this.where, this.dayInd)
                  this.controller.close()
                })
            }
          }, item => item)
        }
      }
      .listDirection(Axis.Vertical)
      .divider({ strokeWidth: 2, color: 0xd5d9de })
      .edgeEffect(EdgeEffect.Spring)
    }.height('60%').width('50%')
    .borderRadius(20)
  }
}


@Component
export struct BusinessDayAndTime {
  private businessDayAndTimeModel: BusinessDayAndTimeModel = null
  private dayIndex: number = 0
  private day: string = ""
  @State private fTime: string = ""
  @State private tTime: string = ""
  @State toggle: boolean = false
  @Link businessModel: BusinessModel
  where: string = "from"
  bhFormat: number = 24
  bhTextColor: ResourceColor = '#000000'
  bhTodayColor: ResourceColor = '#4e754d'
  bhTextSize: number = 20
  bhTextStyle: string = 'calibri'
  temp: Resource = $r('app.media.drop')

  aboutToAppear() {
    if (this.businessDayAndTimeModel == null) {
      this.businessDayAndTimeModel = new BusinessDayAndTimeModel(this.bhFormat,
        this.dayIndex,
        this.bhTextColor,
        this.bhTodayColor,
        this.bhTextSize,
        this.bhTextStyle,
        this.day)
    }
    this.bhFormat = this.businessDayAndTimeModel.bhFormat
    this.dayIndex = this.businessDayAndTimeModel.dayIndex
    this.bhTextColor = this.businessDayAndTimeModel.bhTextColor
    this.bhTodayColor = this.businessDayAndTimeModel.bhTodayColor
    this.bhTextSize = this.businessDayAndTimeModel.bhTextSize
    this.bhTextStyle = this.businessDayAndTimeModel.bhTextStyle
    this.day = this.businessDayAndTimeModel.day
  }

  dialogController: CustomDialogController = new CustomDialogController({
    builder: TimeSelectorDialog({
      time: this.fTime,
      where: this.where,
      dayInd: this.dayIndex,
      format: this.bhFormat,
      callback: (selIndex) => this.callback(selIndex, this.where, this.dayIndex)
    }),
    autoCancel: true,
    customStyle: true,
    alignment: DialogAlignment.Default
  })

  callback(selIndex: string, what: string, dayInd: number) {
    if (what === "from") {
      this.fTime = selIndex
      this.businessModel.setFromTime(dayInd, this.fTime)
    }
    else {
      this.tTime = selIndex
      this.businessModel.setToTime(dayInd, this.tTime)
    }
  }

  build() {
    Column() {
      Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
        Text(this.day).fontSize(this.bhTextSize).fontColor(this.bhTextColor).fontFamily(this.bhTextStyle)
        Toggle({ type: ToggleType.Switch, isOn: this.toggle })
          .selectedColor(this.bhTodayColor)
          .onChange((isOn: boolean = this.toggle) => {
            if (isOn) {
              this.toggle = true;
            }
            this.businessModel.setWorkingDay(this.dayIndex, isOn);
            if (!isOn) {
              this.fTime = ""
              this.tTime = ""
              this.toggle = false
              this.businessModel.setFromTime(this.dayIndex, "")
              this.businessModel.setToTime(this.dayIndex, "")
              this.businessModel.setWorkingDay(this.dayIndex, false)
            }
          })
      }.height(40)

      if (this.businessModel.isWorkingDay(this.dayIndex)) {
        Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
          Column() {
            Flex({ justifyContent: FlexAlign.SpaceBetween }) {
              Text(this.fTime).fontSize(this.bhTextSize).fontColor(this.bhTextColor).fontFamily(this.bhTextStyle)
              Image(this.temp).height(20).width(20)
            }.onClick(() => {
              this.where = "from"
              this.dialogController.open()
            })
          }.padding({ right: 5 })

          Column() {
            Flex({ justifyContent: FlexAlign.SpaceBetween }) {
              Text(this.tTime)
                .fontSize(this.bhTextSize)
                .fontColor(this.bhTextColor)
                .fontFamily(this.bhTextStyle)
                .margin({ left: 5 })
              Image(this.temp).height(20).width(20)
            }.onClick(() => {
              this.where = "to"
              this.dialogController.open()
            })
          }
        }.padding({ top: 20, right: 20 })

        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
          Divider().width(120).strokeWidth(1.2)
          Divider().width(120).margin({ right: 30 }).strokeWidth(1.2)
        }.padding({ bottom: 20 })
      }
    }
  }
}

class BusinessDayAndTimeModel {
  bhFormat: number = 24
  dayIndex: number = 0;
  bhTextColor: ResourceColor = '#000000'
  bhTodayColor: ResourceColor = '#4e754d'
  bhTextSize: number = 20
  bhTextStyle: string = 'calibri'
  day: string = ""
  businessModel: BusinessModel = null

  constructor(bhFormat?: number,
              dayIndex?: number,
              bhTextColor?: ResourceColor,
              bhTodayColor?: ResourceColor,
              bhTextSize?: number,
              bhTextStyle?: string,
              day?: string,
              businessModel?: BusinessModel) {
    if (bhFormat) this.bhFormat = bhFormat
    if (dayIndex) this.dayIndex = dayIndex
    if (bhTextColor && (bhTextColor != null)) this.dayIndex = dayIndex
    if (bhTodayColor && (bhTodayColor != null)) this.bhTodayColor = bhTodayColor
    if (bhTextSize) this.bhTextSize = bhTextSize
    if (bhTextStyle && (bhTextStyle != null) && bhTextStyle.length > 0) this.bhTextStyle = bhTextStyle
    if (day && (day != null)) this.day = day
  }
}