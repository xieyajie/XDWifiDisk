//
//  ASDeclare.h
//  ASVirtualHardDisk
//
//  Created by Yunxing.D on 11-8-19.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ASDeclare : NSObject {
    
    //ASPreferencesViewController.m
    NSString *Preferences;
    NSString *DriveInfo;
    NSString *NickNameTitle;
    NSString *Home;
    NSString *TotalSpace;
    NSString *FreeSpace;
    
    //for ASReadZbar
    NSString *resultText;
    NSString *gotobutton;
    
    //for ASServlet
    NSString *createfolder;
    NSString *logpath;
    NSString *logPathList;
    NSString *logpathdown;
    NSString *filerequest;
    
    //for ASMusicPlayer
    NSString *currenttime;
    
    //for ASMediaPlayerViewController
    NSString *namefile;
    NSString *tap;
    NSString *recorder;
    NSString *cancel;
    NSString *use;
    
    //for ASWebView
    NSString *downfalse;
    NSString *downok;
    NSString *downsuspend;
    NSString *homepage;
    
    //for ASStrategy
    NSString *wait;
    
    //for ASZip
    NSString *failed;
    NSString *error;
    NSString *errorfile;
    NSString *readfailed;
    NSString *set;
    
    //for viewcontroller
    NSString *filefalse;
    NSString *save;
    NSString *server;
    NSString *realimg;
    NSString *Connectby;
    NSString *Or;
    NSString *imgswitch;
    NSString *settingdown;
    NSString *quarterCWPressed;
    NSString *quarterCCWPressed;
    NSString *halfPressed;
    NSString *altermodify;
    NSString *quefile;
    NSString *coverfile;
    NSString *yes;
    NSString *NoDirctory;
    NSString *OkIKonw;
    NSString *status;
    NSString *dashboard;
    NSString *local;
    NSString *cantopen;
    
    NSString *IntroductionText;       
    NSString *ConnectingText;
    NSString *TipsText;
    NSString *TipsText_iPad;
    
    //for ASNetWorkChexk.m
	NSString *alertWarning;
	NSString *alertMessage;
	NSString *alertSure;
	
    //for ASMainViewController.m
    NSString *navClose;
	NSString *navBack;
	NSString *navDone;
	NSString *navDelete;
	NSString *navEdit;
	
    //for ASMainViewController.m
	NSString *fileButtonTitle;
    
	
    //for ASMainViewController.m
	NSString *verifyAlertTitle;
	NSString *verifyAlertMessage;
	NSString *verifyAlertSure;
	
    //for ASFileAttributeViewController.m
	NSString *fileListViewAlertTitle;
	NSString *fileListViewAlertSure;
	NSString *fileListViewEdit;
	NSString *fileListViewDone;
	NSString *fileListSelectedAll;
	NSString *fileListSelectedCancel;
	
    //for ASFileListViewController.m
	NSString *deleteFileAlertTitle;
	NSString *deleteFileAlertMessage;
	NSString *deleteFileAlertSure;
	NSString *deleteFileAlertCancel;
	
    //for ASFileListViewController.m
	NSString *fileOperateDelete;
	NSString *fileOperateCopy;
	NSString *fileOperateMove;
	NSString *fileOperateRoot;
	NSString *fileOperateCancel;
	NSString *fileOperateNum;
	NSString *fileOperateZip;
	NSString *fileOperateEMail;
    
    //for ASFileListViewController.m zip large file
    NSString *fileTooLarge;
    NSString *fileIKnow;
	
    //for ASSearchViewController.m
	NSString *resultList;
    
    //for ASFile.m
    NSString *UnkonwType;
    NSString *directoryType;
    
    //for ASSearchViewController.m
    NSString *resultAlertWarning;
    NSString *resultAlertMessage;
    NSString *resultAlertSure;
    
    //for ASFileListViewController.m
    NSString *selectedFilesEmpty;
	NSString *canNotSendMail;
    NSString *renameWarning;
    
    //for ASEdtingStatus
    NSString *deletebutton;
    NSString *copybutton;
    NSString *zipbutton;
    NSString *emailbutton;
    NSString *movebutton;
    NSString *vdeletebutton;
    NSString *vcopybutton;
    NSString *vzipbutton;
    NSString *vemailbutton;
    NSString *vmovebutton;
    
    //for ASSettingViewController_ipad
    NSString *httpserveradd;
    NSString *ftpserveradd;
    
    //for iPad pictureViewController
    NSString *picturetoalbum;
    NSString *errorpicturetoalbum;
    NSString *message;
    
    //close for modal view
    NSString *closeModelView;
    
    //for ASFileListViewController_iPad
    NSString *accessLibraryError;
    
    //for server name
    NSString *defaultServerName;
    
    //for Bluetooth
    NSString *peers;
    NSString *connect;
    NSString *connectfail;
    NSString *receOrnot;
    NSString *quit;
    NSString *receiving;
    NSString *receSuc;
    NSString *receFa;
    NSString *accept;
    NSString *trySend;
    NSString *sending;
    NSString *sendSuc;
    NSString *sendFa;
    NSString *unavilable;
}

