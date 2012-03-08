//
//  ViewController.m
//  TImageManager
//
//  Created by skyfe79 on 12. 3. 8..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "TImageCacheManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIImageView *imgView = [[[UIImageView alloc] initWithFrame:self.view.bounds]autorelease];
    UIImage *image = [UIImage imageFromBundle:@"img01.png"];
    [imgView setImage:image];
    [self.view addSubview:imgView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (void)didReceiveMemoryWarning
{
    [[TImageCacheManager sharedInstance] releaseCachedImages];
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
