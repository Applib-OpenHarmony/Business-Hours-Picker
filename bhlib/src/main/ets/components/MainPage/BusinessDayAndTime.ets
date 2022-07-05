///*
// * Copyright (C) 2022 Application Library Engineering Group
// *
// * Licensed under the Apache License, Version 2.0 (the "License");
// * you may not use this file except in compliance with the License.
// * You may obtain a copy of the License at
// *
// *      http://www.apache.org/licenses/LICENSE-2.0
// *
// * Unless required by applicable law or agreed to in writing, software
// * distributed under the License is distributed on an "AS IS" BASIS,
// * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// * See the License for the specific language governing permissions and
// * limitations under the License.
// */
//
//import { BusinessModel } from './BusinessModel';
//import { a12, a24 } from './values'
//
//@CustomDialog
//export struct TimeSelectorDialog {
//  time: string
//  where: string
//  dayInd: number
//  format: number
//  callback: (selIndex, where, dayInd) => void
//  arr12 = a12
//  arr24 = a24
//  controller: CustomDialogController
//
//  build() {
//    Column() {
//      List({ initialIndex: 0 }) {
//        if (this.format == 24) {
//          ForEach(this.arr24, (item) => {
//            ListItem() {
//              Text(item)
//                .fontSize(16)
//                .width('100%')
//                .padding(10)
//                .textAlign(TextAlign.Center)
//                .backgroundColor(0xFFFFFF)
//                .onClick(() => {
//                  this.callback(item, this.where, this.dayInd)
//                  this.controller.close()
//                })
//            }
//          }, item => item)
//        }
//        else {
//          ForEach(this.arr12, (item) => {
//            ListItem() {
//              Text(item)
//                .fontSize(16)
//                .width('100%')
//                .padding(10)
//                .textAlign(TextAlign.Center)
//                .backgroundColor(0xFFFFFF)
//                .onClick(() => {
//                  this.callback(item, this.where, this.dayInd)
//                  this.controller.close()
//                })
//            }
//          }, item => item)
//        }
//      }
//      .listDirection(Axis.Vertical)
//      .divider({ strokeWidth: 2, color: 0xd5d9de })
//      .edgeEffect(EdgeEffect.Spring)
//    }.height('60%').width('50%')
//    .borderRadius(20)
//  }
//}
//
//
//@Component
//export struct BusinessDayAndTime {
//  @State fTime: string = ""
//  @State tTime: string = ""
//  where: string = "from"
//  bhFormat: number = 24
//  private dayIndex: number = 0;
//  dialogController: CustomDialogController = new CustomDialogController({
//    builder: TimeSelectorDialog({
//      time: this.fTime,
//      where: this.where,
//      dayInd: this.dayIndex,
//      format: this.bhFormat,
//      callback: (selIndex) => this.cb(selIndex, this.where, this.dayIndex)
//    }),
//    autoCancel: true,
//    customStyle: true,
//    alignment: DialogAlignment.Default
//  })
//
//  cb(selIndex: string, what: string, dayInd: number) {
//    if (selIndex != null && what != null && dayInd != null){
//      if (what === "from") {
//        this.fTime = selIndex
//        this.business.setFromTime(dayInd, this.fTime)
//      }
//      else {
//        this.tTime = selIndex
//        this.business.setToTime(dayInd, this.tTime)
//      }
//    }
//  }
//
//  bhTextColor: ResourceColor = '#000000'
//  bhTodayColor: ResourceColor = '#4e754d'
//  bhTextSize: number = 20
//  bhTextStyle: string = 'calibri'
//  private day: string = "";
//  @State toggle: boolean = false
//  @Link business: BusinessModel
//  temp: Resource = $r('app.media.drop')
//
//  build() {
//    Column() {
//      Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
//        Text(this.day).fontSize(this.bhTextSize).fontColor(this.bhTextColor).fontFamily(this.bhTextStyle)
//        Toggle({ type: ToggleType.Switch, isOn: this.toggle })
//          .selectedColor(this.bhTodayColor)
//          .onChange((isOn: boolean = this.toggle) => {
//            if (isOn) {
//              this.toggle = true;
//            }
//            this.business.setWorkingDay(this.dayIndex, isOn);
//            if (!isOn) {
//              this.fTime = ""
//              this.tTime = ""
//              this.toggle = false
//              this.business.setFromTime(this.dayIndex, "")
//              this.business.setToTime(this.dayIndex, "")
//              this.business.setWorkingDay(this.dayIndex, false)
//            }
//          })
//      }.height(40)
//
//      if (this.business.isWorkingDay(this.dayIndex)) {
//        Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
//          Column() {
//            Flex({ justifyContent: FlexAlign.SpaceBetween }) {
//              Text(this.fTime).fontSize(this.bhTextSize).fontColor(this.bhTextColor).fontFamily(this.bhTextStyle)
//              Image(this.temp).height(20).width(20)
//            }.onClick(() => {
//              this.where = "from"
//              this.dialogController.open()
//            })
//          }.padding({ right: 5 })
//
//          Column() {
//            Flex({ justifyContent: FlexAlign.SpaceBetween }) {
//              Text(this.tTime)
//                .fontSize(this.bhTextSize)
//                .fontColor(this.bhTextColor)
//                .fontFamily(this.bhTextStyle)
//                .margin({ left: 5 })
//              Image(this.temp).height(20).width(20)
//            }.onClick(() => {
//              this.where = "to"
//              this.dialogController.open()
//            })
//          }
//        }.padding({ top: 20, right: 20 })
//
//        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
//          Divider().width(120).strokeWidth(1.2)
//          Divider().width(120).margin({ right: 30 }).strokeWidth(1.2)
//        }.padding({ bottom: 20 })
//      }
//    }
//  }
//}


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

