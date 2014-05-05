//
//  EmisoraViewController.m
//  april 9
//
//  Created by webstudent on 4/9/14.
//  Copyright (c) 2014 RVC Student. All rights reserved.
//

#import "EmisoraViewController.h"

@interface EmisoraViewController ()
@end
int x;
NSURL *url;
NSURL *urls;

NSString *dialname;

@implementation EmisoraViewController
@synthesize webview;
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    CGSize size = [self getScreenSize];
   
    UILabel *label;
    
    if (size.width > 320){
         label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width-100, 162)];
        if (component == 0) {
           
            label.font=[UIFont boldSystemFontOfSize:30];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
            
            label.text = [NSString stringWithFormat:@"%@", [self.radiostations objectAtIndex:row]];
            label.font=[UIFont boldSystemFontOfSize:30];
            
        }
     }
    else{
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width-50, 162)];
        if (component == 0) {
        
        label.font=[UIFont boldSystemFontOfSize:25];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        
        label.text = [NSString stringWithFormat:@"%@", [self.radiostations objectAtIndex:row]];
        label.font=[UIFont boldSystemFontOfSize:25];
         
    }

    }
    
    return label;

    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if([self checkinternet] == NO)
    {
        // Not connected to the internet
         [pickerView selectRow:0 inComponent:0 animated:YES];
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Internet Connection Required"
                                                          message:@"Close app and return when internet connection available."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    }
    else
    {
        //activity monitor
        [_am startAnimating];
        
        
        url = [NSURL URLWithString:_dial[row]];
        self.avAsset = [AVURLAsset URLAssetWithURL:url options:nil];
        self.playerItem = [AVPlayerItem playerItemWithAsset:self.avAsset];
        self.audioPlayer = [AVPlayer playerWithPlayerItem:self.playerItem];
        [self.audioPlayer play];
        
        //load website
        
        // NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"banner" ofType:@"html"];
        NSURL *url2=[NSURL URLWithString:_www[row]];
        NSURLRequest *req = [NSURLRequest requestWithURL:url2];
        urls=self.dial[row];
        dialname=self.radiostations[row];
       
        [_website loadRequest:req];
        self.btnStop.enabled = YES;
        self.btnPlay.enabled = NO;
        if (row==0)
        {
             self.btnShare.enabled=NO;
        }
        else{
             self.btnShare.enabled=YES;
        }
        
    }
    
   
       
    
}


