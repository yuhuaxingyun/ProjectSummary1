// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: Scentrealm.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30002
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30002 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

@class AppControlSet;
@class AppControlSlider;
@class AppControlSpin;
@class AppControlSwitch;
@class AppControlSwitchSlider;
@class BaseRequest;
@class BaseResponse;
@class DevAttrOption;
@class PlayRequest_PlayAction;
@class PlayRequest_PlayTrace;
@class RemoveTaskRequest_RemoveTaskOption;
@class SetControlAttrRequest_SetControlAttr;
@class TimePoint;
@class UsedTimeResponse_UsedTime;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum SrCmdId

/** 指令集 ，包头 nCmdId字段 */
typedef GPB_ENUM(SrCmdId) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  SrCmdId_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  /** Just a place holder */
  SrCmdId_SciCmdNone = 0,

  /** Request CMD */
  SrCmdId_SciReqSleep = 10001,

  /** 唤醒主机 request; */
  SrCmdId_SciReqWakeup = 10002,

  /** 获取瓶子使用总时间（秒） request; */
  SrCmdId_SciReqUsedseconds = 10003,

  /** 播放气味 request; */
  SrCmdId_SciReqPlaysmell = 10004,

  /** 获取设置 request; */
  SrCmdId_SciReqGetdevattr = 10005,

  /** 修改设置 request; */
  SrCmdId_SciReqSetdevattr = 10006,

  /** 设备设备模型信息获取 request; */
  SrCmdId_SciReqDeviceModel = 10007,

  /** 设备停止播放某个气味 request; */
  SrCmdId_SciReqStopPlay = 10008,

  /** 移除设备任务 request; */
  SrCmdId_SciReqRemoveTask = 10009,

  /** 设置控件属性 request; */
  SrCmdId_SciReqSetControlAttr = 10010,

  /** 获取设备附近的 wifi 信号列表 request; */
  SrCmdId_SciReqDevWifiList = 10011,

  /** 设置设备 wifi 用户名密码 request; */
  SrCmdId_SciReqSetDevWifi = 10012,

  /** 设置设备连接 wifi 结果上报 request; */
  SrCmdId_SciReqWifiConnReport = 10013,

  /** 设置设备连接网络结果上报 request; */
  SrCmdId_SciReqNetConnReport = 10014,

  /** Response CMD */
  SrCmdId_SciRespSleep = 20001,

  /** 唤醒主机 response; */
  SrCmdId_SciRespWakeup = 20002,

  /** 获取瓶子使用总时间（秒） response; */
  SrCmdId_SciRespUsedseconds = 20003,

  /** 播放气味 response; */
  SrCmdId_SciRespPlaysmell = 20004,

  /** 获取设置 response; */
  SrCmdId_SciRespGetdevattr = 20005,

  /** 修改设置 response; */
  SrCmdId_SciRespSetdevattr = 20006,

  /** 设备设备模型信息获取 response; */
  SrCmdId_SciRespDeviceModel = 20007,

  /** 设备停止播放某个气味 response; */
  SrCmdId_SciRespStopPlay = 20008,

  /** 移除设备任务 response; */
  SrCmdId_SciRespRemoveTask = 20009,

  /** 设置控件属性 response; */
  SrCmdId_SciRespSetControlAttr = 20010,

  /** 设置设备附近的 wifi 信号列表 response; */
  SrCmdId_SciRespDevWifiList = 20011,

  /** 设置设备 wifi 用户名密码 response; */
  SrCmdId_SciRespSetDevWifi = 20012,

  /** 设置设备连接 wifi 结果上报 response; */
  SrCmdId_SciRespWifiConnReport = 20013,

  /** 设置设备连接网络结果上报 response; */
  SrCmdId_SciRespNetConnReport = 20014,

  /** Push Request , No Response */
  SrCmdId_SciPush = 30000,
};

GPBEnumDescriptor *SrCmdId_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL SrCmdId_IsValidValue(int32_t value);

#pragma mark - Enum SrErrorCode

/** 返回码 */
typedef GPB_ENUM(SrErrorCode) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  SrErrorCode_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  /** 无状态 */
  SrErrorCode_SecNone = 0,

  /** 任务完成 */
  SrErrorCode_SecSuccess = 10000,

  /** 接受任务 */
  SrErrorCode_SecAccept = 10001,

  /** 出现错误 */
  SrErrorCode_SecError = 20000,

  /** 拒绝任务 */
  SrErrorCode_SecReject = 20001,
};