@CustomDialog
export struct TimeSelectorDialog {
  time: string
  where: string
  dayInd: number
  format: number
  callback: (selIndex, where, dayInd) => void
  arr12: string [] = [
    "24h", "12:00 AM", "01:00 AM", "02:00 AM", "03:00 AM",
    "04:00 AM", "05:00 AM", "06:00 AM", "07:00 AM", "08:00 AM",
    "09:00 AM", "10:00 AM", "11:00 AM", "12:00 PM", "01:00 PM",
    "02:00 PM", "03:00 PM", "04:00 PM", "05:00 PM", "06:00 PM",
    "07:00 PM", "08:00 PM", "09:00 PM", "10:00 PM", "11:00 PM",
  ]
  arr24: string[]
    = [
    "24h", "00:00", "01:00", "02:00", "03:00",
    "04:00", "05:00", "06:00", "07:00", "08:00",
    "09:00", "10:00", "11:00", "12:00", "13:00",
    "14:00", "15:00", "16:00", "17:00", "18:00",
    "19:00", "20:00", "21:00", "22:00", "23:00",
  ]
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
  @State private fTime: string = ""
  @State private tTime: string = ""
  where: string = "from"
  bhFormat: number = 24
  private dayIndex: number = 0;
  bhTextColor: ResourceColor = '#000000'
  bhTodayColor: ResourceColor = '#4e754d'
  bhTextSize: number = 20
  bhTextStyle: string = 'calibri'
  private day: string = "";
  @State toggle: boolean = false
  @Link businessModel: BusinessModel
  temp: Resource = $r('app.media.drop')

  aboutToAppear() {
    if (this.businessDayAndTimeModel == null) {
      this.businessDayAndTimeModel = new BusinessDayAndTimeModel(this.bhFormat,
        this.dayIndex,
        this.bhTextColor,
        this.bhTodayColor,
        this.bhTextSize,
        this.bhTextStyle,
        this.day,
        this.toggle,
        this.businessModel)
    }
    this.bhFormat = this.businessDayAndTimeModel.bhFormat
    this.dayIndex = this.businessDayAndTimeModel.dayIndex
    this.bhTextColor = this.businessDayAndTimeModel.bhTextColor
    this.bhTodayColor = this.businessDayAndTimeModel.bhTodayColor
    this.bhTextSize = this.businessDayAndTimeModel.bhTextSize
    this.bhTextStyle = this.businessDayAndTimeModel.bhTextStyle
    this.day = this.businessDayAndTimeModel.day
    this.toggle = this.businessDayAndTimeModel.toggle
    this.businessModel = this.businessDayAndTimeModel.businessModel
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
  day: string = "";
  toggle: boolean = false
  businessModel: BusinessModel = null

  constructor(bhFormat?: number,
              dayIndex?: number,
              bhTextColor?: ResourceColor,
              bhTodayColor?: ResourceColor,
              bhTextSize?: number,
              bhTextStyle?: string,
              day?: string,
              toggle?: boolean,
              businessModel?: BusinessModel) {
    if (bhFormat) this.bhFormat = bhFormat
    if (dayIndex) this.dayIndex = dayIndex
    if (bhTextColor && (bhTextColor != null)) this.dayIndex = dayIndex
    if (bhTodayColor && (bhTodayColor != null)) this.bhTodayColor = bhTodayColor
    if (bhTextSize) this.bhTextSize = bhTextSize
    if (bhTextStyle && (bhTextStyle != null) && bhTextStyle.length > 0) this.bhTextStyle = bhTextStyle
    if (day && (day != null)) this.day = day
    if (toggle) this.toggle = toggle
    if (businessModel && (businessModel != null)) {
      this.businessModel = businessModel
    }
    else {
      this.businessModel = new BusinessModel()
    }
  }
}