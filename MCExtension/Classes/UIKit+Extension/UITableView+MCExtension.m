//
//  UITableView+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import "UITableView+MCExtension.h"
#import "UIView+MCExtension.h"
#import "UIImage+MCExtension.h"


@implementation UITableView (MCExtension)

- (UIImage *)MC_screenshot
{
    return [self MC_screenshotExcludingHeadersAtSections:NO
                           excludingFootersAtSections:NO
                            excludingRowsAtIndexPaths:NO];
}

- (UIImage *)MC_screenshotOfCellAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *cellScreenshot = nil;
    
    // Current tableview offset
    CGPoint currTableViewOffset = self.contentOffset;
    
    // First, scroll the tableview so the cell would be rendered on the view and able to screenshot'it
    [self scrollToRowAtIndexPath:indexPath
                atScrollPosition:UITableViewScrollPositionTop
                        animated:NO];
    
    // Take the screenshot
    cellScreenshot = [[self cellForRowAtIndexPath:indexPath] MC_screenshot];
    
    // scroll back to the original offset
    [self setContentOffset:currTableViewOffset animated:NO];
    
    return cellScreenshot;
}

- (UIImage *)MC_screenshotOfHeaderView
{
    CGPoint originalOffset = [self contentOffset];
    CGRect headerRect = [self tableHeaderView].frame;
    
    [self scrollRectToVisible:headerRect animated:NO];
    UIImage *headerScreenshot = [self.tableHeaderView MC_screenshot];
    [self setContentOffset:originalOffset animated:NO];
    
    return headerScreenshot;
}

- (UIImage *)MC_screenshotOfFooterView
{
    CGPoint originalOffset = [self contentOffset];
    CGRect footerRect = [self tableFooterView].frame;
    
    [self scrollRectToVisible:footerRect animated:NO];
    UIImage *footerScreenshot = [self MC_screenshotForCroppingRect:footerRect];
    [self setContentOffset:originalOffset animated:NO];
    
    return footerScreenshot;
}

- (UIImage *)MC_screenshotOfHeaderViewAtSection:(NSUInteger)section
{
    CGPoint originalOffset = [self contentOffset];
    CGRect headerRect = [self rectForHeaderInSection:section];
    
    [self scrollRectToVisible:headerRect animated:NO];
    UIImage *headerScreenshot = [self MC_screenshotForCroppingRect:headerRect];
    [self setContentOffset:originalOffset animated:NO];
    
    return headerScreenshot;
}

- (UIImage *)MC_screenshotOfFooterViewAtSection:(NSUInteger)section
{
    CGPoint originalOffset = [self contentOffset];
    CGRect footerRect = [self rectForFooterInSection:section];
    
    [self scrollRectToVisible:footerRect animated:NO];
    UIImage *footerScreenshot = [self MC_screenshotForCroppingRect:footerRect];
    [self setContentOffset:originalOffset animated:NO];
    
    return footerScreenshot;
}

- (UIImage *)MC_screenshotExcludingAllHeaders:(BOOL)withoutHeaders
                       excludingAllFooters:(BOOL)withoutFooters
                          excludingAllRows:(BOOL)withoutRows
{
    NSArray *excludedHeadersOrFootersSections = nil;
    if (withoutHeaders || withoutFooters) excludedHeadersOrFootersSections = [self MC_allSectionsIndexes];
    
    NSArray *excludedRows = nil;
    if (withoutRows) excludedRows = [self MC_allRowsIndexPaths];
    
    return [self MC_screenshotExcludingHeadersAtSections:(withoutHeaders)?[NSSet setWithArray:excludedHeadersOrFootersSections]:nil
                           excludingFootersAtSections:(withoutFooters)?[NSSet setWithArray:excludedHeadersOrFootersSections]:nil
                            excludingRowsAtIndexPaths:(withoutRows)?[NSSet setWithArray:excludedRows]:nil];
}

- (UIImage *)MC_screenshotExcludingHeadersAtSections:(NSSet *)excludedHeaderSections
                       excludingFootersAtSections:(NSSet *)excludedFooterSections
                        excludingRowsAtIndexPaths:(NSSet *)excludedIndexPaths
{
    NSMutableArray *screenshots = [NSMutableArray array];
    // Header Screenshot
    UIImage *headerScreenshot = [self MC_screenshotOfHeaderView];
    if (headerScreenshot) [screenshots addObject:headerScreenshot];
    for (int section=0; section<self.numberOfSections; section++) {
        // Header Screenshot
        UIImage *headerScreenshot = [self MC_screenshotOfHeaderViewAtSection:section excludedHeaderSections:excludedHeaderSections];
        if (headerScreenshot) [screenshots addObject:headerScreenshot];
        
        // Screenshot of every cell of this section
        for (int row=0; row<[self numberOfRowsInSection:section]; row++) {
            NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
            UIImage *cellScreenshot = [self MC_screenshotOfCellAtIndexPath:cellIndexPath excludedIndexPaths:excludedIndexPaths];
            if (cellScreenshot) [screenshots addObject:cellScreenshot];
        }
        
        // Footer Screenshot
        UIImage *footerScreenshot = [self MC_screenshotOfFooterViewAtSection:section excludedFooterSections:excludedFooterSections];
        if (footerScreenshot) [screenshots addObject:footerScreenshot];
    }
    UIImage *footerScreenshot = [self MC_screenshotOfFooterView];
    if (footerScreenshot) [screenshots addObject:footerScreenshot];
    return [UIImage MC_verticalImageFromArray:screenshots];
}

