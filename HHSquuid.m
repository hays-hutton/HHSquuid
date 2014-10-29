//
//  HHSquuid.m
//
//  Created by hays hutton on 2/17/14.
//

#import "HHSquuid.h"

@implementation HHSquuid

+ (NSUUID *) newSquuid {
    //Cast removes the millis. Good for another ~24 years ;)
    int seconds = (int)[[NSDate date] timeIntervalSince1970];
    union int_or_bytes { int d; char bytes[4]; } converter;
    unsigned char uuid_bytes[16];
    
    //This is a RFC 4122 version 4 UUID. This implementation relies upon
    //  the fact that every byte is random per the spec.
    NSUUID *uuid = [NSUUID UUID];
    [uuid getUUIDBytes: (unsigned char *)uuid_bytes];
    converter.d = seconds;
    unsigned char squuid_bytes[16];
    squuid_bytes[0] = converter.bytes[3];
    squuid_bytes[1] = converter.bytes[2];
    squuid_bytes[2] = converter.bytes[1];
    squuid_bytes[3] = converter.bytes[0];
    memcpy(squuid_bytes + 4, uuid_bytes, 12);
    NSUUID *squuid = [[NSUUID UUID] initWithUUIDBytes:squuid_bytes];
    
    NSLog(@"seconds since 1970:%d", seconds);
    NSLog(@"squuid:%@", [squuid UUIDString]);
    
    return squuid;
}
@end
