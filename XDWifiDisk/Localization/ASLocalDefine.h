//
//  ASLocalDefine.h
//  ASColorPicker
//
//  Created by dai yunxing on 11-7-27.
//  Copyright 2011  hebeishida. All rights reserved.
//

#define localeString(A) NSLocalizedString(A,nil)
//for help
int chose;

//for print
int picOrPDF;

//for time
#define KTimeFormat localeString(@"TimeFormat")

//for revolve
#define degreesToRadian(x) (M_PI * (x) / 180.0)

//ASPreferencesViewController.m
#define KPreferences                  localeString(@"Preferences")
#define KDriveInfo                    localeString(@"Drive Info")
#define KNickNameTitle                localeString(@"NickNameTitle")
#define KHome                         localeString(@"Home")
#define KTotalSpace                   localeString(@"Total Space")
#define KFreeSpace                    localeString(@"Free Space")
//for webView local
BOOL localChose;

//for ASReadZbar
#define KResultText                  localeString(@"resultText")
#define KGotoButton                  localeString(@"goto")
#define KCloseButton                  localeString(@"close")

//for ASServlet
#define KCreateFolder                localeString(@"Create Folder Requested")
#define KLogPath                     localeString(@"logPath")
#define KLogPathList                 localeString(@"logPathList")
#define KLogPathDown                 localeString(@"logPathDown")
#define Kfilerequest                 localeString(@"File List Requested")

//for ASMusicPlayer
#define KCurrentTime                 localeString(@"currentTime")

//for ASMediaPlayerViewController
#define KNameFile                    localeString(@"namefile")
#define KTap                         localeString(@"tap")
#define KRecorder                    localeString(@"Recorder")
#define KCancel                      localeString(@"cancel")
#define KUse                         localeString(@"use")

//for ASWebView
#define KDownFalse                   localeString(@"Down False")
#define KDownOk                      localeString(@"Down OK")
#define KDownSuspend                 localeString(@"Down Suspend")
#define KHomePage                    localeString(@"HomePage")

//for ASStrategy
#define KWait                        localeString(@"wait")

//for ASZip
#define KFailed                      localeString(@"failed")
#define KError                       localeString(@"error")
#define KErrorFile                   localeString(@"errorfile")
#define KReadFaile                   localeString(@"readfailed")
#define KSet                         localeString(@"set")
#define kUnZipDone                   localeString(@"UnZipDone")

//for viewcontroller
#define KNotOpen                     localeString(@"notopen")
#define KSave                        localeString(@"save")
#define KServer                      localeString(@"Server")
#define KRealImage                   localeString(@"Real img")
#define kExtension                   localeString(@"Show path extension")
#define KAboutMe                     localeString(@"About Me")
#define KCurrentSkin                 localeString(@"Current Skin")
#define KChangeSkin                  localeString(@"Change Skin")
#define kHttpAddress                 localeString(@"HttpAddress")
#define kFtpAddress                  localeString(@"FtpAddress")
#define KImgSwitch                   localeString(@"Real img switched")
#define KSettingDown                 localeString(@"Setting done")
#define KQuarterCW                   localeString(@"quarterCWPressed")
#define KQuarterCCW                  localeString(@"quarterCCWPressed")
#define KHalfPressd                  localeString(@"halfPressed")
#define KAltermofiy                  localeString(@"The file has been modified.\n\tDo you want to save the file?")
#define KQueFile                     localeString(@"Can not open this file!")
#define KCoverFile                   localeString(@"Exist homonymic file,\nDo want to cover it?")
#define KYES                         localeString(@"YES")
#define KNoDirctory                  localeString(@"No directory contains.")
#define kNoFile                      localeString(@"No such file")
#define kDownloadingFile             localeString(@"The url is in download list")
#define KOkIKonw                     localeString(@"Ok, I Know.")
#define KStatus                      localeString(@"Status :")
#define KDashboard                   localeString(@"Dashboard")
#define KLocal                       localeString(@"Local:")
#define KDownLoadList                localeString(@"Download List")
#define KSetting                     localeString(@"Setting")

#define KIntroductionText            localeString(@"IntroductionText")         
#define KConnectingText              localeString(@"ConnectingText")
#define KTipsText                    localeString(@"TipsText")
#define KTipsText_iPad               localeString(@"TipsText_iPad")
#define KAboutMeContent              localeString(@"My documents 1.4 ©2012 AlphaStudio. All rights reserved.")

#define KCanTOpen                    localeString(@"Can not open the file!")

#define kTouch                       localeString(@"Touch")
#define kToOpenServer                localeString(@"ToOpenServer")

