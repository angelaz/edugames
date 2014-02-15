//
// Copyright (c) 2012 Jason Kozemczak
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
// documentation files (the "Software"), to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
// and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
// THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
// ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//

#import "CKSideBarController.h"

#define CKSideBarWidth 100
#define CKCornerRadius 1
#define CKSideBarButtonHeight 120
#define CKSideBarImageEdgeLength 65


@interface CKSideBarCell : UITableViewCell

@property (nonatomic) UIImageView *iconView;
@property (nonatomic) UIImage *selectedImage;
@property (nonatomic) UIImage *unSelectedImage;

- (void)setIsActive:(BOOL)isActive;

@end

@implementation CKSideBarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        self.iconView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.iconView];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width - CKCornerRadius;
    CGFloat height = self.bounds.size.height;
    self.iconView.frame = CGRectMake((width / 2) - (CKSideBarImageEdgeLength / 2), (height / 2) - (CKSideBarImageEdgeLength / 2), CKSideBarImageEdgeLength, CKSideBarImageEdgeLength);
}

- (void)setIsActive:(BOOL)isActive {
    if (isActive) {
        self.iconView.image = self.selectedImage;
    } else {
        self.iconView.image = self.unSelectedImage;
    }
}


@end

@interface CKSideBarController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic) UIView *containerView;
@property(nonatomic) UITableView *sideBarView;
@property(nonatomic) UIView *borderView;

@end

@implementation CKSideBarController

- (id)init {
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        [NSException raise:NSInvalidArgumentException format:@"CKSideBarController is only supported when running under UIUserInterfaceIdiomPad"];
        return nil;
    }
    
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor clearColor];
        
        self.sideBarView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, CKSideBarWidth + CKCornerRadius, self.view.bounds.size.height) style:UITableViewStylePlain];
        self.sideBarView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
        self.sideBarView.backgroundColor = [UIColor clearColor];
        self.sideBarView.scrollEnabled = NO;
        self.sideBarView.dataSource = self;
        self.sideBarView.delegate = self;
        self.sideBarView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.sideBarView.rowHeight = CKSideBarButtonHeight;
        [self.view addSubview:self.sideBarView];
        
        self.borderView = [[UIView alloc] initWithFrame:CGRectMake(CKSideBarWidth - 1.0, 0, 20, self.view.bounds.size.height)];
        self.borderView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
        self.borderView.backgroundColor = [UIColor blackColor];
        self.borderView.layer.cornerRadius = CKCornerRadius;
        [self.view addSubview:self.borderView];

        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(CKSideBarWidth, 0, self.view.bounds.size.width - CKSideBarWidth, self.view.bounds.size.height)];
        self.containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.containerView.clipsToBounds = YES;
        self.containerView.layer.cornerRadius = CKCornerRadius;
        [self.view addSubview:self.containerView];
    }
    return self;
}

- (void)viewWillLayoutSubviews {
    self.selectedViewController.view.frame = self.containerView.bounds;
}

#pragma mark - Autorotation
// iOS 6+
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate {
    return YES;
}

// < iOS 6
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

#pragma mark - public

- (void)refresh {
    [self.sideBarView reloadData];
}

- (void)setViewControllers:(NSArray *)viewControllers {
    if (viewControllers != _viewControllers) {
        BOOL isSelectedControllerPresent = [viewControllers containsObject:_selectedViewController];
        NSUInteger previousSelectedIndex = self.selectedIndex;

        for (UIViewController *controller in _viewControllers) {
            if (controller != _selectedViewController || !isSelectedControllerPresent) {
                [controller.view removeFromSuperview];
                [controller removeFromParentViewController];
            }
        }

        _viewControllers = viewControllers;

        for (UIViewController *controller in _viewControllers) {
            [self addChildViewController:controller];
        }

        if (_selectedViewController && [_viewControllers containsObject:self.selectedViewController]) {
            // we cool
        } else {
            self.selectedViewController = _viewControllers[previousSelectedIndex];
        }

        [self.sideBarView reloadData];
    }
}

- (void)setSelectedViewController:(UIViewController *)selectedViewController {
    BOOL delegateRespondsToSelector = [self.delegate respondsToSelector:@selector(sideBarController:shouldSelectViewController:)];
    BOOL shouldSelectController = delegateRespondsToSelector ? [self.delegate sideBarController:self shouldSelectViewController:selectedViewController] : YES;
    if (shouldSelectController && _selectedViewController != selectedViewController) {
        UIViewController *oldController = _selectedViewController;
        _selectedViewController = selectedViewController;

        [self.containerView addSubview:_selectedViewController.view];
        [oldController.view removeFromSuperview];

        [self.sideBarView reloadData];

        [self.view setNeedsLayout];

        if ([self.delegate respondsToSelector:@selector(sideBarController:didSelectViewController:)]) {
            [self.delegate sideBarController:self didSelectViewController:_selectedViewController];
        }
    }
}

- (NSUInteger)selectedIndex {
    if (self.selectedViewController) {
        return [self.viewControllers indexOfObject:self.selectedViewController];
    } else {
        return 0;
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    self.selectedViewController = self.viewControllers[selectedIndex];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewControllers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseId = @"sideBar";
    CKSideBarCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) cell = [[CKSideBarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];

    UIViewController *viewController = self.viewControllers[indexPath.row];
    CKSideBarItem *sideBarItem = viewController.sideBarItem;

    cell.selectedImage = sideBarItem.selectedImage;
    cell.unSelectedImage = sideBarItem.unSelectedImage;
    
    cell.backgroundColor = [UIColor clearColor];
    
    [cell setIsActive:(viewController == self.selectedViewController)];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedViewController = self.viewControllers[indexPath.row];
    [self.sideBarView reloadData];
}

@end

@implementation UIViewController (CKSideBarController)

- (CKSideBarController *)sideBarController {
    UIViewController *parent = self.parentViewController;
    while (parent != nil) {
        if ([parent isKindOfClass:[CKSideBarController class]]) {
            return (CKSideBarController *)parent;
        } else {
            parent = parent.parentViewController;
        }
    }
    return nil;
}

static char const * const CKSideBarItemKey = "CKSideBarItemKey";

- (void)setSideBarItem:(CKSideBarItem *)sideBarItem {
    objc_setAssociatedObject(self, CKSideBarItemKey, sideBarItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CKSideBarItem *)sideBarItem {
    CKSideBarItem *item = objc_getAssociatedObject(self, CKSideBarItemKey);
    if (!item) {
        item = [[CKSideBarItem alloc] init];
        item.image = [UIImage imageNamed:@"default-tabbar-icon.png"];
        [self setSideBarItem:item];
    }
    return item;
}

@end