//
//  DataHandleMacros.h
//  ZJRC_Iwz
//
//  Created by Wynter on 15/11/19.
//  Copyright © 2015年 Wynter. All rights reserved.
//  数据处理

#ifndef DataHandleMacros_h
#define DataHandleMacros_h

//判断是否为空
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

#define SURE_STR_NOT_NULL(x) ((x) == nil || [(x) isEqualToString:@"null"] ? @"" : (x))

#define GetIntFromDict(_dict,_name,_defValue) ( (_dict == nil || [_dict objectForKey:_name] == nil) ? _defValue : [[NSString stringWithFormat:@"%@",[_dict objectForKey:_name]] intValue])

#define GetFloatFromDict(_dict,_name,_defValue) ((_dict == nil || [_dict objectForKey:_name] == nil) ? _defValue : [[NSString stringWithFormat:@"%@",[_dict objectForKey:_name]] doubleValue])

#define GetStringFromDict(_dict,_name,_defValue) ((_dict == nil || [_dict objectForKey:_name] == nil || [_dict[_name] isEqual:[NSNull null]] ) ? _defValue : [NSString stringWithFormat:@"%@",[_dict objectForKey:_name]])

#define GetDictionaryFromDict(_dict,_name,_defValue) ((_dict == nil || [_dict objectForKey:_name] == nil) ? _defValue : [_dict objectForKey:_name])

#define GetDateFromDict(_dict,_name,_defValue) ((_dict == nil || [_dict objectForKey:_name] == nil) ? _defValue : [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@",[_dict objectForKey:_name]] doubleValue]])

#endif /* DataHandleMacros_h */