//for file attribute
#define kFilePath                    localeString(@"Location :")
#define kFileName                    localeString(@"FileName :")
#define kFileType                    localeString(@"Type       :")
#define kFileSize                    localeString(@"Size         :")
#define kFileCreationDate            localeString(@"Create     :")
#define kFileModificationDate        localeString(@"Moditify   :")
#define kFileOwerAccountName         localeString(@"Owner      :")
#define kFileAttribute               localeString(@"File Attribute List")
#define kUnknowType                  localeString(@"Unkonw")
#define kDirectoryType               localeString(@"directory")

// for net check
#define kAlertWarning localeString(@"Warning")
#define kAlertMessage localeString(@"NO Wifi Connected")
#define kAlertSure    localeString(@"Ok, I will check")

//for main view
#define kURL            localeString(@"URL:")
#define kNoWifi	        localeString(@"No Wi-Fi available.")
#define kMainTitle      localeString(@"Dashboard")
#define kFileButton     localeString(@"Local Files")
//#define kServerOff      localeString(@"Server off")
#define kServerOn       localeString(@"Server on")
#define kCheckOut       localeString(@"CheckOut")
#define kServerOff      localeString(@"Service has been shut down!")
#define kServerError    localeString(@"Unable to get the address, please check the network connection!")

#define kServerAdd  localeString(@"Connection address:")
#define khttpServerAdd  localeString(@"httpserveradd")
#define kftpServerAdd   localeString(@"ftpserveradd")

//for navigation 
#define kNavBack      localeString(@"Back")
#define kNavClose     localeString(@"Close")
#define kNavDone      localeString(@"Done")
#define kNavDelete    localeString(@"Delete")
#define kNavEdit      localeString(@"Edit")

//for dirctory
#define kMainDirctory localeString(@"Local");

//for help
//#define kHelp1        localeString(@"How to use wifi upload and operate files of iphone or ipod?\nOpen your explorer in the computer, enter the url");
//#define kHelp2        localeString(@"in browser, then you can upload and delete the files of the iphone or iPod.");
#define kHelpTitle    localeString(@"Help")

#define kHelpIntroduction localeString(@"Introduction")
#define kHelpGeneral localeString(@"General")
#define kHelpTip localeString(@"Tip")
#define kHelpMac localeString(@"Mac OS")
#define kHelpWindows localeString(@"Windows")

#define kHelp0        localeString(@"IntroductionText")
#define kHelp1        localeString(@"ConnectingText")
#define kHelp2        localeString(@"TipsText")
//#define kHelp2        localeString(@"");
#define kStart        localeString(@"Server :")

//for serverInfo view
#define kLabelStartServer           localeString(@"Server:")
#define kLabelLoacleEncrypt		    localeString(@"EncryptLocaleFile:")
#define kLabelPassWord				localeString(@"password:")
#define kLabelVerifyLocalePassWord	localeString(@"verify:")
#define kLabelWarning				localeString(@"Please make sure the password and verify not empty.")

//for verify view
#define kLabelInputPwd				localeString(@"password:")
#define kVerifyAlertTitle			localeString(@"Warning:")
#define kVerifyAlertMessage			localeString(@"password Error!")
#define kVerifyAlertSure			localeString(@"Try Again.")

//for system setting
#define kSettingViewTitle			localeString(@"Setting")

//for file list view
#define kFileListViewAlertTitle		localeString(@"Warning:")
#define kFileListViewAlertSure		localeString(@"I Will")
#define kFileListViewEditing		localeString(@"Edit")
#define kFileListViewDone			localeString(@"Done")
#define kFileListSelectedAll        localeString(@"Selected All")
#define kFileListSelectedCancel     localeString(@"Deselected All")
#define kFileListLargeFileMessage   localeString(@"File is too large")

//for fileListViewController rename same name warning
#define kRenameWarning              localeString(@"Existed name, try another, please")

//for delete file
#define kDeleteFileAlertTitle		localeString(@"Warning:")
#define kDeleteFileAlertMessage		localeString(@"Are you sure to delete the files?")
#define kDeleteFileAlertSure		localeString(@"delete")
#define kDeleteFileAlertCancel		localeString(@"cancel")

// for file operate
#define kDelete						localeString(@"Delete")
#define kCopy						localeString(@"Copy")
#define kMove						localeString(@"Move")
#define kRoot						localeString(@"Home")
#define kCancel						localeString(@"Cancel")
#define kOperateZip                 localeString(@"Zip")
#define kOperateNum					localeString(@"0")
#define kOperateEMail				localeString(@"E-mail")

//for search 
#define kResultList					localeString(@"Result List")
#define kResultAlertWarning         localeString(@"Warning")
#define kResultAlertMessage         localeString(@"Sorry, no files matched.")
#define kResultAlertSure            localeString(@"Ok, I know.")

