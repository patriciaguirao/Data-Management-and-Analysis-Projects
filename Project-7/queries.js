// 1. show exactly two documents from the listings collection in any order
db.listings.find().limit(2)
/*
[
  {
    _id: ObjectId("61abfa5d7ac0ec679e7f8103"),
    id: 2595,
    listing_url: 'https://www.airbnb.com/rooms/2595',
    scrape_id: Long("20211102175544"),
    last_scraped: '2021-11-03',
    name: 'Skylit Midtown Castle',
    description: 'Beautiful, spacious skylit studio in the heart of Midtown, Manhattan. <br /><br />STUNNING SKYLIT STUDIO / 1 BED + SINGLE / FULL BATH / FULL KITCHEN / FIREPLACE / CENTRALLY LOCATED / WiFi + APPLE TV / SHEETS + TOWELS<br /><br /><b>The space</b><br />- Spacious (500+ft²), immaculate and nicely furnished & designed studio.<br />- Tuck yourself into the ultra comfortable bed under the skylight. Fall in love with a myriad of bright lights in the city night sky. <br />- Single-sized bed/convertible floor mattress with luxury bedding (available upon request).<br />- Gorgeous pyramid skylight with amazing diffused natural light, stunning architectural details, soaring high vaulted ceilings, exposed brick, wood burning fireplace, floor seating area with natural zafu cushions, modern style mixed with eclectic art & antique treasures, large full bath, newly renovated kitchen, air conditioning/heat, high speed WiFi Internet, and Apple TV.<br />- Centrally located in the heart of Midtown Manhattan',
    neighborhood_overview: 'Centrally located in the heart of Manhattan just a few blocks from all subway connections in the very desirable Midtown location a few minutes walk to Times Square, the Theater District, Bryant Park and Herald Square.',
*/

// 2. find the possible values (distinct) that appear in the field,host_name (see the docs)
db.listings.distinct('host_name')
/*
[
  NaN,
  123,
  475,
  '',
  "'Cil",
  '(Ari) HENRY LEE',
  '(Email hidden by Airbnb)',
  '-TheQueensCornerLot',
  '2018Serenity',
*/

// 3. choose one of the host names above and show exactly one listing from that host
// only show the host name, name of the listing, and the url to the listing
db.listings.find({'host_name':'Abigail'}, { listing_url: 1, name: 1, host_name: 1, _id: 0}).limit(1)
/*
[
  {
    listing_url: 'https://www.airbnb.com/rooms/1455804',
    name: 'One Bedroom Apt Near Central Park',
    host_name: 'Abigail'
  }
]
*/

// 4. choose three of the host names, and show all of the listings hosted by any of the three hosts
// only show the name of the listing, its price, the neighbourhood that it's located in (use neighborhood_cleansed), and the host's name
// sort by the host's name
db.listings.find({ host_name: { $in: ['Aaliya', 'Ace', 'Addie'] }}, { name: 1, host_name: 1, neighbourhood_cleansed: 1, price: 1,
   _id: 0}).sort({host_name: 1})
/*
[
  {
    name: 'Spontaneous 1 Bdr apartment in Luxury building .',
    host_name: 'Aaliya',
    neighbourhood_cleansed: 'Long Island City',
    price: '$300.00'
  },
  {
    name: 'Cozy Brooklyn Apartment',
    host_name: 'Ace',
*/

// 5. what are the top 10 (by review scores) that have at least two bedrooms (not just beds) in the borough of Brooklyn? …find all
// of the places that have two or more bedrooms (>= 2) in the borough (referred to as neighbourhood_group_cleansed file) of
// Brooklyn, ordered by review_scores_rating descending
// only show the listing name, number of bedrooms, neighbourhood (neighbourhood_cleansed) and price
db.listings.find({ bedrooms: {$gte:2}, neighbourhood_group_cleansed: 'Brooklyn' , review_scores_rating: {$ne: ''}}, { name: 1, neighbourhood_cleansed: 1, bedrooms: 1,
  price: 1, _id: 0 }).sort({review_scores_rating: -1})
/*
[
  {
    name: 'Spacious Brooklyn Duplex, Patio + Garden',
    neighbourhood_cleansed: 'Sunset Park',
    bedrooms: 2,
    price: '$275.00'
  },
  {
    name: 'Luxe, Spacious 2BR 2BA Nr Trains',
    neighbourhood_cleansed: 'Gowanus',
    bedrooms: 2,
    price: '$260.00'
  },
*/

// 6. show the number of listings per host (you can assume that the string value of host_name is adequate for the grouping,
// even if it's unclear whether or not host_name is unique across hosts)
// name the field that contains the count, listingsCount
//use the $group stage with {$sum: 1} to count rows rather than using a $count stage
db.listings.aggregate({$group: {_id: "$host_name", listingCount: {$sum: 1}}})
/*
[
  { _id: 'Ahmed', listingCount: 18 },
  { _id: 'Nikali', listingCount: 1 },
  { _id: 'Manisha', listingCount: 1 },
  { _id: 'Marcel', listingCount: 2 },
  { _id: 'Federica', listingCount: 2 },
  { _id: 'Alida', listingCount: 3 },
  { _id: 'Akeel', listingCount: 1 },
  { _id: 'Mai Huong', listingCount: 2 },
  { _id: 'Natalli', listingCount: 1 },
  { _id: 'Helene', listingCount: 2 },
*/

