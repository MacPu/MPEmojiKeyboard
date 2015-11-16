//
//  MPEmojiEmoticons.m
//  MPEmojiKeyboard
//
//  Created by 蒲德贵 on 15/11/16.
//  Copyright © 2015年 MacPu. All rights reserved.
//

#import "MPEmojiEmoticons.h"

@implementation MPEmojiEmoticons

+ (NSArray *)allEmoticons {
    NSMutableArray *array = [NSMutableArray new];
    for (int i=0x1F600; i<=0x1F637; i++) {
        [array addObject:[MPEmoji emojiWithCode:i]];
    }
    return array;
}

EMOJI_METHOD(grinningFace,1F600);
EMOJI_METHOD(grinningFaceWithSmilingEyes,1F601);
EMOJI_METHOD(faceWithTearsOfJoy,1F602);
EMOJI_METHOD(smilingFaceWithOpenMouth,1F603);
EMOJI_METHOD(smilingFaceWithOpenMouthAndSmilingEyes,1F604);
EMOJI_METHOD(smilingFaceWithOpenMouthAndColdSweat,1F605);
EMOJI_METHOD(smilingFaceWithOpenMouthAndTightlyClosedEyes,1F606);
EMOJI_METHOD(smilingFaceWithHalo,1F607);
EMOJI_METHOD(smilingFaceWithHorns,1F608);
EMOJI_METHOD(winkingFace,1F609);
EMOJI_METHOD(smilingFaceWithSmilingEyes,1F60A);
EMOJI_METHOD(faceSavouringDeliciousFood,1F60B);
EMOJI_METHOD(relievedFace,1F60C);
EMOJI_METHOD(smilingFaceWithHeartShapedEyes,1F60D);
EMOJI_METHOD(smilingFaceWithSunglasses,1F60E);
EMOJI_METHOD(smirkingFace,1F60F);
EMOJI_METHOD(neutralFace,1F610);
EMOJI_METHOD(expressionlessFace,1F611);
EMOJI_METHOD(unamusedFace,1F612);
EMOJI_METHOD(faceWithColdSweat,1F613);
EMOJI_METHOD(pensiveFace,1F614);
EMOJI_METHOD(confusedFace,1F615);
EMOJI_METHOD(confoundedFace,1F616);
EMOJI_METHOD(kissingFace,1F617);
EMOJI_METHOD(faceThrowingAKiss,1F618);
EMOJI_METHOD(kissingFaceWithSmilingEyes,1F619);
EMOJI_METHOD(kissingFaceWithClosedEyes,1F61A);
EMOJI_METHOD(faceWithStuckOutTongue,1F61B);
EMOJI_METHOD(faceWithStuckOutTongueAndWinkingEye,1F61C);
EMOJI_METHOD(faceWithStuckOutTongueAndTightlyClosedEyes,1F61D);
EMOJI_METHOD(disappointedFace,1F61E);
EMOJI_METHOD(worriedFace,1F61F);
EMOJI_METHOD(angryFace,1F620);
EMOJI_METHOD(poutingFace,1F621);
EMOJI_METHOD(cryingFace,1F622);
EMOJI_METHOD(perseveringFace,1F623);
EMOJI_METHOD(faceWithLookOfTriumph,1F624);
EMOJI_METHOD(disappointedButRelievedFace,1F625);
EMOJI_METHOD(frowningFaceWithOpenMouth,1F626);
EMOJI_METHOD(anguishedFace,1F627);
EMOJI_METHOD(fearfulFace,1F628);
EMOJI_METHOD(wearyFace,1F629);
EMOJI_METHOD(sleepyFace,1F62A);
EMOJI_METHOD(tiredFace,1F62B);
EMOJI_METHOD(grimacingFace,1F62C);
EMOJI_METHOD(loudlyCryingFace,1F62D);
EMOJI_METHOD(faceWithOpenMouth,1F62E);
EMOJI_METHOD(hushedFace,1F62F);
EMOJI_METHOD(faceWithOpenMouthAndColdSweat,1F630);
EMOJI_METHOD(faceScreamingInFear,1F631);
EMOJI_METHOD(astonishedFace,1F632);
EMOJI_METHOD(flushedFace,1F633);
EMOJI_METHOD(sleepingFace,1F634);
EMOJI_METHOD(dizzyFace,1F635);
EMOJI_METHOD(faceWithoutMouth,1F636);
EMOJI_METHOD(faceWithMedicalMask,1F637);
EMOJI_METHOD(grinningCatFaceWithSmilingEyes,1F638);
EMOJI_METHOD(catFaceWithTearsOfJoy,1F639);
EMOJI_METHOD(smilingCatFaceWithOpenMouth,1F63A);
EMOJI_METHOD(smilingCatFaceWithHeartShapedEyes,1F63B);
EMOJI_METHOD(catFaceWithWrySmile,1F63C);
EMOJI_METHOD(kissingCatFaceWithClosedEyes,1F63D);
EMOJI_METHOD(poutingCatFace,1F63E);
EMOJI_METHOD(cryingCatFace,1F63F);
EMOJI_METHOD(wearyCatFace,1F640);
EMOJI_METHOD(faceWithNoGoodGesture,1F645);
EMOJI_METHOD(faceWithOkGesture,1F646);
EMOJI_METHOD(personBowingDeeply,1F647);
EMOJI_METHOD(seeNoEvilMonkey,1F648);
EMOJI_METHOD(hearNoEvilMonkey,1F649);
EMOJI_METHOD(speakNoEvilMonkey,1F64A);
EMOJI_METHOD(happyPersonRaisingOneHand,1F64B);
EMOJI_METHOD(personRaisingBothHandsInCelebration,1F64C);
EMOJI_METHOD(personFrowning,1F64D);
EMOJI_METHOD(personWithPoutingFace,1F64E);
EMOJI_METHOD(personWithFoldedHands,1F64F);
@end
