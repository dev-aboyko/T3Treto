//
//  T3ViewController.m
//
//
//  Created by Alexey Boyko on 15.02.14.
//  Copyright (c) 2014 Alexey Boyko. All rights reserved.
//

#import "T3ViewController.h"

@interface T3ViewController ()

@property (retain, nonatomic) T3ImageDownloader* imageDownloader;
@property (retain, nonatomic) NSArray* url;
@property (retain, nonatomic) UIScrollView* scroll;

@end

@implementation T3ViewController

@synthesize imageDownloader, url, scroll;

- (void)viewDidLoad
{
    [super viewDidLoad];
    imageDownloader = [[T3ImageDownloader alloc] initWithDelegate:self];
    [self initUrls];
    [self initScroll];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"_scroll.scrollEnabled = %d", scroll.scrollEnabled);
    NSLog(@"_scroll.contentSize %f, %f", scroll.contentSize.width, scroll.contentSize.height);
}

- (void) initUrls
{
    NSURL* url1 = [NSURL URLWithString:@"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/01.jpg"];
    NSURL* url2 = [NSURL URLWithString:@"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/02.jpg"];
    NSURL* url3 = [NSURL URLWithString:@"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/02.jpg"];
    NSURL* url4 = [NSURL URLWithString:@"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/05.jpg"];
    NSURL* url5 = [NSURL URLWithString:@"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/08.jpg"];
    url = [[NSArray alloc] initWithObjects: url1, url2, url3, url4, url5, nil];
    [url1 release];
    [url2 release];
    [url3 release];
    [url4 release];
    [url5 release];
}

- (void) initScroll
{
    scroll = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scroll.pagingEnabled = YES;
    NSInteger numberOfViews = 3;
    for (int i = 0; i < numberOfViews; i++) {
        CGFloat xOrigin = i * self.view.frame.size.width;
        UIView *awesomeView = [[UIView alloc] initWithFrame:CGRectMake(xOrigin, 0, self.view.frame.size.width, self.view.frame.size.height)];
        awesomeView.backgroundColor = [UIColor colorWithRed:0.5/i green:0.5 blue:0.5 alpha:1];
        [scroll addSubview:awesomeView];
        [awesomeView release];
    }
    scroll.contentSize = CGSizeMake(self.view.frame.size.width * numberOfViews, self.view.frame.size.height);
    [self.view addSubview:scroll];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) imageDownloadProgress: (float) progress;
{
}

- (void) imageDownloadFinished:(UIImage*) image;
{
}

- (void) imageDownloadError
{
}

- (void)dealloc
{
    for (NSURL* u in url)
    {
        [u release];
    }
    [url release];
    [imageDownloader release];
    [scroll release];
    [super dealloc];
}
@end
