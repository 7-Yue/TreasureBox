#import <UIKit/UIKit.h>


typedef NS_OPTIONS(NSUInteger, ViewCorner) {
    ViewCornerEmpty       = 0,
    ViewCornerTopLeft     = 1 << 0,
    ViewCornerTopRight    = 1 << 1,
    ViewCornerBottomLeft  = 1 << 2,
    ViewCornerBottomRight = 1 << 3,
    ViewCornerAllCorners  = ViewCornerTopLeft|
                            ViewCornerTopRight|
                            ViewCornerBottomLeft|
                            ViewCornerBottomRight
};

@interface UIView (TBExtension)

- (void)setCorners:(ViewCorner)corners radius:(double) radius;
- (void)setCornersAndLayout:(ViewCorner)corners radius:(double) radius;

@end

