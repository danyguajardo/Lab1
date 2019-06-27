//
//  cellDecoration.m
//  Lab1
//
//  Created by sbernal0115 on 6/27/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import "cellDecoration.h"

@implementation cellDecoration

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    cellDecoration *cell = [tableView dequeueReusableCellWithIdentifier:@"YourCustomCell" forIndexPath:indexPath];
    
    return cell;
}
@end
