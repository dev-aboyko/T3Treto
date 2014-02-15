//
//  T3ImageDownloader.m
//  T3Treto
//
//  Created by Alexey Boyko on 15.02.14.
//  Copyright (c) 2014 Alexey Boyko. All rights reserved.
//

#import "T3ImageDownloader.h"

@interface T3ImageDownloader()

@property (nonatomic) NSMutableData *imageData;
@property (nonatomic) NSUInteger totalBytes;

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
    NSLog(@"downloadFrom:%@", url);
    
    NSURL* nsURL = [[NSURL alloc] initWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:nsURL];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    [nsURL release];
    [request release];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)urlResponse
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) urlResponse;
    NSDictionary *dict = httpResponse.allHeaderFields;
    NSString *lengthString = [dict valueForKey:@"Content-Length"];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *length = [formatter numberFromString:lengthString];
    self.totalBytes = length.unsignedIntegerValue;
    self.imageData = [[NSMutableData alloc] initWithCapacity:self.totalBytes];
    [formatter release];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.imageData appendData:data];
    float progress = (float)self.imageData.length / (float)self.totalBytes;
    [self.delegate imageDownloadProgress:progress];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage* image = [UIImage imageWithData:self.imageData];
    [self.delegate imageDownloadFinished:image];
    [image release];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.delegate imageDownloadError];
}

- (void) dealloc
{
    [super dealloc];
    [self.imageData release];
}

@end