GPBEnumDescriptor *SrErrorCode_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL SrErrorCode_IsValidValue(int32_t value);

#pragma mark - Enum SrTimeMode

/** 时间模式 */
typedef GPB_ENUM(SrTimeMode) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  SrTimeMode_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  SrTimeMode_StmNone = 0,

  /** 相对时间模式，对应几秒后 */
  SrTimeMode_StmRelative = 1,

  /** 固定时间点，对应yyyy-MM-dd HH:mm:ss */
  SrTimeMode_StmAbsolute = 2,

  /** 今日第几秒 */
  SrTimeMode_StmDaytime = 3,

  /** 周几 */
  SrTimeMode_StmWeekday = 4,

  /** 某月的第几天 */
  SrTimeMode_StmMonthday = 5,

  /** 月份 */
  SrTimeMode_StmMonth = 6,

  /** 年份 */
  SrTimeMode_StmYear = 7,
};

GPBEnumDescriptor *SrTimeMode_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL SrTimeMode_IsValidValue(int32_t value);

#pragma mark - Enum SrCycleMode

/** 循环模式 */
typedef GPB_ENUM(SrCycleMode) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  SrCycleMode_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  SrCycleMode_ScmNone = 0,

  /** 不循环 */
  SrCycleMode_ScmCycleNo = 1,

  /** 循环 */
  SrCycleMode_ScmCycleYes = 2,

  /** 无限循环 */
  SrCycleMode_ScmCycleInfinite = 3,
};

GPBEnumDescriptor *SrCycleMode_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL SrCycleMode_IsValidValue(int32_t value);

#pragma mark - Enum SrRemoveTaskMode

/** 移除任务的模式 */
typedef GPB_ENUM(SrRemoveTaskMode) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  SrRemoveTaskMode_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  SrRemoveTaskMode_SrtNone = 0,

  /** 停止本次并取消该任务 */
  SrRemoveTaskMode_SrtStopCancel = 1,

  /** 停止当前在运行的该任务，但是不取消 */
  SrRemoveTaskMode_SrtStopNotcancel = 2,

  /** 不停止正在运行的该任务，取消未运行的 */
  SrRemoveTaskMode_SrtNotstopCancel = 3,
};

GPBEnumDescriptor *SrRemoveTaskMode_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL SrRemoveTaskMode_IsValidValue(int32_t value);

#pragma mark - Enum SrDevAttrType

/** 设备属性类型 */
typedef GPB_ENUM(SrDevAttrType) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  SrDevAttrType_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  SrDevAttrType_SdstNone = 0,

  /** 设备唯一标识 */
  SrDevAttrType_SdstDeviceid = 1,

  /** 设备名字 */
  SrDevAttrType_SdstDevicename = 2,

  /** 设备类别 */
  SrDevAttrType_SdstDevicetype = 3,

  /** MAC */
  SrDevAttrType_SdstMac = 4,

  /** wifi ssid */
  SrDevAttrType_SdstWifissid = 5,

  /** wifi 密码 */
  SrDevAttrType_SdstWifipwd = 6,

  /** 网络连接状态 */
  SrDevAttrType_SdstNetconnectstate = 7,

  /** 蓝牙连接状态 */
  SrDevAttrType_SdstBleconnectstate = 8,

  /** 日志开启状态 */
  SrDevAttrType_SdstLogstate = 9,

  /** 时间 */
  SrDevAttrType_SdstDatetime = 10,

  /** 设备上次开机时间 */
  SrDevAttrType_SdstUptime = 11,

  /** 设备上次关机时间 */
  SrDevAttrType_SdstDowntime = 12,
};

GPBEnumDescriptor *SrDevAttrType_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL SrDevAttrType_IsValidValue(int32_t value);

#pragma mark - Enum SrSwitchStatus

/** 开关状态 */
typedef GPB_ENUM(SrSwitchStatus) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  SrSwitchStatus_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  /** 无 */
  SrSwitchStatus_SssNone = 0,

  /** 开 */
  SrSwitchStatus_SssOn = 1,

  /** 关 */
  SrSwitchStatus_SssOff = 2,
};

GPBEnumDescriptor *SrSwitchStatus_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL SrSwitchStatus_IsValidValue(int32_t value);

#pragma mark - ScentrealmRoot