// 7. show the number of listings per host sorted in order of listings descending, with the field name containing host displayed
// as host rather than _id (hint: in a projection, suppress_id and rename _id)
var countByHost = {$group: {_id: "$host_name", listingCount: {$sum: 1}}};
var orderByListings = {$sort: {listingCount: -1}};
var renameHost = { $project: { listingCount: 1, _id: 0, host: "$_id", count: 1, sum: 1} };
db.listings.aggregate([countByHost, orderByListings, renameHost]);
/*
[
  { listingCount: 400, host: 'June' },
  { listingCount: 311, host: 'Michael' },
  { listingCount: 304, host: 'Blueground' },
  { listingCount: 251, host: 'Karen' },
  { listingCount: 238, host: 'David' },
  { listingCount: 222, host: 'Jeniffer' },
  { listingCount: 210, host: 'Alex' },
  { listingCount: 178, host: 'Daniel' },
  { listingCount: 175, host: 'John' },
*/

// 8. show the bedroom to bed ratio (aliased as bedroomBedRatio) for all listings in the borough (neighbourhood_group_cleansed)
// Brooklyn
// only calculate this for listings that have at least 1 bed and at least 1 bedroom (and are in Brooklyn)
// use divide
// only show the number of bedrooms, number of beds, the name of the listing, neighborhood (neighbourhood_cleansed), and the
// bedroom to bed ratio
// order by neighbourhood (neighbourhood_cleansed) ascending
var findBrooklyn = {$match: {neighbourhood_group_cleansed: 'Brooklyn', bedrooms: {$gte: 1}, beds: {$gte: 1}}};
var getRatio = { $project: { _id: 0, name: 1, neighbourhood_cleansed: 1, bedrooms: 1, beds: 1, bedroomBedRatio: { $divide: [ "$bedrooms", "$beds" ] } } };
var orderByNeighbourhood = {$sort: {neighbourhood_cleansed: 1}};
db.listings.aggregate([findBrooklyn, getRatio, orderByNeighbourhood]);
/*
[
  {
    name: 'Brand New small 1 Bedroom apt in Brooklyn',
    neighbourhood_cleansed: 'Bath Beach',
    bedrooms: 1,
    beds: 1,
    bedroomBedRatio: 1
  },
  {
    name: 'Private Queen room&bathroom in NEW Luxury Building',
*/

// 9. using the previous query as a foundation, find the bedroom to bed ratio for each borough (neighbourhood_group_cleansed)
// using an aggregation
var noNulls = {$match: {bedrooms: {$gte: 1}, beds: {$gte: 1}}};
var getRatio = { $project: { _id: 0, neighbourhood_group_cleansed: 1, bedroomBedRatio: { $divide: [ "$bedrooms", "$beds" ] } } };
var groupBoroughs = { $group:{ _id: "$neighbourhood_group_cleansed", avgBedRatio: { $avg: "$bedroomBedRatio" }}};
db.listings.aggregate([noNulls, getRatio, groupBoroughs]);
/*
[
  { _id: 'Bronx', avgBedRatio: 0.8876594739329029 },
  { _id: 'Manhattan', avgBedRatio: 0.9020413600110374 },
  { _id: 'Staten Island', avgBedRatio: 0.83395660461987 },
  { _id: 'Brooklyn', avgBedRatio: 0.925893863719455 },
  { _id: 'Queens', avgBedRatio: 0.88898632498287 }
]
*/

// 10. in borough (again, use neighbourhood_group_cleansed), Manhattan, find the average review_scores_rating per
// neighbourhood_cleansed as well as the number of listings per neighbourhood_cleansed… only show the neighbourhoods that have
// more than 100 listings… sorted in descending order of rating
var findManhattan = {$match: {neighbourhood_group_cleansed: 'Manhattan'}};
var groupNeighbourhoods = { $group:{ _id: "$neighbourhood_cleansed", avgRating: { $avg: "$review_scores_rating" }, countListings: {$sum: 1}}};
var over100 = {$match: {countListings: {$gt: 100}}};
var orderByRating = {$sort: {avgRating: -1}};
db.listings.aggregate([findManhattan, groupNeighbourhoods, over100, orderByRating]);
/*
[
  {
    _id: 'West Village',
    avgRating: 4.700544554455446,
    countListings: 520
  },
  { _id: 'Nolita', avgRating: 4.694313725490196, countListings: 212 },
  {
    _id: 'Gramercy',
    avgRating: 4.6808771929824555,
*/
