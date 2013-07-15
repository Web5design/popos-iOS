#import "BigPanelButton.h"

@implementation BigPanelButton

#pragma mark Settings

- (void)setNormalColor:(UIColor *)normalColor {
    [self setBackgroundColor:normalColor];
    _normalColor = normalColor;
}

- (void)setHighlightedColor:(UIColor *)highlightedColor {
    _highlightedColor = highlightedColor;
}

#pragma mark Actions

- (void)didTapButtonForHighlight:(UIButton *)sender {
    [UIView animateWithDuration:0.3f animations:^{
        [self setBackgroundColor:_highlightedColor];
    }];

}

- (void)didUnTapButtonForHighlight:(UIButton *)sender {
    [UIView animateWithDuration:0.6f animations:^{
        [self setBackgroundColor:_normalColor];
    }];
}

#pragma mark Initialization

- (void)setupButton {
    [self addTarget:self action:@selector(didTapButtonForHighlight:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(didUnTapButtonForHighlight:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(didUnTapButtonForHighlight:) forControlEvents:UIControlEventTouchUpOutside];
}

- (id)init {
    self = [super init];
    if (self) {
        [self setupButton];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupButton];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupButton];
    }
    return self;
}


@end