/**
 * Exposes the extension registry for this file.
 *
 * The base class provides:
 * @code
 *   + (GPBExtensionRegistry *)extensionRegistry;
 * @endcode
 * which is a @c GPBExtensionRegistry that includes all the extensions defined by
 * this file and all files that it depends on.
 **/
@interface ScentrealmRoot : GPBRootObject
@end

#pragma mark - BaseResponse

typedef GPB_ENUM(BaseResponse_FieldNumber) {
  BaseResponse_FieldNumber_Code = 1,
  BaseResponse_FieldNumber_Msg = 2,
};

/**
 * 基础返回格式，简单数据的返回使用该结构返回，如获取mac，获取开机时间等
 **/
@interface BaseResponse : GPBMessage

/** 返回成功与否 */
@property(nonatomic, readwrite) SrErrorCode code;

/** 返回数据 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *msg;

@end

/**
 * Fetches the raw value of a @c BaseResponse's @c code property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t BaseResponse_Code_RawValue(BaseResponse *message);
/**
 * Sets the raw value of an @c BaseResponse's @c code property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetBaseResponse_Code_RawValue(BaseResponse *message, int32_t value);

#pragma mark - BaseRequest

/**
 * 公共请求
 **/
@interface BaseRequest : GPBMessage

@end

#pragma mark - UsedTimeResponse

typedef GPB_ENUM(UsedTimeResponse_FieldNumber) {
  UsedTimeResponse_FieldNumber_Response = 1,
  UsedTimeResponse_FieldNumber_UsedTimeArray = 2,
};

/**
 * 获取瓶子使用总时间（秒） response结构
 **/
@interface UsedTimeResponse : GPBMessage

/** 返回成功与否 */
@property(nonatomic, readwrite, strong, null_resettable) BaseResponse *response;
/** Test to see if @c response has been set. */
@property(nonatomic, readwrite) BOOL hasResponse;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<UsedTimeResponse_UsedTime*> *usedTimeArray;
/** The number of items in @c usedTimeArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger usedTimeArray_Count;

@end

#pragma mark - UsedTimeResponse_UsedTime

typedef GPB_ENUM(UsedTimeResponse_UsedTime_FieldNumber) {
  UsedTimeResponse_UsedTime_FieldNumber_Bottle = 1,
  UsedTimeResponse_UsedTime_FieldNumber_Time = 2,
};

/**
 * 瓶子已用时间
 **/
@interface UsedTimeResponse_UsedTime : GPBMessage

/** 气味瓶子ID */
@property(nonatomic, readwrite, copy, null_resettable) NSString *bottle;

/** 使用时间（秒） */
@property(nonatomic, readwrite) int32_t time;

@end

#pragma mark - TimePoint

typedef GPB_ENUM(TimePoint_FieldNumber) {
  TimePoint_FieldNumber_Mode = 1,
  TimePoint_FieldNumber_Value = 2,
  TimePoint_FieldNumber_EndValue = 3,
};

/**
 * 时间点
 **/
@interface TimePoint : GPBMessage

/** 播放模式 */
@property(nonatomic, readwrite) SrTimeMode mode;

/** 粗略时间 */
@property(nonatomic, readwrite) int32_t value;

/** 时间范围，结束点，用以描述周一到周五等情况 */
@property(nonatomic, readwrite) int32_t endValue;

@end

/**
 * Fetches the raw value of a @c TimePoint's @c mode property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t TimePoint_Mode_RawValue(TimePoint *message);
/**
 * Sets the raw value of an @c TimePoint's @c mode property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetTimePoint_Mode_RawValue(TimePoint *message, int32_t value);

#pragma mark - PlayRequest

typedef GPB_ENUM(PlayRequest_FieldNumber) {
  PlayRequest_FieldNumber_Request = 1,
  PlayRequest_FieldNumber_CycleMode = 2,
  PlayRequest_FieldNumber_StartAtArray = 3,
  PlayRequest_FieldNumber_CycleTime = 4,
  PlayRequest_FieldNumber_ActionsArray = 5,
  PlayRequest_FieldNumber_TraceArray = 6,
};

/**
 * 播放气味请求
 **/
@interface PlayRequest : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) BaseRequest *request;
/** Test to see if @c request has been set. */
@property(nonatomic, readwrite) BOOL hasRequest;

/** 循环模式 */
@property(nonatomic, readwrite) SrCycleMode cycleMode;