//for file operate selected files shold not be empty
#define kSelectedFilesEmpty         localeString(@"Please choose some files.")
#define kLabelCanNotSendMail		localeString(@"Please make sure you can send eMail.")
#define kFromMyDocuments            localeString(@"From My Documents")
#define kEMailBody                  localeString(@"EMailBody")

//ASWebView loaclDefine  
// modify by suzhaoyang
//date 2011.11.14
#define KACTIONSHEETCANCELTITLE     localeString(@"actionSheetCancelTitle")
#define KACTIONSHEETADDBOOKMARKTITLE       localeString(@"actionSheetAddBookmarkTitle")
#define KACTIONSHEETSAVECURRETPAGETITLE      localeString(@"actionSheetSaveCurrentPageTitle")
#define KACTIONSHEETPRINTTITLE      localeString(@"sctionSheetPrintTitle")

#define KWEBSHEETCENCELTITTLE   localeString(@"webSheetCancel")
#define KWEBSHEETOPENLINK       localeString(@"webSheetOpenLink")
#define KWEBSHEETDOWNLOADLINK   localeString(@"webSheetDownLoadLink")
#define KWEBSHEETSAVEPICTURE    localeString(@"webSheetSavePicture")
#define KWEBSHEETSAVEBOOKMARK   localeString(@"webSheetSaveBookMark")
#define KDOWNLOADCLEANBUTTON    localeString(@"downLoadCleanButton")
#define KWEBVIEWTITTLE          localeString(@"webViewTittle")
#define KBOOKMARKLISTTITTLE     localeString(@"bookmarkListTittle")
#define KDOWNLOADSTATULEBELFAIL localeString(@"downLoadStatuLabelFail")
#define KDOWNLOADSTATULABELSUCCEED  localeString(@"downLoadStatuLabelSucceed")
#define KDOWNLOADSTATULABELSTOP     localeString(@"downLoadStatuLabelStop")

//for zbar Code
#define KRESULTTEXT             localeString("This is the Bar Code")
#define KTHEGOTOBUTTON          localeString("Goto")

//for recording
#define kRecorder            localeString("Recorder")
#define kUse          localeString("Use")

//for webView
#define kMessage localeString(@"Message")

//for sectionView
#define kIFilesBox localeString(@"iFilesBox")
#define kConnecting localeString(@"connecting")
#define kDoYouLikeIt localeString(@"doYouLikeIt")

//for settingView
#define kSettingHelp localeString(@"settingHelp")

//for scanView
#define kNoApp localeString(@"NoApp")

//for ASEdtingStatus
#define kDeletebutton localeString(@"deletebutton")
#define kMovebutton localeString(@"movebutton")
#define kZipbutton localeString(@"zipbutton")
#define kEmailbutton localeString(@"emailbutton")
#define kCopybutton localeString(@"copybutton")
#define kSaveButton localeString(@"savebutton")
#define kShareButton localeString(@"sharebutton")

#define kvDeletebutton localeString(@"vdeletebutton")
#define kvMovebutton localeString(@"vmovebutton")
#define kvZipbutton localeString(@"vzipbutton")
#define kvEmailbutton localeString(@"vemailbutton")
#define kvCopybutton localeString(@"vcopybutton")
#define kvSaveButton localeString(@"vsavebutton")
#define kvShareButton localeString(@"vsharebutton")

//for iPad mainViewController
#define kPlaces localeString(@"Places")
#define kSearchFor localeString(@"SearchFor")

//for iPad pictureViewController
#define kpictureToalbum localeString(@"Image written to photo album")
#define kerrorpictureToalbum localeString(@"Error writing to photo album:")
#define kMessagetip localeString(@"messagetip")

//for iPad ASFileViewController_iPad
#define KACCESSLIBARAYERROR localeString(@"Error accessing photo library!")

//for server name
#define KDEFAULTSERVERNAME localeString(@"serverName_HOME");

//for Bluetooth
#define kPeers localeString(@"Peers");
#define kConnect localeString(@"Connecting...");
#define kConnectFail localeString(@"Connecting failure!");
#define kReceiveOrNot localeString(@"Receive a file, accept or not?");
#define kQuit localeString(@"Bluetooth unexpected quit!");
#define kReceiving localeString(@"Receiving...");
#define kReceiveSuccess localeString(@"Successfully received!");
#define kReceiveFail localeString(@"Receive failed!");
#define kWaitForAccept localeString(@"Wait for accept file...");
#define kTrySendFail localeString(@"Try to send files failed!");
#define kSending localeString(@"Sending...");
#define kSendSuccess localeString(@"Sent successfully!");
#define kSendFail localeString(@"sending fails!");
#define kUnavilable localeString(@"Bluetooth unavilable!");

//for unrar
#define kUnrarError localeString(@"The file has been destroyed, was unable to decompress!")
