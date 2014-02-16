#import <Foundation/Foundation.h>

@interface ImageHelper : NSObject

+ (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;

@end
