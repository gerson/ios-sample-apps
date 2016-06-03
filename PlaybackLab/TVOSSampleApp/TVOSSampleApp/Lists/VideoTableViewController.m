//
//  VideoTableViewController.m
//  TVOSSampleApp
//
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import "VideoTableViewController.h"
#import "AbstractPlayerViewController.h"
#import "FullscreenPlayerViewController.h"
#import "FairplayPlayerViewController.h"
#import "PlayerSelectionOption.h"

@interface VideoTableViewController ()

@property (nonatomic, strong) NSMutableArray *options; // of Video.h

@end

@implementation VideoTableViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
    
  [self populateOptions];
}

- (NSMutableArray *)options
{
  if (!_options) {
    _options = [NSMutableArray array];
  }
  return _options;
}

- (void)populateOptions
{
  [self.options addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Fullscreen Player"
                                                             embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"]];
  [self.options addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Inline Player"
                                                             embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1"]];
  [self.options addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Fairplay Baseline Profile (Unconfigured)"
                                                             embedCode:@"V3NDdnMzE6tPCchL9wYTFZY8jAE8_Y21"]];
  [self.options addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Fairplay Main Profile (Unconfigured)"
                                                             embedCode:@"cycDhnMzE66D5DPpy3oIOzli1HVMoYnJ"]];
  [self.options addObject:[[PlayerSelectionOption alloc] initWithTitle:@"Fairplay High Profile (Unconfigured)"
                                                             embedCode:@"d2dzhnMzE6h-LTaIavPD5k2eqLeCTMC5"]];
  
  [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionCell" forIndexPath:indexPath];
  
  PlayerSelectionOption *option = self.options[indexPath.row];
  cell.textLabel.text = option.title;
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *segueId = @"";
  PlayerSelectionOption *option = self.options[indexPath.row];
  if ([option.title isEqualToString:@"Fullscreen Player"]) {
    segueId = @"fullscreenSegue";
  } else if ([option.title isEqualToString:@"Inline Player"]) {
    segueId = @"childSegue";
  } else {
    segueId = @"fairplaySegue";
  }
  
  [self performSegueWithIdentifier:segueId sender:[self.tableView cellForRowAtIndexPath:indexPath]];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
  if ([segue.identifier isEqualToString:@"fullscreenSegue"]) {
    FullscreenPlayerViewController *destinationVC = segue.destinationViewController;
    destinationVC.option = self.options[indexPath.row];
  } else if ([segue.identifier isEqualToString:@"childSegue"]){
    AbstractPlayerViewController *destinationVC = segue.destinationViewController;
    destinationVC.option = self.options[indexPath.row];
  } else {
    FairplayPlayerViewController *destinationVC = segue.destinationViewController;
    destinationVC.option = self.options[indexPath.row];
  }
}

@end