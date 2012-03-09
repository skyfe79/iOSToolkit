//
//  ViewController.m
//  TSoundManager
//
//  Created by skyfe79 on 12. 3. 8..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "TSoundManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[TSoundManager sharedInstance] preloadFromPlist:@"stage1_sound"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)onClickePlayBG:(id)sender {
    [[TSoundManager sharedInstance] playBG:@"bg"];
}

- (IBAction)onClickPauseBG:(id)sender {
    [[TSoundManager sharedInstance] pauseBG];
}

- (IBAction)onClickResumeBG:(id)sender {
    [[TSoundManager sharedInstance] resumeBG];
}

- (IBAction)onClickStopBG:(id)sender {
    [[TSoundManager sharedInstance] stopBG];
}

- (IBAction)onClickPlayFX1:(id)sender {
    [[TSoundManager sharedInstance] playFX:@"fx_haha"];
}

- (IBAction)onClickPlayFX2:(id)sender {
    [[TSoundManager sharedInstance] playFX:@"fx_hoho"];
}

- (IBAction)onClickStopFX:(id)sender {
    [[TSoundManager sharedInstance] stopFX];
}

- (IBAction)onClickStage1:(id)sender {
    [[TSoundManager sharedInstance] preloadFromPlist:@"stage1_sound"];
}

- (IBAction)onClickStage2:(id)sender {
    [[TSoundManager sharedInstance] preloadFromPlist:@"stage2_sound"];
}
- (void)dealloc {
    [super dealloc];
}
@end