/** 开始时间，整个数组组成一个时间， */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<TimePoint*> *startAtArray;
/** The number of items in @c startAtArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger startAtArray_Count;

/** 循环次数 */
@property(nonatomic, readwrite) int32_t cycleTime;

/** 播放动作数组 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<PlayRequest_PlayAction*> *actionsArray;
/** The number of items in @c actionsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger actionsArray_Count;

/** 播放痕迹 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<PlayRequest_PlayTrace*> *traceArray;
/** The number of items in @c traceArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger traceArray_Count;

@end

/**
 * Fetches the raw value of a @c PlayRequest's @c cycleMode property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t PlayRequest_CycleMode_RawValue(PlayRequest *message);
/**
 * Sets the raw value of an @c PlayRequest's @c cycleMode property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetPlayRequest_CycleMode_RawValue(PlayRequest *message, int32_t value);

#pragma mark - PlayRequest_PlayAction

typedef GPB_ENUM(PlayRequest_PlayAction_FieldNumber) {
  PlayRequest_PlayAction_FieldNumber_Bottle = 1,
  PlayRequest_PlayAction_FieldNumber_Duration = 2,
  PlayRequest_PlayAction_FieldNumber_Power = 3,
};

/**
 * 一个播放动作，描述如何播放一个气味
 **/
@interface PlayRequest_PlayAction : GPBMessage

/** 瓶子ID */
@property(nonatomic, readwrite, copy, null_resettable) NSString *bottle;

/** 播放时间，单位秒 */
@property(nonatomic, readwrite) int32_t duration;

/** 播放功率 */
@property(nonatomic, readwrite) int32_t power;

@end

#pragma mark - PlayRequest_PlayTrace

typedef GPB_ENUM(PlayRequest_PlayTrace_FieldNumber) {
  PlayRequest_PlayTrace_FieldNumber_ActionIdArray = 1,
  PlayRequest_PlayTrace_FieldNumber_BeforeStart = 2,
  PlayRequest_PlayTrace_FieldNumber_CycleMode = 3,
  PlayRequest_PlayTrace_FieldNumber_Interval = 4,
  PlayRequest_PlayTrace_FieldNumber_CycleTime = 5,
};

/**
 * 播放痕迹，描述如何组合播放动作
 **/
@interface PlayRequest_PlayTrace : GPBMessage

/** 动作ID，对应PlayAction的数组下标 */
@property(nonatomic, readwrite, strong, null_resettable) GPBInt32Array *actionIdArray;
/** The number of items in @c actionIdArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger actionIdArray_Count;

/** 几秒后开始 */
@property(nonatomic, readwrite) int32_t beforeStart;

/** 循环模式 */
@property(nonatomic, readwrite) SrCycleMode cycleMode;

/** 循环间歇时间 */
@property(nonatomic, readwrite) int32_t interval;

/** 循环次数 */
@property(nonatomic, readwrite) int32_t cycleTime;

@end

/**
 * Fetches the raw value of a @c PlayRequest_PlayTrace's @c cycleMode property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t PlayRequest_PlayTrace_CycleMode_RawValue(PlayRequest_PlayTrace *message);
/**
 * Sets the raw value of an @c PlayRequest_PlayTrace's @c cycleMode property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetPlayRequest_PlayTrace_CycleMode_RawValue(PlayRequest_PlayTrace *message, int32_t value);

#pragma mark - StopPlayRequest

typedef GPB_ENUM(StopPlayRequest_FieldNumber) {
  StopPlayRequest_FieldNumber_Request = 1,
  StopPlayRequest_FieldNumber_BottlesArray = 2,
};

/**
 * 设备停止某个瓶子的播放动作
 **/
@interface StopPlayRequest : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) BaseRequest *request;
/** Test to see if @c request has been set. */
@property(nonatomic, readwrite) BOOL hasRequest;

/** 要停止播放的气味瓶子编号 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *bottlesArray;
/** The number of items in @c bottlesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger bottlesArray_Count;

@end

#pragma mark - RemoveTaskRequest

typedef GPB_ENUM(RemoveTaskRequest_FieldNumber) {
  RemoveTaskRequest_FieldNumber_Request = 1,
  RemoveTaskRequest_FieldNumber_StopTasksArray = 2,
};

/**
 * 设备取消播放任务（一系列播放动作）
 **/