@property (nonatomic, readonly) NSString *defaultServerName;
@property (nonatomic, readonly) NSString *accessLibraryError;
           
@property (nonatomic, readonly) NSString *fileTooLarge;
@property (nonatomic, readonly) NSString *fileIKnow;

@property (nonatomic, readonly) NSString *Preferences;
@property (nonatomic, readonly) NSString *DriveInfo;
@property (nonatomic, readonly) NSString *NickNameTitle;
@property (nonatomic, readonly) NSString *Home;
@property (nonatomic, readonly) NSString *TotalSpace;
@property (nonatomic, readonly) NSString *FreeSpace;


@property (nonatomic, readonly) NSString *resultText;
@property (nonatomic, readonly) NSString *gotobutton;

@property (nonatomic, readonly) NSString *createfolder;
@property (nonatomic, readonly) NSString *logpath;
@property (nonatomic, readonly) NSString *logpathList;
@property (nonatomic, readonly) NSString *logpathdown;
@property (nonatomic, readonly) NSString *filerequest;

@property (nonatomic, readonly) NSString *currenttime;

@property (nonatomic, readonly) NSString *namefile;
@property (nonatomic, readonly) NSString *tap;
@property (nonatomic, readonly) NSString *recorder;
@property (nonatomic, readonly) NSString *cancel;
@property (nonatomic, readonly) NSString *use;

@property (nonatomic, readonly) NSString *downfalse;
@property (nonatomic, readonly) NSString *downok;
@property (nonatomic, readonly) NSString *downsuspend;
@property (nonatomic, readonly) NSString *homepage;

@property (nonatomic ,readonly) NSString *wait;

@property (nonatomic, readonly) NSString *failed;
@property (nonatomic, readonly) NSString *error;
@property (nonatomic, readonly) NSString *errorfile;
@property (nonatomic ,readonly) NSString *readfailed;
@property (nonatomic, readonly) NSString *set;

@property (nonatomic, readonly) NSString *filefalse;
@property (nonatomic, readonly) NSString *save;
@property (nonatomic, readonly) NSString *server;
@property (nonatomic, readonly) NSString *realimg;
@property (nonatomic, readonly) NSString *Connectby;
@property (nonatomic, readonly) NSString *Or;
@property (nonatomic, readonly) NSString *imgswitch;
@property (nonatomic, readonly) NSString *settingdown;
@property (nonatomic, readonly) NSString *quarterCWPressed;
@property (nonatomic, readonly) NSString *quarterCCWPressed;
@property (nonatomic, readonly) NSString *halfPressed;
@property (nonatomic, readonly) NSString *altermodify;
@property (nonatomic, readonly) NSString *quefile; 
@property (nonatomic, readonly) NSString *coverfile;
@property (nonatomic, readonly) NSString *yes;
@property (nonatomic, readonly) NSString *NoDirctory;
@property (nonatomic, readonly) NSString *OkIKonw;
@property (nonatomic, readonly) NSString *status;
@property (nonatomic, readonly) NSString *dashboard;
@property (nonatomic, readonly) NSString *local;
@property (nonatomic, readonly) NSString *IntroductionText;       
@property (nonatomic, readonly) NSString *ConnectingText;
@property (nonatomic, readonly) NSString *TipsText;
@property (nonatomic, readonly) NSString *TipsText_iPad;
@property (nonatomic, readonly) NSString *cantopen;

@property (nonatomic, readonly) NSString *alertWarning;
@property (nonatomic, readonly) NSString *alertMessage;
@property (nonatomic, readonly) NSString *alertSure;

