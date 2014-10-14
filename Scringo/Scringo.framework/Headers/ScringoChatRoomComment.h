//
//  ScringoChatRoomComment.h
//  Scringo
//
//  Created by Guy Federovsky on 10/2/13.
//  Copyright (c) 2013 Ziggy Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScringoUser.h"

#define SCRINGO_COMMENT_PLAIN       @"text/plain"
#define SCRINGO_COMMENT_IMAGE       @"image"
#define SCRINGO_COMMENT_STICKER     @"sticker"
/** Defines available Comment Types */
typedef NS_ENUM(NSUInteger, ScringoChatRoomCommmentType) {
    /** Plain Text Comment */
    SCRINGO_CHAT_ROOM_COMMENT_TYPE_PLAIN    = 0,
    /** Image Comment */
    SCRINGO_CHAT_ROOM_COMMENT_TYPE_IMAGE    = 1,
    /** Sticker Text Comment */
    SCRINGO_CHAT_ROOM_COMMENT_TYPE_STICKER  = 2
};

/** Represents a single Chat Room Comment.
 */
@interface ScringoChatRoomComment : NSObject
/** The Id of the comment
 */
@property (nonatomic, readonly) int commentId;
/** The Id of the Chat Room in which the comment reside.
 */
@property (nonatomic, readonly) int topicId;
/** Number of likes the comment has.
 */
@property (nonatomic, readonly) int likesNumber;
/** The User that posted the comment.
 
 @see ScringoUser
 */
@property (nonatomic, assign, readonly) ScringoUser *user;
/** The posted comment text.
 
 If the Comment is a sticker or image, the text will be the sticker/image URL.
 */
@property (nonatomic, assign, readonly) NSString *text;
/** The date and time and comment was posted at.
 */
@property (nonatomic, assign, readonly) NSDate *dateTime;
/** The type of the comment.
 */
@property (nonatomic, readonly) ScringoChatRoomCommmentType type;


@end