- (UIImage *)MC_screenshotOfHeadersAtSections:(NSSet *)includedHeaderSections
                         footersAtSections:(NSSet *)includedFooterSections
                          rowsAtIndexPaths:(NSSet *)includedIndexPaths
{
    NSMutableArray *screenshots = [NSMutableArray array];
    
    for (int section=0; section<self.numberOfSections; section++) {
        // Header Screenshot
        UIImage *headerScreenshot = [self MC_screenshotOfHeaderViewAtSection:section includedHeaderSections:includedHeaderSections];
        if (headerScreenshot) [screenshots addObject:headerScreenshot];
        
        // Screenshot of every cell of the current section
        for (int row=0; row<[self numberOfRowsInSection:section]; row++) {
            NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
            UIImage *cellScreenshot = [self MC_screenshotOfCellAtIndexPath:cellIndexPath includedIndexPaths:includedIndexPaths];
            if (cellScreenshot) [screenshots addObject:cellScreenshot];
        }
        
        // Footer Screenshot
        UIImage *footerScreenshot = [self MC_screenshotOfFooterViewAtSection:section includedFooterSections:includedFooterSections];
        if (footerScreenshot) [screenshots addObject:footerScreenshot];
    }
    return [UIImage MC_verticalImageFromArray:screenshots];
}

#pragma mark - Hard Working for Screenshots

- (UIImage *)MC_screenshotOfCellAtIndexPath:(NSIndexPath *)indexPath excludedIndexPaths:(NSSet *)excludedIndexPaths
{
    if ([excludedIndexPaths containsObject:indexPath]) return nil;
    return [self MC_screenshotOfCellAtIndexPath:indexPath];
}

- (UIImage *)MC_screenshotOfHeaderViewAtSection:(NSUInteger)section excludedHeaderSections:(NSSet *)excludedHeaderSections
{
    if ([excludedHeaderSections containsObject:@(section)]) return nil;
    
    UIImage *sectionScreenshot = nil;
    sectionScreenshot = [self MC_screenshotOfHeaderViewAtSection:section];
    if (! sectionScreenshot) {
        sectionScreenshot = [self MC_blankScreenshotOfHeaderAtSection:section];
    }
    return sectionScreenshot;
}

- (UIImage *)MC_screenshotOfFooterViewAtSection:(NSUInteger)section excludedFooterSections:(NSSet *)excludedFooterSections
{
    if ([excludedFooterSections containsObject:@(section)]) return nil;
    
    UIImage *sectionScreenshot = nil;
    sectionScreenshot = [self MC_screenshotOfFooterViewAtSection:section];
    if (! sectionScreenshot) {
        sectionScreenshot = [self MC_blankScreenshotOfFooterAtSection:section];
    }
    return sectionScreenshot;
}

- (UIImage *)MC_screenshotOfCellAtIndexPath:(NSIndexPath *)indexPath includedIndexPaths:(NSSet *)includedIndexPaths
{
    if (![includedIndexPaths containsObject:indexPath]) return nil;
    return [self MC_screenshotOfCellAtIndexPath:indexPath];
}

- (UIImage *)MC_screenshotOfHeaderViewAtSection:(NSUInteger)section includedHeaderSections:(NSSet *)includedHeaderSections
{
    if (![includedHeaderSections containsObject:@(section)]) return nil;
    
    UIImage *sectionScreenshot = nil;
    sectionScreenshot = [self MC_screenshotOfHeaderViewAtSection:section];
    if (! sectionScreenshot) {
        sectionScreenshot = [self MC_blankScreenshotOfHeaderAtSection:section];
    }
    return sectionScreenshot;
}

- (UIImage *)MC_screenshotOfFooterViewAtSection:(NSUInteger)section includedFooterSections:(NSSet *)includedFooterSections
{
    if (![includedFooterSections containsObject:@(section)]) return nil;
    
    UIImage *sectionScreenshot = nil;
    sectionScreenshot = [self MC_screenshotOfFooterViewAtSection:section];
    if (! sectionScreenshot) {
        sectionScreenshot = [self MC_blankScreenshotOfFooterAtSection:section];
    }
    return sectionScreenshot;
}

#pragma mark - Blank Screenshots

- (UIImage *)MC_blankScreenshotOfHeaderAtSection:(NSUInteger)section
{
    CGSize headerRectSize = CGSizeMake(self.bounds.size.width, [self rectForHeaderInSection:section].size.height);
    return [UIImage MC_imageWithColor:[UIColor clearColor] size:headerRectSize];
}

- (UIImage *)MC_blankScreenshotOfFooterAtSection:(NSUInteger)section
{
    CGSize footerRectSize = CGSizeMake(self.bounds.size.width, [self rectForFooterInSection:section].size.height);
    return [UIImage MC_imageWithColor:[UIColor clearColor] size:footerRectSize];
}

#pragma mark - All Headers / Footers sections

- (NSArray *)MC_allSectionsIndexes
{
    long numOfSections = [self numberOfSections];
    NSMutableArray *allSectionsIndexes = [NSMutableArray array];
    for (int section=0; section < numOfSections; section++) {
        [allSectionsIndexes addObject:@(section)];
    }
    return allSectionsIndexes;
}

#pragma mark - All Rows Index Paths

- (NSArray *)MC_allRowsIndexPaths
{
    NSMutableArray *allRowsIndexPaths = [NSMutableArray array];
    for (NSNumber *sectionIdx in [self MC_allSectionsIndexes]) {
        for (int rowNum=0; rowNum<[self numberOfRowsInSection:[sectionIdx unsignedIntegerValue]]; rowNum++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowNum inSection:[sectionIdx unsignedIntegerValue]];
            [allRowsIndexPaths addObject:indexPath];
        }
    }
    return allRowsIndexPaths;
}

@end