@interface RemoveTaskRequest : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) BaseRequest *request;
/** Test to see if @c request has been set. */
@property(nonatomic, readwrite) BOOL hasRequest;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<RemoveTaskRequest_RemoveTaskOption*> *stopTasksArray;
/** The number of items in @c stopTasksArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger stopTasksArray_Count;

@end

#pragma mark - RemoveTaskRequest_RemoveTaskOption

typedef GPB_ENUM(RemoveTaskRequest_RemoveTaskOption_FieldNumber) {
  RemoveTaskRequest_RemoveTaskOption_FieldNumber_StopSeq = 1,
  RemoveTaskRequest_RemoveTaskOption_FieldNumber_Mode = 2,
};

@interface RemoveTaskRequest_RemoveTaskOption : GPBMessage

/** 要停止的 PlayRequest 请求 nSeq 序列号 */
@property(nonatomic, readwrite) int32_t stopSeq;

/** 模式 */
@property(nonatomic, readwrite) SrRemoveTaskMode mode;

@end

/**
 * Fetches the raw value of a @c RemoveTaskRequest_RemoveTaskOption's @c mode property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t RemoveTaskRequest_RemoveTaskOption_Mode_RawValue(RemoveTaskRequest_RemoveTaskOption *message);
/**
 * Sets the raw value of an @c RemoveTaskRequest_RemoveTaskOption's @c mode property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetRemoveTaskRequest_RemoveTaskOption_Mode_RawValue(RemoveTaskRequest_RemoveTaskOption *message, int32_t value);

#pragma mark - DevAttrOption

typedef GPB_ENUM(DevAttrOption_FieldNumber) {
  DevAttrOption_FieldNumber_Attr = 1,
  DevAttrOption_FieldNumber_Value = 2,
};

/**
 * 设备属性信息
 **/
@interface DevAttrOption : GPBMessage

@property(nonatomic, readwrite) SrDevAttrType attr;

@property(nonatomic, readwrite, copy, null_resettable) NSString *value;

@end

/**
 * Fetches the raw value of a @c DevAttrOption's @c attr property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t DevAttrOption_Attr_RawValue(DevAttrOption *message);
/**
 * Sets the raw value of an @c DevAttrOption's @c attr property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetDevAttrOption_Attr_RawValue(DevAttrOption *message, int32_t value);

#pragma mark - GetDevAttrsRequest

typedef GPB_ENUM(GetDevAttrsRequest_FieldNumber) {
  GetDevAttrsRequest_FieldNumber_Request = 1,
  GetDevAttrsRequest_FieldNumber_AttrsArray = 2,
};

/**
 * 获取设备属性请求，如果要所有信息，就讲包体置空
 **/
@interface GetDevAttrsRequest : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) BaseRequest *request;
/** Test to see if @c request has been set. */
@property(nonatomic, readwrite) BOOL hasRequest;

// |attrsArray| contains |SrDevAttrType|
@property(nonatomic, readwrite, strong, null_resettable) GPBEnumArray *attrsArray;
/** The number of items in @c attrsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger attrsArray_Count;

@end

#pragma mark - GetDevAttrsResponse

typedef GPB_ENUM(GetDevAttrsResponse_FieldNumber) {
  GetDevAttrsResponse_FieldNumber_Response = 1,
  GetDevAttrsResponse_FieldNumber_AttrsArray = 2,
};

/**
 * 获取设备属性返回
 **/
@interface GetDevAttrsResponse : GPBMessage

/** 返回成功与否 */
@property(nonatomic, readwrite, strong, null_resettable) BaseResponse *response;
/** Test to see if @c response has been set. */
@property(nonatomic, readwrite) BOOL hasResponse;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<DevAttrOption*> *attrsArray;
/** The number of items in @c attrsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger attrsArray_Count;

@end

#pragma mark - SetDevAttrsRequest

typedef GPB_ENUM(SetDevAttrsRequest_FieldNumber) {
  SetDevAttrsRequest_FieldNumber_Request = 1,
  SetDevAttrsRequest_FieldNumber_AttrsArray = 2,
};

/**
 * 设置设备属性请求体
 **/
@interface SetDevAttrsRequest : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) BaseRequest *request;
/** Test to see if @c request has been set. */
@property(nonatomic, readwrite) BOOL hasRequest;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<DevAttrOption*> *attrsArray;
/** The number of items in @c attrsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger attrsArray_Count;

@end

#pragma mark - DeviceModelResponse

typedef GPB_ENUM(DeviceModelResponse_FieldNumber) {
  DeviceModelResponse_FieldNumber_Response = 1,
  DeviceModelResponse_FieldNumber_SupportCmdsArray = 2,
  DeviceModelResponse_FieldNumber_ControlsArray = 3,
};

/**
 * 属性名之前加入下划线“_”来表示该属性是只读的
 * 设备模型上报 response
 **/
