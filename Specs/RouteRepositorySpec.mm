#import "RouteRepository.h"
#import "SpaceRepository.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RouteRepositorySpec)

describe(@"RouteRepository", ^{
    __block RouteRepository *routeRepository;
    __block SpaceRepository *spaceRepository;
    
    beforeEach(^{
        spaceRepository = [[[SpaceRepository alloc] init] autorelease];
        [spaceRepository populateFromGeoJSONFile:@"sfpopos.geojson"];
        
        routeRepository = [[[RouteRepository alloc] init] autorelease];
        [routeRepository populateFromGeoJSONFile:@"sfpopos-routes-collection.geojson"];
    });
    
    it(@"should populate from the sfpopos-routes-collection.geojson file", ^{
        [routeRepository.routes count] should equal(4);
    });
    
    it(@"should populate a route with all the spaces that have that route identifier", ^{
        [routeRepository addSpaces:spaceRepository];
        [((Route *)routeRepository.routes[0]).spaces count] should equal(7);
    });
    
    it(@"should give the routes start and end names based on their spaces", ^{
        Route *route = routeRepository.routes[0];
        [routeRepository addSpaces:spaceRepository];
        [route firstToLastName] should equal(@"Redwood Park to Commercial Street");
    });
});

SPEC_END