- (CGSize)getScreenSize
{
    //Get Screen size
    CGSize size;
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) && [[UIScreen mainScreen] bounds].size.height > [[UIScreen mainScreen] bounds].size.width) {
        // in Landscape mode, width always higher than height
        size.width = [[UIScreen mainScreen] bounds].size.height;
        size.height = [[UIScreen mainScreen] bounds].size.width;
    } else if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) && [[UIScreen mainScreen] bounds].size.height < [[UIScreen mainScreen] bounds].size.width) {
        // in Portrait mode, height always higher than width
        size.width = [[UIScreen mainScreen] bounds].size.height;
        size.height = [[UIScreen mainScreen] bounds].size.width;
    } else {
        // otherwise it is normal
        size.height = [[UIScreen mainScreen] bounds].size.height;
        size.width = [[UIScreen mainScreen] bounds].size.width;
    }
    return size;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.radiostations.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.radiostations[row];
}
- (void) webViewDidFinishLoad:(UIWebView *) webView
{
    NSString *javascript = @"function myFunction() {return 1+1;}";
    [webView stringByEvaluatingJavaScriptFromString:javascript];
    [_am stopAnimating];
    if (x==1)
    {
        x=0;
        [self.btnPlay setEnabled:NO];
    }
    
}
- (void)viewDidLoad
{
    self.btnShare.enabled=NO;
    x=0;
    [super viewDidLoad];
    [self.website setDelegate:self];
    // Disable Stop/Play button when application launches
    [self.btnStop setEnabled:NO];
    [self.btnPlay setEnabled:NO];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    self.radiostations = @[@"Select Radio Station",@"89.5 NPR", @"96.7 EAGLE", @"95.3 WRTB", @"104.9 The X", @"1440 AM News Talk", @"98.5 Rockford Country"];
    
    
    self.dial = @[@"",@"http://peace.str3am.com:6810/live-96k.mp3", @"http://provisioning.streamtheworld.com/pls/wkglfmaac.pls",@"http://out1.cmn.icy.abacast.com/wrtb-wrtbfmaac-64.m3u",
        @"http://out1.cmn.icy.abacast.com/wxrx-wxrxfmaac-64.m3u",@"http://provisioning.streamtheworld.com/pls/wrokamaac.pls",
        @"http://provisioning.streamtheworld.com/pls/wxxqfmaac.pls"];
    
    self.www = @[@"http://bit.ly/radiostreamapp",@"http://www.northernpublicradio.org/", @"http://967theeagle.net/", @"http://www.953thebull.com/", @"http://www.wxrx.com/", @"http://1440wrok.com/", @"http://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0CCkQFjAA&url=http%3A%2F%2Fq985online.com%2F&ei=mrZOU_GoCo2lyATpwYCoCg&usg=AFQjCNGLRrC5TnbaHGdG35SQXWSGYcsBEA&sig2=5myRKDuo1cNwHveg2y22-Q&bvm=bv.64764171,d.aWw"];
  
    //Make sure the system follows our playback status (needed to play audio in background)
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    
     NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"banner" ofType:@"html"];
    NSURL *url=[NSURL fileURLWithPath:htmlFile];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
   [self.webview loadRequest:req];
    
    if([self checkinternet] == NO)
    {
        // Not connected to the internet
   //     [pickerView selectRow:0 inComponent:0 animated:YES];
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Internet Connection Required"
                                                          message:@"Close app and return when internet connection available."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    }
    else
    {
        //activity monitor
        [_am startAnimating];
        
        
        NSURL *url2=[NSURL URLWithString:@"http://bit.ly/radiostreamapp"];
        NSURLRequest *req2 = [NSURLRequest requestWithURL:url2];
        [_website loadRequest:req2];
    }

   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    //Once the view has loaded then we can register to begin recieving controls and we can become the first responder
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //End recieving events
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}
//Make sure we can recieve remote control events
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    //if it is a remote control event handle it correctly
    if (event.type == UIEventTypeRemoteControl) {
        if (event.subtype == UIEventSubtypeRemoteControlPlay) {
             [self.audioPlayer play];
        } else if (event.subtype == UIEventSubtypeRemoteControlPause) {
              [self.audioPlayer pause];
        } else if (event.subtype == UIEventSubtypeRemoteControlTogglePlayPause) {
            [self togglePlayPause];
        }
    }
}
- (void)togglePlayPause {
    //Toggle if the music is playing or paused
    if (!self.audioPlayer.playing) {
        [self.audioPlayer play];
        
    } else if (self.audioPlayer.playing) {
        [self.audioPlayer pause];
      
        
    }
}
- (IBAction)btnStop:(id)sender {
     self.btnShare.enabled=NO;
           self.btnStop.enabled = NO;
        self.btnPlay.enabled = YES;
        [self.audioPlayer pause];
   
   
}

- (IBAction)btnPlay:(id)sender {
     self.btnShare.enabled=YES;
        self.btnStop.enabled = YES;
        self.btnPlay.enabled = NO;
        [self.audioPlayer play];
    
}
//check internet
- (BOOL) checkinternet
{
    NSURL *scriptUrl = [NSURL URLWithString:@"http://www.google.com/m"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    if (data)
    {
        NSLog(@"Device is connected to the internet");
        return YES;
    }
    else
    {
        NSLog(@"Device is not connected to the internet");
        return NO;
    }
    
}
- (IBAction)btnHome:(id)sender {
    if([self checkinternet] == NO)
    {
        // Not connected to the internet
       
     [_picker selectRow:0 inComponent:0 animated:YES];
         [_picker reloadComponent:0];
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Internet Connection Required"
                                                          message:@"Close app and return when internet connection available."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        //activity monitor
        self.btnStop.enabled = NO;
        self.btnPlay.enabled = NO;
    }
    else
    {
        

        [_picker selectRow:0 inComponent:0 animated:YES];
       [_picker reloadComponent:0];
      [_am startAnimating];
        
        
        NSURL *url2=[NSURL URLWithString:@"http://bit.ly/radiostreamapp"];
        NSURLRequest *req2 = [NSURLRequest requestWithURL:url2];
        [_website loadRequest:req2];
        //activity monitor
        self.btnStop.enabled = NO;
        self.btnPlay.enabled = NO;
    }
    x=1;
}
- (IBAction)btnShare:(id)sender {
    NSString *text = [NSString stringWithFormat:@"Listening to Radio Stream App:\n%@\n\nDownload App:\n%@\n\nListen Now:", dialname,@"rvcstudentapps.kissr.com/audiostream.html"];
    NSURL *url = urls;
    UIImage *image = [UIImage imageNamed:@"me.gif"];
    
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[text, url, image]
     applicationActivities:nil];
    
    [self presentViewController:controller animated:YES completion:nil];
}
@end