@interface DeviceModelResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) BaseResponse *response;
/** Test to see if @c response has been set. */
@property(nonatomic, readwrite) BOOL hasResponse;

/** 设备支持的指令集合 */
// |supportCmdsArray| contains |SrCmdId|
@property(nonatomic, readwrite, strong, null_resettable) GPBEnumArray *supportCmdsArray;
/** The number of items in @c supportCmdsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger supportCmdsArray_Count;

/** 设备的控件集合 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<AppControlSet*> *controlsArray;
/** The number of items in @c controlsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger controlsArray_Count;

@end

#pragma mark - AppControlSet

typedef GPB_ENUM(AppControlSet_FieldNumber) {
  AppControlSet_FieldNumber_Identity = 1,
  AppControlSet_FieldNumber_Name = 2,
  AppControlSet_FieldNumber_Switch_p = 11,
  AppControlSet_FieldNumber_Slider = 12,
  AppControlSet_FieldNumber_Spin = 13,
  AppControlSet_FieldNumber_SwitchSlider = 14,
};

typedef GPB_ENUM(AppControlSet_Controller_OneOfCase) {
  AppControlSet_Controller_OneOfCase_GPBUnsetOneOfCase = 0,
  AppControlSet_Controller_OneOfCase_Switch_p = 11,
  AppControlSet_Controller_OneOfCase_Slider = 12,
  AppControlSet_Controller_OneOfCase_Spin = 13,
  AppControlSet_Controller_OneOfCase_SwitchSlider = 14,
};

/**
 * 控件集合
 **/
@interface AppControlSet : GPBMessage

/** 控件唯一标识符 */
@property(nonatomic, readwrite) int32_t identity;

/** 控件名称 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@property(nonatomic, readonly) AppControlSet_Controller_OneOfCase controllerOneOfCase;

/** 开关 */
@property(nonatomic, readwrite, strong, null_resettable) AppControlSwitch *switch_p;

/** 滑动条 */
@property(nonatomic, readwrite, strong, null_resettable) AppControlSlider *slider;

/** 旋转器 */
@property(nonatomic, readwrite, strong, null_resettable) AppControlSpin *spin;

/** 滑动条 + 开关 */
@property(nonatomic, readwrite, strong, null_resettable) AppControlSwitchSlider *switchSlider;

@end

/**
 * Clears whatever value was set for the oneof 'controller'.
 **/
void AppControlSet_ClearControllerOneOfCase(AppControlSet *message);

#pragma mark - AppControlSwitch

typedef GPB_ENUM(AppControlSwitch_FieldNumber) {
  AppControlSwitch_FieldNumber_Status = 1,
};

/**
 * 开关
 **/
@interface AppControlSwitch : GPBMessage

/** 开关状态 true 开，false 关 */
@property(nonatomic, readwrite) SrSwitchStatus status;

@end

/**
 * Fetches the raw value of a @c AppControlSwitch's @c status property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t AppControlSwitch_Status_RawValue(AppControlSwitch *message);
/**
 * Sets the raw value of an @c AppControlSwitch's @c status property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetAppControlSwitch_Status_RawValue(AppControlSwitch *message, int32_t value);

#pragma mark - AppControlSlider

typedef GPB_ENUM(AppControlSlider_FieldNumber) {
  AppControlSlider_FieldNumber_Min = 1,
  AppControlSlider_FieldNumber_Max = 2,
  AppControlSlider_FieldNumber_Step = 3,
  AppControlSlider_FieldNumber_Value = 4,
};

/**
 * 滑动条
 **/
@interface AppControlSlider : GPBMessage

/** 最小值 */
@property(nonatomic, readwrite) int32_t min;

/** 最大值 */
@property(nonatomic, readwrite) int32_t max;

/** 步幅 */
@property(nonatomic, readwrite) int32_t step;

/** 当前滚动值 */
@property(nonatomic, readwrite) int32_t value;

@end

#pragma mark - AppControlSpin

typedef GPB_ENUM(AppControlSpin_FieldNumber) {
  AppControlSpin_FieldNumber_Step = 1,
  AppControlSpin_FieldNumber_Angle = 2,
  AppControlSpin_FieldNumber_AngularSpeed = 3,
};

