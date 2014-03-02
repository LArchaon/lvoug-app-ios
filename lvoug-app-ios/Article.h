#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Article : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * date;

@end
