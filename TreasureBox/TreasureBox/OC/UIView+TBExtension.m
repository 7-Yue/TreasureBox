#import "UIView+TBExtension.h"
#import "NSObject+TBExtension.h"

@implementation UIView (TBExtension)

- (void)setCorners:(ViewCorner)corners radius:(double) radius {
    UIRectCorner v = 0;
    
    if ((corners & ViewCornerAllCorners) == ViewCornerAllCorners) {
        v = UIRectCornerAllCorners;
    } else if (corners == ViewCornerEmpty){
        self.layer.mask = nil;
        return;
    } else {
        if (corners & ViewCornerTopLeft) {
            v = v | UIRectCornerTopLeft;
        }
        if (corners & ViewCornerTopRight) {
            v = v | UIRectCornerTopRight;
        }
        if (corners & ViewCornerBottomLeft) {
            v = v | UIRectCornerBottomLeft;
        }
        if (corners & ViewCornerBottomRight) {
            v = v | UIRectCornerBottomRight;
        }
    }
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                            byRoundingCorners:v
                                                  cornerRadii:(CGSizeMake(radius, radius))].CGPath;
    self.layer.mask = shapeLayer;
}

- (void)setCornersAndLayout:(ViewCorner)corners radius:(double) radius {
    [self setCorners:corners radius:radius];
    [self layoutIfNeeded];
}

@end