@property (nonatomic, readonly) NSString *navBack;
@property (nonatomic, readonly) NSString *navClose;
@property (nonatomic, readonly) NSString *navDone;
@property (nonatomic, readonly) NSString *navDelete;
@property (nonatomic, readonly) NSString *navEdit;

@property (nonatomic, readonly) NSString *fileButtonTitle;

@property (nonatomic, readonly) NSString *verifyAlertTitle;
@property (nonatomic, readonly) NSString *verifyAlertMessage;
@property (nonatomic, readonly) NSString *verifyAlertSure;

@property (nonatomic, readonly) NSString *fileListViewAlertTitle;
@property (nonatomic, readonly) NSString *fileListViewAlertSure;
@property (nonatomic, readonly) NSString *fileListViewEdit;
@property (nonatomic, readonly) NSString *fileListViewDone;
@property (nonatomic, readonly) NSString *fileListSelectedAll;
@property (nonatomic, readonly) NSString *fileListSelectedCancel;

@property (nonatomic, readonly) NSString *deleteFileAlertTitle;
@property (nonatomic, readonly) NSString *deleteFileAlertMessage;
@property (nonatomic, readonly) NSString *deleteFileAlertSure;
@property (nonatomic, readonly) NSString *deleteFileAlertCancel;

@property (nonatomic, readonly) NSString *fileOperateDelete;
@property (nonatomic, readonly) NSString *fileOperateCopy;
@property (nonatomic, readonly) NSString *fileOperateMove;
@property (nonatomic, readonly) NSString *fileOperateRoot;
@property (nonatomic, readonly) NSString *fileOperateCancel;
@property (nonatomic, readonly) NSString *fileOperateNum;
@property (nonatomic, readonly) NSString *fileOperateZip;
@property (nonatomic, readonly) NSString *fileOperateEMail;

@property (nonatomic, readonly) NSString *resultList;

@property (nonatomic, readonly) NSString *UnkonwType;
@property (nonatomic, readonly) NSString *directoryType;

@property (nonatomic, readonly) NSString *resultAlertWarning;
@property (nonatomic, readonly) NSString *resultAlertMessage;
@property (nonatomic, readonly) NSString *resultAlertSure;

@property (nonatomic, readonly) NSString *selectedFilesEmpty;
@property (nonatomic, readonly) NSString *canNotSendMail;
@property (nonatomic, readonly) NSString *renameWarning;

@property (nonatomic, readonly) NSString *deletebutton;
@property (nonatomic, readonly) NSString *copybutton;
@property (nonatomic, readonly) NSString *zipbutton;
@property (nonatomic, readonly) NSString *emailbutton;
@property (nonatomic, readonly) NSString *movebutton;
@property (nonatomic, readonly) NSString *vdeletebutton;
@property (nonatomic, readonly) NSString *vcopybutton;
@property (nonatomic, readonly) NSString *vzipbutton;
@property (nonatomic, readonly) NSString *vemailbutton;
@property (nonatomic, readonly) NSString *vmovebutton;

@property (nonatomic, readonly) NSString *picturetoalbum;
@property (nonatomic, readonly) NSString *errorpicturetoalbum;
@property (nonatomic, readonly) NSString *message;

@property (nonatomic, readonly) NSString *httpserveradd;
@property (nonatomic, readonly) NSString *ftpserveradd;

@property (nonatomic, readonly) NSString *closeModelView;

@property (nonatomic, readonly) NSString *peers;
@property (nonatomic, readonly) NSString *connect;
@property (nonatomic, readonly) NSString *connectfail;
@property (nonatomic, readonly) NSString *receOrnot;
@property (nonatomic, readonly) NSString *quit;
@property (nonatomic, readonly) NSString *receiving;
@property (nonatomic, readonly) NSString *receSuc;
@property (nonatomic, readonly) NSString *receFa;
@property (nonatomic, readonly) NSString *accept;
@property (nonatomic, readonly) NSString *trySend;
@property (nonatomic, readonly) NSString *sending;
@property (nonatomic, readonly) NSString *sendSuc;
@property (nonatomic, readonly) NSString *sendFa;
@property (nonatomic, readonly) NSString *unavilable;

/*
    @function   + (id) singletonASDeclare
    @abstract   init the value in the ASDeclare
                product the single instance
    @param      no
    @result     id 
*/
+ (id) singletonASDeclare;

/*
    @function   - (void) deaclloc
    @abstract   deaclloc
    @param      no
    @result     void
*/

- (void) dealloc;

@end
