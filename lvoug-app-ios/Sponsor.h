#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Sponsor : NSManagedObject

@property (nonatomic, retain) NSNumber * event;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * name;

@end