/**
 * 旋转器
 **/
@interface AppControlSpin : GPBMessage

/** 旋转最小角度 */
@property(nonatomic, readwrite) int32_t step;

/** 当前角度 */
@property(nonatomic, readwrite) int32_t angle;

/** 角速度 */
@property(nonatomic, readwrite) int32_t angularSpeed;

@end

#pragma mark - AppControlSwitchSlider

typedef GPB_ENUM(AppControlSwitchSlider_FieldNumber) {
  AppControlSwitchSlider_FieldNumber_Status = 1,
  AppControlSwitchSlider_FieldNumber_Min = 2,
  AppControlSwitchSlider_FieldNumber_Max = 3,
  AppControlSwitchSlider_FieldNumber_Step = 4,
  AppControlSwitchSlider_FieldNumber_Value = 5,
};

/**
 * 滑动条 + 开关
 **/
@interface AppControlSwitchSlider : GPBMessage

/** 开关状态 true 开，false 关 */
@property(nonatomic, readwrite) SrSwitchStatus status;

/** 最小值 */
@property(nonatomic, readwrite) int32_t min;

/** 最大值 */
@property(nonatomic, readwrite) int32_t max;

/** 步幅 */
@property(nonatomic, readwrite) int32_t step;

/** 当前滚动值 */
@property(nonatomic, readwrite) int32_t value;

@end

/**
 * Fetches the raw value of a @c AppControlSwitchSlider's @c status property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t AppControlSwitchSlider_Status_RawValue(AppControlSwitchSlider *message);
/**
 * Sets the raw value of an @c AppControlSwitchSlider's @c status property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetAppControlSwitchSlider_Status_RawValue(AppControlSwitchSlider *message, int32_t value);

#pragma mark - SetControlAttrRequest

typedef GPB_ENUM(SetControlAttrRequest_FieldNumber) {
  SetControlAttrRequest_FieldNumber_Request = 1,
  SetControlAttrRequest_FieldNumber_SettingsArray = 2,
};

/**
 * 设置控件属性请求，将控件的值描述为控件的一个可修改属性，
 * 通过控制控件属性来达到控制控件的效果，也可以用于设置控件的名字
 **/
@interface SetControlAttrRequest : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) BaseRequest *request;
/** Test to see if @c request has been set. */
@property(nonatomic, readwrite) BOOL hasRequest;

/** 控制控件内容 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<SetControlAttrRequest_SetControlAttr*> *settingsArray;
/** The number of items in @c settingsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger settingsArray_Count;

@end

#pragma mark - SetControlAttrRequest_SetControlAttr

typedef GPB_ENUM(SetControlAttrRequest_SetControlAttr_FieldNumber) {
  SetControlAttrRequest_SetControlAttr_FieldNumber_Identity = 1,
  SetControlAttrRequest_SetControlAttr_FieldNumber_Attr = 2,
  SetControlAttrRequest_SetControlAttr_FieldNumber_Value = 3,
};

/**
 * 设置控件属性信息
 **/
@interface SetControlAttrRequest_SetControlAttr : GPBMessage

/** 控件标识符，指明设置的控件 */
@property(nonatomic, readwrite) int32_t identity;

/** 控件属性名，指明要设置的属性 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *attr;

/** 属性值 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *value;

@end

#pragma mark - DevWifiListResponse

typedef GPB_ENUM(DevWifiListResponse_FieldNumber) {
  DevWifiListResponse_FieldNumber_Response = 1,
  DevWifiListResponse_FieldNumber_WifissidListArray = 2,
};

/**
 * 获取设备周边 wifi 信号
 **/
@interface DevWifiListResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) BaseResponse *response;
/** Test to see if @c response has been set. */
@property(nonatomic, readwrite) BOOL hasResponse;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *wifissidListArray;
/** The number of items in @c wifissidListArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger wifissidListArray_Count;

@end

#pragma mark - SetDevWifiRequest

typedef GPB_ENUM(SetDevWifiRequest_FieldNumber) {
  SetDevWifiRequest_FieldNumber_Wifissid = 1,
  SetDevWifiRequest_FieldNumber_Wifipwd = 2,
};

/**
 * 设置 wifi 用户名密码，
 **/
@interface SetDevWifiRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *wifissid;

@property(nonatomic, readwrite, copy, null_resettable) NSString *wifipwd;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
