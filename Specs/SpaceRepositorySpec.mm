#import "SpaceRepository.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(SpaceRepositorySpec)

describe(@"SpaceRepository", ^{
    __block SpaceRepository *spaceRepository;

    beforeEach(^{
        spaceRepository = [[[SpaceRepository alloc] init] autorelease];
        [spaceRepository populateFromGeoJSONFile:@"sfpopos.geojson"];
    });
    
    it(@"should populate from the sfpopos.geojson file", ^{
        [spaceRepository.spaces count] should equal(34);
    });
});

SPEC_END
