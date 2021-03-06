//
//  File.m
//  Puttio
//
//  Created by orta therox on 25/03/2012.
//  Copyright (c) 2012 ortatherox.com. All rights reserved.
//

#import "File.h"

@implementation File

static NSArray *ThumbnailFileTypes;
static NSArray *TextFileTypes;
static NSArray *TextFileNames;
static NSArray *AudioFileTypes;

+ (void)initialize {
    ThumbnailFileTypes = @[@"mp4", @"mov", @"wmv", @"m4v", @"mkv", @"avi", @"jpg", @"png", @"gif"];

    TextFileTypes = @[ @"txt", @"nfo", @"log", @"diz", @"xml"];
    TextFileNames = @[ @"README", @"LICENSE", @"INSTALL", @"CHANGELOG", @"AUTHORS"];

    AudioFileTypes = @[ @"mp3", @"aac", @"wav", @"auf"];
}

+ (NSString *)createDisplayNameFromName:(NSString *)fullName {
    NSString *display = @"";
    display = fullName;

    if (fullName.length > 1) {
        // kill all preceding whitespace
        NSRange range = [display rangeOfString:@"^\\s*" options:NSRegularExpressionSearch];
        display = [display stringByReplacingCharactersInRange:range withString:@""];
        
        // remove prefix brackets - usually group names
        NSArray *prefixOpeners = @[@"[", @"{", @"("];
        NSArray *prefixClosers = @[@"]", @"}", @")"];
        for (int i = 0; i < prefixClosers.count; i++) {
            if ([[display substringToIndex:1] isEqualToString:prefixOpeners[i]]) {
                display = [display substringFromIndex:[display rangeOfString:prefixClosers[i]].location];
            }                
        }
        
        display = [display lowercaseString];
        display = [display stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"[]{}()"]];

        NSArray *removeStrings = @[@".", @"_", @" 5 1aac ", @" 5.1aac ", @" dvdrip ", @" brrip ", @" x264 ", @" hdtv ", @" 720 ", @" 1080 ", @" 480 ", @" wmv", @" mp4", @" m4v", @" mkv", @" hd ", @" 720p ", @" avi ", @" dvdscr ", @" 1080p ", @" avi"];
        for (NSString *remove in removeStrings) {
            display = [display stringByReplacingOccurrencesOfString:remove withString:@" "];
        }
        display = [display capitalizedString];
    }
    
    return display;
}

- (BOOL)isTextualType {
    if ([TextFileTypes containsObject:self.extension]) return YES;
    if ([TextFileNames containsObject:self.name]) return YES;
    return NO;
}

- (BOOL)isAudioType {
    if ([AudioFileTypes containsObject:self.extension]) return YES;
    return NO;
}

- (NSString *)extension {
    return [[self.name pathExtension] lowercaseString];
}

- (BOOL)hasPreviewThumbnail {
    return [ThumbnailFileTypes containsObject:[self extension]];
}
@end
