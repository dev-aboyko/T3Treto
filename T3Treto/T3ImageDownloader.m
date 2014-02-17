//
//  T3ImageDownloader.m
//  T3Treto
//
//  Created by Alexey Boyko on 15.02.14.
//  Copyright (c) 2014 Alexey Boyko. All rights reserved.
//

#import "T3ImageDownloader.h"

@interface T3ImageDownloader()

@property (nonatomic, assign) id<T3ImageDownloaderDelegate> delegate;
@property (nonatomic) NSMutableData *imageData;
@property (nonatomic) NSUInteger totalBytes;
@property (nonatomic) NSURLConnection* connection;

@end

@implementation T3ImageDownloader

- (id) initWithDelegate:(id<T3ImageDownloaderDelegate>) delegate
{
    self = [super init];
    if (self != nil)
        self.delegate = delegate;
    return self;
}

- (void) downloadFrom:(NSString*)url
{
    NSURL* nsURL = [[NSURL alloc] initWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:nsURL];
    [self.connection release];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    [nsURL release];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)urlResponse
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) urlResponse;
    NSDictionary *dict = httpResponse.allHeaderFields;
    NSString *lengthString = [dict valueForKey:@"Content-Length"];
    NSNumberFormatter *formatter = [[[NSNumberFormatter alloc] init] autorelease];
    NSNumber *length = [formatter numberFromString:lengthString];
    self.totalBytes = length.unsignedIntegerValue;
    [self.imageData release];
    self.imageData = [[NSMutableData alloc] initWithCapacity:self.totalBytes];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.imageData appendData:data];
    float progress = (float)self.imageData.length / (float)self.totalBytes;
    [self.delegate imageDownloadProgress:progress];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.delegate imageDownloadFinished:nil];

    UIImage* image = [UIImage imageWithData:self.imageData];
    [self.delegate imageDownloadFinished:image];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.delegate imageDownloadError];
}

- (void) dealloc
{
    [self.imageData release];
    [self.connection release];
    [super dealloc];
}

@end
