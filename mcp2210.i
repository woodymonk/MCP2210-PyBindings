%module mcp2210

%{
#define SWIG_FILE_WITH_INIT
#include "hidapi.h"
#include "mcp2210.h"
%}

struct GPPin {
    unsigned int PinDesignation;
    unsigned int GPIOOutput;
    unsigned int GPIODirection;
};

struct SPITransferSettingsDef {
    unsigned long BitRate;
    unsigned int IdleChipSelectValue;
    unsigned int ActiveChipSelectValue;
    unsigned int CSToDataDelay;
    unsigned int LastDataByteToCSDelay;
    unsigned int SubsequentDataByteDelay;
    unsigned int BytesPerSPITransfer;
    unsigned int SPIMode;
    int ErrorCode;
};

struct ChipSettingsDef {
    GPPin GP[9];
    unsigned int RemoteWakeUpEnabled;
    unsigned int DedicatedFunctionInterruptPinMode;
    unsigned int SPIBusReleaseMode;
    unsigned int NVRamChipParamAccessControl;
    char password[8];
    int ErrorCode;
};

struct USBKeyParametersDef {
    unsigned int VID;
    unsigned int PID;
    unsigned int HostPowered;
    unsigned int SelfPowered;
    unsigned int RemoteWakeupCapable;
    unsigned int RequestedCurrentAmountFromHost;
    int ErrorCode;
};

struct ManufacturerProductNameDef {
    unsigned int USBStringDescriptorLength;
    unsigned int USBStringDescriptorID;
    char ManufacturerProductName[59];
    int ErrorCode;
};

struct ChipStatusDef {
    unsigned int SPIBusReleaseExtReqStat;
    unsigned int SPIBusCurrentOwner;
    unsigned int AttemptedPWDAccesses;
    unsigned int PasswordGuessed;
    int ErrorCode;
};

struct SPIDataTransferStatusDef {
    unsigned int NumberOfBytesReceived;
    unsigned int SPIEngineStatus;
    unsigned char DataReceived[60];
    int ErrorCode;
};

struct ExternalInterruptPinStatusDef {
    unsigned int InterruptEventCounter;
    int ErrorCode;
};

struct GPPinDef {
    GPPin GP[9];
    int ErrorCode;
};

hid_device_info* EnumerateMCP2210();

hid_device* InitMCP2210();

hid_device* InitMCP2210(wchar_t* serialNumber);

hid_device* InitMCP2210(unsigned short vid, unsigned short pid, wchar_t* serialNumber);

void ReleaseMCP2210(hid_device *handle);

int SendUSBCmd(hid_device *handle, byte *cmdBuf, byte *responseBuf);

SPITransferSettingsDef GetSPITransferSettings(hid_device *handle, bool isVolatile = true);

int SetSPITransferSettings(hid_device *handle, SPITransferSettingsDef def, bool isVolatile = true);

ChipSettingsDef GetChipSettings(hid_device *handle, bool isVolatile = true);

int SetChipSettings(hid_device *handle, ChipSettingsDef def, bool isVolatile = true);

USBKeyParametersDef GetUSBKeyParameters(hid_device *handle);

int SetUSBKeyParameters(hid_device *handle, USBKeyParametersDef def);

ManufacturerProductNameDef GetManufacturerProductName(hid_device *handle, unsigned int subCmdCode);

int SetManufacturerProductName(hid_device *handle, unsigned int subCmdCode, ManufacturerProductNameDef def);

int SendAccessPassword(hid_device *handle, char *pwd, int pwdLength);

int ReadEEPROM(hid_device *handle, byte addr, byte* val);

int WriteEEPROM(hid_device *handle, byte addr, byte val);

int RequestSPIBusRelease(hid_device *handle, byte val);

ChipStatusDef GetChipStatus(hid_device *handle);

ChipStatusDef CancelSPITransfer(hid_device *handle);

SPIDataTransferStatusDef SPIDataTransfer(hid_device *handle, byte* data, int length);

SPIDataTransferStatusDef SPISendReceive(hid_device *handle, byte* data, int cmdBufferLength, int dataLength = -1);

ExternalInterruptPinStatusDef GetNumOfEventsFromInterruptPin(hid_device *handle, byte resetCounter);

GPPinDef GetGPIOPinDirection(hid_device *handle);

int SetGPIOPinDirection(hid_device *handle, GPPinDef def);

GPPinDef GetGPIOPinValue(hid_device *handle);

int SetGPIOPinVal(hid_device *handle, GPPinDef def);
