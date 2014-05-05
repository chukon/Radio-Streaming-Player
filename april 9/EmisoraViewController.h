//
//  EmisoraViewController.h
//  april 9
//
//  Created by webstudent on 4/9/14.
//  Copyright (c) 2014 RVC Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface EmisoraViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource,AVAudioPlayerDelegate,UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) NSArray *radiostations;
@property (strong, nonatomic) NSArray *dial;
@property (strong, nonatomic) NSArray *www;
@property (strong, nonatomic) IBOutlet UIWebView *webview;
- (IBAction)btnStop:(id)sender;
- (IBAction)btnPlay:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnPlay;
@property (strong, nonatomic) IBOutlet UIWebView *website;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *am;
- (IBAction)btnHome:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *btnStop;

//Play Audio
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) AVURLAsset *avAsset;
@property (strong, nonatomic) AVPlayerItem *playerItem;

- (IBAction)btnShare:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;

@end
