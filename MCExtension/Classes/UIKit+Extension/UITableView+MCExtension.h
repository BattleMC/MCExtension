//
//  UITableView+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (MCExtension)

- (UIImage *)MC_screenshot;

- (UIImage *)MC_screenshotOfHeaderView;

- (UIImage *)MC_screenshotOfCellAtIndexPath:(NSIndexPath *)indexPath;

- (UIImage *)MC_screenshotOfHeaderViewAtSection:(NSUInteger)section;

- (UIImage *)MC_screenshotOfFooterViewAtSection:(NSUInteger)section;

- (UIImage *)MC_screenshotExcludingAllHeaders:(BOOL)withoutHeaders
                       excludingAllFooters:(BOOL)withoutFooters
                          excludingAllRows:(BOOL)withoutRows;

- (UIImage *)MC_screenshotExcludingHeadersAtSections:(NSSet *)headerSections
                       excludingFootersAtSections:(NSSet *)footerSections
                        excludingRowsAtIndexPaths:(NSSet *)indexPaths;

- (UIImage *)MC_screenshotOfHeadersAtSections:(NSSet *)headerSections
                         footersAtSections:(NSSet *)footerSections
                          rowsAtIndexPaths:(NSSet *)indexPaths;

@end

NS_ASSUME_NONNULL_END
