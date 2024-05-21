#import <UIKit/UIKit.h>


typedef NS_OPTIONS(NSUInteger, LabelCorner) {
    LabelCornerTopLeft     = 1 << 0,
    LabelCornerTopRight    = 1 << 1,
    LabelCornerBottomLeft  = 1 << 2,
    LabelCornerBottomRight = 1 << 3,
    LabelCornerAllCorners  = LabelCornerTopLeft|
                             LabelCornerTopRight|
                             LabelCornerBottomLeft|
                             LabelCornerBottomRight
};

@interface UILabel (TBExtension)

- (void)setLabelCorner:(LabelCorner) corner;

@end

