// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class MAddTopic;
@class MAddTopic_Builder;
@class MComment;
@class MCommentList;
@class MCommentList_Builder;
@class MComment_Builder;
@class MMsgCount;
@class MMsgCount_Builder;
@class MTag;
@class MTagList;
@class MTagList_Builder;
@class MTag_Builder;
@class MTopic;
@class MTopicMini;
@class MTopicMiniList;
@class MTopicMiniList_Builder;
@class MTopicMini_Builder;
@class MTopic_Builder;
@class MTreeHole;
@class MTreeHole_Builder;

@interface ZsndTreeholeRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface MTreeHole : PBGeneratedMessage {
@private
  NSMutableArray* mutableTopicsList;
}
- (NSArray*) topicsList;
- (MTopic*) topicsAtIndex:(int32_t) index;

+ (MTreeHole*) defaultInstance;
- (MTreeHole*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MTreeHole_Builder*) builder;
+ (MTreeHole_Builder*) builder;
+ (MTreeHole_Builder*) builderWithPrototype:(MTreeHole*) prototype;

+ (MTreeHole*) parseFromData:(NSData*) data;
+ (MTreeHole*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MTreeHole*) parseFromInputStream:(NSInputStream*) input;
+ (MTreeHole*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MTreeHole*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MTreeHole*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MTreeHole_Builder : PBGeneratedMessage_Builder {
@private
  MTreeHole* result;
}

- (MTreeHole*) defaultInstance;

- (MTreeHole_Builder*) clear;
- (MTreeHole_Builder*) clone;

- (MTreeHole*) build;
- (MTreeHole*) buildPartial;

- (MTreeHole_Builder*) mergeFrom:(MTreeHole*) other;
- (MTreeHole_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MTreeHole_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (NSArray*) topicsList;
- (MTopic*) topicsAtIndex:(int32_t) index;
- (MTreeHole_Builder*) replaceTopicsAtIndex:(int32_t) index with:(MTopic*) value;
- (MTreeHole_Builder*) addTopics:(MTopic*) value;
- (MTreeHole_Builder*) addAllTopics:(NSArray*) values;
- (MTreeHole_Builder*) clearTopicsList;
@end

@interface MTopic : PBGeneratedMessage {
@private
  BOOL hasPraiseCnt_:1;
  BOOL hasCommentCnt_:1;
  BOOL hasHasPraise_:1;
  BOOL hasIsHot_:1;
  BOOL hasIsTop_:1;
  BOOL hasId_:1;
  BOOL hasTagid_:1;
  BOOL hasTag_:1;
  BOOL hasContent_:1;
  BOOL hasTime_:1;
  BOOL hasImg_:1;
  BOOL hasAuthor_:1;
  BOOL hasCreateTime_:1;
  int32_t praiseCnt;
  int32_t commentCnt;
  int32_t hasPraise;
  int32_t isHot;
  int32_t isTop;
  NSString* id;
  NSString* tagid;
  NSString* tag;
  NSString* content;
  NSString* time;
  NSString* img;
  NSString* author;
  NSString* createTime;
}
- (BOOL) hasId;
- (BOOL) hasTagid;
- (BOOL) hasTag;
- (BOOL) hasContent;
- (BOOL) hasTime;
- (BOOL) hasImg;
- (BOOL) hasPraiseCnt;
- (BOOL) hasCommentCnt;
- (BOOL) hasHasPraise;
- (BOOL) hasIsHot;
- (BOOL) hasIsTop;
- (BOOL) hasAuthor;
- (BOOL) hasCreateTime;
@property (readonly, retain) NSString* id;
@property (readonly, retain) NSString* tagid;
@property (readonly, retain) NSString* tag;
@property (readonly, retain) NSString* content;
@property (readonly, retain) NSString* time;
@property (readonly, retain) NSString* img;
@property (readonly) int32_t praiseCnt;
@property (readonly) int32_t commentCnt;
@property (readonly) int32_t hasPraise;
@property (readonly) int32_t isHot;
@property (readonly) int32_t isTop;
@property (readonly, retain) NSString* author;
@property (readonly, retain) NSString* createTime;

+ (MTopic*) defaultInstance;
- (MTopic*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MTopic_Builder*) builder;
+ (MTopic_Builder*) builder;
+ (MTopic_Builder*) builderWithPrototype:(MTopic*) prototype;

+ (MTopic*) parseFromData:(NSData*) data;
+ (MTopic*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MTopic*) parseFromInputStream:(NSInputStream*) input;
+ (MTopic*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MTopic*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MTopic*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MTopic_Builder : PBGeneratedMessage_Builder {
@private
  MTopic* result;
}

- (MTopic*) defaultInstance;

- (MTopic_Builder*) clear;
- (MTopic_Builder*) clone;

- (MTopic*) build;
- (MTopic*) buildPartial;

- (MTopic_Builder*) mergeFrom:(MTopic*) other;
- (MTopic_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MTopic_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasId;
- (NSString*) id;
- (MTopic_Builder*) setId:(NSString*) value;
- (MTopic_Builder*) clearId;

- (BOOL) hasTagid;
- (NSString*) tagid;
- (MTopic_Builder*) setTagid:(NSString*) value;
- (MTopic_Builder*) clearTagid;

- (BOOL) hasTag;
- (NSString*) tag;
- (MTopic_Builder*) setTag:(NSString*) value;
- (MTopic_Builder*) clearTag;

- (BOOL) hasContent;
- (NSString*) content;
- (MTopic_Builder*) setContent:(NSString*) value;
- (MTopic_Builder*) clearContent;

- (BOOL) hasTime;
- (NSString*) time;
- (MTopic_Builder*) setTime:(NSString*) value;
- (MTopic_Builder*) clearTime;

- (BOOL) hasImg;
- (NSString*) img;
- (MTopic_Builder*) setImg:(NSString*) value;
- (MTopic_Builder*) clearImg;

- (BOOL) hasPraiseCnt;
- (int32_t) praiseCnt;
- (MTopic_Builder*) setPraiseCnt:(int32_t) value;
- (MTopic_Builder*) clearPraiseCnt;

- (BOOL) hasCommentCnt;
- (int32_t) commentCnt;
- (MTopic_Builder*) setCommentCnt:(int32_t) value;
- (MTopic_Builder*) clearCommentCnt;

- (BOOL) hasHasPraise;
- (int32_t) hasPraise;
- (MTopic_Builder*) setHasPraise:(int32_t) value;
- (MTopic_Builder*) clearHasPraise;

- (BOOL) hasIsHot;
- (int32_t) isHot;
- (MTopic_Builder*) setIsHot:(int32_t) value;
- (MTopic_Builder*) clearIsHot;

- (BOOL) hasIsTop;
- (int32_t) isTop;
- (MTopic_Builder*) setIsTop:(int32_t) value;
- (MTopic_Builder*) clearIsTop;

- (BOOL) hasAuthor;
- (NSString*) author;
- (MTopic_Builder*) setAuthor:(NSString*) value;
- (MTopic_Builder*) clearAuthor;

- (BOOL) hasCreateTime;
- (NSString*) createTime;
- (MTopic_Builder*) setCreateTime:(NSString*) value;
- (MTopic_Builder*) clearCreateTime;
@end

@interface MTag : PBGeneratedMessage {
@private
  BOOL hasId_:1;
  BOOL hasTitle_:1;
  NSString* id;
  NSString* title;
}
- (BOOL) hasId;
- (BOOL) hasTitle;
@property (readonly, retain) NSString* id;
@property (readonly, retain) NSString* title;

+ (MTag*) defaultInstance;
- (MTag*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MTag_Builder*) builder;
+ (MTag_Builder*) builder;
+ (MTag_Builder*) builderWithPrototype:(MTag*) prototype;

+ (MTag*) parseFromData:(NSData*) data;
+ (MTag*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MTag*) parseFromInputStream:(NSInputStream*) input;
+ (MTag*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MTag*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MTag*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MTag_Builder : PBGeneratedMessage_Builder {
@private
  MTag* result;
}

- (MTag*) defaultInstance;

- (MTag_Builder*) clear;
- (MTag_Builder*) clone;

- (MTag*) build;
- (MTag*) buildPartial;

- (MTag_Builder*) mergeFrom:(MTag*) other;
- (MTag_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MTag_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasId;
- (NSString*) id;
- (MTag_Builder*) setId:(NSString*) value;
- (MTag_Builder*) clearId;

- (BOOL) hasTitle;
- (NSString*) title;
- (MTag_Builder*) setTitle:(NSString*) value;
- (MTag_Builder*) clearTitle;
@end

@interface MTagList : PBGeneratedMessage {
@private
  NSMutableArray* mutableTagsList;
}
- (NSArray*) tagsList;
- (MTag*) tagsAtIndex:(int32_t) index;

+ (MTagList*) defaultInstance;
- (MTagList*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MTagList_Builder*) builder;
+ (MTagList_Builder*) builder;
+ (MTagList_Builder*) builderWithPrototype:(MTagList*) prototype;

+ (MTagList*) parseFromData:(NSData*) data;
+ (MTagList*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MTagList*) parseFromInputStream:(NSInputStream*) input;
+ (MTagList*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MTagList*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MTagList*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MTagList_Builder : PBGeneratedMessage_Builder {
@private
  MTagList* result;
}

- (MTagList*) defaultInstance;

- (MTagList_Builder*) clear;
- (MTagList_Builder*) clone;

- (MTagList*) build;
- (MTagList*) buildPartial;

- (MTagList_Builder*) mergeFrom:(MTagList*) other;
- (MTagList_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MTagList_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (NSArray*) tagsList;
- (MTag*) tagsAtIndex:(int32_t) index;
- (MTagList_Builder*) replaceTagsAtIndex:(int32_t) index with:(MTag*) value;
- (MTagList_Builder*) addTags:(MTag*) value;
- (MTagList_Builder*) addAllTags:(NSArray*) values;
- (MTagList_Builder*) clearTagsList;
@end

@interface MComment : PBGeneratedMessage {
@private
  BOOL hasFloor_:1;
  BOOL hasReplyFloor_:1;
  BOOL hasIsLz_:1;
  BOOL hasId_:1;
  BOOL hasUserid_:1;
  BOOL hasReplyid_:1;
  BOOL hasContent_:1;
  BOOL hasTime_:1;
  BOOL hasCreateTime_:1;
  int32_t floor;
  int32_t replyFloor;
  int32_t isLz;
  NSString* id;
  NSString* userid;
  NSString* replyid;
  NSString* content;
  NSString* time;
  NSString* createTime;
}
- (BOOL) hasId;
- (BOOL) hasFloor;
- (BOOL) hasUserid;
- (BOOL) hasReplyFloor;
- (BOOL) hasReplyid;
- (BOOL) hasContent;
- (BOOL) hasTime;
- (BOOL) hasIsLz;
- (BOOL) hasCreateTime;
@property (readonly, retain) NSString* id;
@property (readonly) int32_t floor;
@property (readonly, retain) NSString* userid;
@property (readonly) int32_t replyFloor;
@property (readonly, retain) NSString* replyid;
@property (readonly, retain) NSString* content;
@property (readonly, retain) NSString* time;
@property (readonly) int32_t isLz;
@property (readonly, retain) NSString* createTime;

+ (MComment*) defaultInstance;
- (MComment*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MComment_Builder*) builder;
+ (MComment_Builder*) builder;
+ (MComment_Builder*) builderWithPrototype:(MComment*) prototype;

+ (MComment*) parseFromData:(NSData*) data;
+ (MComment*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MComment*) parseFromInputStream:(NSInputStream*) input;
+ (MComment*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MComment*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MComment*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MComment_Builder : PBGeneratedMessage_Builder {
@private
  MComment* result;
}

- (MComment*) defaultInstance;

- (MComment_Builder*) clear;
- (MComment_Builder*) clone;

- (MComment*) build;
- (MComment*) buildPartial;

- (MComment_Builder*) mergeFrom:(MComment*) other;
- (MComment_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MComment_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasId;
- (NSString*) id;
- (MComment_Builder*) setId:(NSString*) value;
- (MComment_Builder*) clearId;

- (BOOL) hasFloor;
- (int32_t) floor;
- (MComment_Builder*) setFloor:(int32_t) value;
- (MComment_Builder*) clearFloor;

- (BOOL) hasUserid;
- (NSString*) userid;
- (MComment_Builder*) setUserid:(NSString*) value;
- (MComment_Builder*) clearUserid;

- (BOOL) hasReplyFloor;
- (int32_t) replyFloor;
- (MComment_Builder*) setReplyFloor:(int32_t) value;
- (MComment_Builder*) clearReplyFloor;

- (BOOL) hasReplyid;
- (NSString*) replyid;
- (MComment_Builder*) setReplyid:(NSString*) value;
- (MComment_Builder*) clearReplyid;

- (BOOL) hasContent;
- (NSString*) content;
- (MComment_Builder*) setContent:(NSString*) value;
- (MComment_Builder*) clearContent;

- (BOOL) hasTime;
- (NSString*) time;
- (MComment_Builder*) setTime:(NSString*) value;
- (MComment_Builder*) clearTime;

- (BOOL) hasIsLz;
- (int32_t) isLz;
- (MComment_Builder*) setIsLz:(int32_t) value;
- (MComment_Builder*) clearIsLz;

- (BOOL) hasCreateTime;
- (NSString*) createTime;
- (MComment_Builder*) setCreateTime:(NSString*) value;
- (MComment_Builder*) clearCreateTime;
@end

@interface MCommentList : PBGeneratedMessage {
@private
  NSMutableArray* mutableCommentsList;
}
- (NSArray*) commentsList;
- (MComment*) commentsAtIndex:(int32_t) index;

+ (MCommentList*) defaultInstance;
- (MCommentList*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MCommentList_Builder*) builder;
+ (MCommentList_Builder*) builder;
+ (MCommentList_Builder*) builderWithPrototype:(MCommentList*) prototype;

+ (MCommentList*) parseFromData:(NSData*) data;
+ (MCommentList*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MCommentList*) parseFromInputStream:(NSInputStream*) input;
+ (MCommentList*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MCommentList*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MCommentList*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MCommentList_Builder : PBGeneratedMessage_Builder {
@private
  MCommentList* result;
}

- (MCommentList*) defaultInstance;

- (MCommentList_Builder*) clear;
- (MCommentList_Builder*) clone;

- (MCommentList*) build;
- (MCommentList*) buildPartial;

- (MCommentList_Builder*) mergeFrom:(MCommentList*) other;
- (MCommentList_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MCommentList_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (NSArray*) commentsList;
- (MComment*) commentsAtIndex:(int32_t) index;
- (MCommentList_Builder*) replaceCommentsAtIndex:(int32_t) index with:(MComment*) value;
- (MCommentList_Builder*) addComments:(MComment*) value;
- (MCommentList_Builder*) addAllComments:(NSArray*) values;
- (MCommentList_Builder*) clearCommentsList;
@end

@interface MAddTopic : PBGeneratedMessage {
@private
  BOOL hasTagId_:1;
  BOOL hasContent_:1;
  BOOL hasImg_:1;
  NSString* tagId;
  NSString* content;
  NSData* img;
}
- (BOOL) hasTagId;
- (BOOL) hasContent;
- (BOOL) hasImg;
@property (readonly, retain) NSString* tagId;
@property (readonly, retain) NSString* content;
@property (readonly, retain) NSData* img;

+ (MAddTopic*) defaultInstance;
- (MAddTopic*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MAddTopic_Builder*) builder;
+ (MAddTopic_Builder*) builder;
+ (MAddTopic_Builder*) builderWithPrototype:(MAddTopic*) prototype;

+ (MAddTopic*) parseFromData:(NSData*) data;
+ (MAddTopic*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MAddTopic*) parseFromInputStream:(NSInputStream*) input;
+ (MAddTopic*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MAddTopic*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MAddTopic*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MAddTopic_Builder : PBGeneratedMessage_Builder {
@private
  MAddTopic* result;
}

- (MAddTopic*) defaultInstance;

- (MAddTopic_Builder*) clear;
- (MAddTopic_Builder*) clone;

- (MAddTopic*) build;
- (MAddTopic*) buildPartial;

- (MAddTopic_Builder*) mergeFrom:(MAddTopic*) other;
- (MAddTopic_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MAddTopic_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasTagId;
- (NSString*) tagId;
- (MAddTopic_Builder*) setTagId:(NSString*) value;
- (MAddTopic_Builder*) clearTagId;

- (BOOL) hasContent;
- (NSString*) content;
- (MAddTopic_Builder*) setContent:(NSString*) value;
- (MAddTopic_Builder*) clearContent;

- (BOOL) hasImg;
- (NSData*) img;
- (MAddTopic_Builder*) setImg:(NSData*) value;
- (MAddTopic_Builder*) clearImg;
@end

@interface MMsgCount : PBGeneratedMessage {
@private
  BOOL hasComment_:1;
  BOOL hasChat_:1;
  int32_t comment;
  int32_t chat;
}
- (BOOL) hasComment;
- (BOOL) hasChat;
@property (readonly) int32_t comment;
@property (readonly) int32_t chat;

+ (MMsgCount*) defaultInstance;
- (MMsgCount*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MMsgCount_Builder*) builder;
+ (MMsgCount_Builder*) builder;
+ (MMsgCount_Builder*) builderWithPrototype:(MMsgCount*) prototype;

+ (MMsgCount*) parseFromData:(NSData*) data;
+ (MMsgCount*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MMsgCount*) parseFromInputStream:(NSInputStream*) input;
+ (MMsgCount*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MMsgCount*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MMsgCount*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MMsgCount_Builder : PBGeneratedMessage_Builder {
@private
  MMsgCount* result;
}

- (MMsgCount*) defaultInstance;

- (MMsgCount_Builder*) clear;
- (MMsgCount_Builder*) clone;

- (MMsgCount*) build;
- (MMsgCount*) buildPartial;

- (MMsgCount_Builder*) mergeFrom:(MMsgCount*) other;
- (MMsgCount_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MMsgCount_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasComment;
- (int32_t) comment;
- (MMsgCount_Builder*) setComment:(int32_t) value;
- (MMsgCount_Builder*) clearComment;

- (BOOL) hasChat;
- (int32_t) chat;
- (MMsgCount_Builder*) setChat:(int32_t) value;
- (MMsgCount_Builder*) clearChat;
@end

@interface MTopicMini : PBGeneratedMessage {
@private
  BOOL hasUnreadCnt_:1;
  BOOL hasId_:1;
  BOOL hasTag_:1;
  BOOL hasContent_:1;
  BOOL hasCreateTime_:1;
  int32_t unreadCnt;
  NSString* id;
  NSString* tag;
  NSString* content;
  NSString* createTime;
}
- (BOOL) hasId;
- (BOOL) hasTag;
- (BOOL) hasContent;
- (BOOL) hasUnreadCnt;
- (BOOL) hasCreateTime;
@property (readonly, retain) NSString* id;
@property (readonly, retain) NSString* tag;
@property (readonly, retain) NSString* content;
@property (readonly) int32_t unreadCnt;
@property (readonly, retain) NSString* createTime;

+ (MTopicMini*) defaultInstance;
- (MTopicMini*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MTopicMini_Builder*) builder;
+ (MTopicMini_Builder*) builder;
+ (MTopicMini_Builder*) builderWithPrototype:(MTopicMini*) prototype;

+ (MTopicMini*) parseFromData:(NSData*) data;
+ (MTopicMini*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MTopicMini*) parseFromInputStream:(NSInputStream*) input;
+ (MTopicMini*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MTopicMini*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MTopicMini*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MTopicMini_Builder : PBGeneratedMessage_Builder {
@private
  MTopicMini* result;
}

- (MTopicMini*) defaultInstance;

- (MTopicMini_Builder*) clear;
- (MTopicMini_Builder*) clone;

- (MTopicMini*) build;
- (MTopicMini*) buildPartial;

- (MTopicMini_Builder*) mergeFrom:(MTopicMini*) other;
- (MTopicMini_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MTopicMini_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasId;
- (NSString*) id;
- (MTopicMini_Builder*) setId:(NSString*) value;
- (MTopicMini_Builder*) clearId;

- (BOOL) hasTag;
- (NSString*) tag;
- (MTopicMini_Builder*) setTag:(NSString*) value;
- (MTopicMini_Builder*) clearTag;

- (BOOL) hasContent;
- (NSString*) content;
- (MTopicMini_Builder*) setContent:(NSString*) value;
- (MTopicMini_Builder*) clearContent;

- (BOOL) hasUnreadCnt;
- (int32_t) unreadCnt;
- (MTopicMini_Builder*) setUnreadCnt:(int32_t) value;
- (MTopicMini_Builder*) clearUnreadCnt;

- (BOOL) hasCreateTime;
- (NSString*) createTime;
- (MTopicMini_Builder*) setCreateTime:(NSString*) value;
- (MTopicMini_Builder*) clearCreateTime;
@end

@interface MTopicMiniList : PBGeneratedMessage {
@private
  NSMutableArray* mutableTopicsList;
}
- (NSArray*) topicsList;
- (MTopicMini*) topicsAtIndex:(int32_t) index;

+ (MTopicMiniList*) defaultInstance;
- (MTopicMiniList*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MTopicMiniList_Builder*) builder;
+ (MTopicMiniList_Builder*) builder;
+ (MTopicMiniList_Builder*) builderWithPrototype:(MTopicMiniList*) prototype;

+ (MTopicMiniList*) parseFromData:(NSData*) data;
+ (MTopicMiniList*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MTopicMiniList*) parseFromInputStream:(NSInputStream*) input;
+ (MTopicMiniList*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MTopicMiniList*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MTopicMiniList*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MTopicMiniList_Builder : PBGeneratedMessage_Builder {
@private
  MTopicMiniList* result;
}

- (MTopicMiniList*) defaultInstance;

- (MTopicMiniList_Builder*) clear;
- (MTopicMiniList_Builder*) clone;

- (MTopicMiniList*) build;
- (MTopicMiniList*) buildPartial;

- (MTopicMiniList_Builder*) mergeFrom:(MTopicMiniList*) other;
- (MTopicMiniList_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MTopicMiniList_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (NSArray*) topicsList;
- (MTopicMini*) topicsAtIndex:(int32_t) index;
- (MTopicMiniList_Builder*) replaceTopicsAtIndex:(int32_t) index with:(MTopicMini*) value;
- (MTopicMiniList_Builder*) addTopics:(MTopicMini*) value;
- (MTopicMiniList_Builder*) addAllTopics:(NSArray*) values;
- (MTopicMiniList_Builder*) clearTopicsList;
@end

