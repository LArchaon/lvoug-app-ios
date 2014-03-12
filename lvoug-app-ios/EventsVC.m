#import "EventsVC.h"
#import "DataService.h"
#import "ImageHelper.h"
#import "DateHelper.h"
#import "EventVC.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "EventListCell.h"

@implementation EventsVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.events = [[DataService instance] events];
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:0.0-1.0 green:0.0-1.0 blue:0.0-1.0 alpha:0.5f]];
}

- (NSArray*)events
{
    if (_events == nil) {
        _events = [[NSMutableArray alloc]init];
    }
    return _events;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.events count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventListCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"eventsCell"];
    
    Event *event = self.events [indexPath.row];
    
    cell.textLabel.text = event.title;
    cell.detailTextLabel.text = [DateHelper getStringDateFromApiFormat:event.date];
    
    [cell.imageView setImageWithURL:[NSURL URLWithString:event.logo] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"openEvent"]) {
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        Event *event = [self.events objectAtIndex:ip.row];
        [segue.destinationViewController setEvent: event.id];
    }
}

@end
