//
//  CoinModel.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 7.08.2023.
//

import Foundation

//URLhttps://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=true&price_change_percentage=24&locale=en
/*{
 "id":"bitcoin",
 "symbol":"btc",
 "name":"Bitcoin",
 "image":"https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
 "current_price":29017,
 "market_cap":564465768217,
 "market_cap_rank":1,
 "fully_diluted_valuation":609435396704,
 "total_volume":6526139407,
 "high_24h":29174,
 "low_24h":28973,
 "price_change_24h":-44.68877153140784,
 "price_change_percentage_24h":-0.15377,
 "market_cap_change_24h":-785974918.1802979,
 "market_cap_change_percentage_24h":-0.13905,
 "circulating_supply":19450431.0,
 "total_supply":21000000.0,
 "max_supply":21000000.0,
 "ath":69045,
 "ath_change_percentage":-57.95142,
 "ath_date":"2021-11-10T14:24:11.849Z",
 "atl":67.81,
 "atl_change_percentage":42714.8831,
 "atl_date":"2013-07-06T00:00:00.000Z",
 "roi":null,
 "last_updated":"2023-08-07T08:14:49.847Z",
 "sparkline_in_7d":{
    "price":[
       29381.999704403723,
       29401.478326800752,
       29379.291090327082,
       29385.90384828296,
       29370.640322724914,
       29371.859549109304,
       29389.802582833345,
       29449.090796832406,
       29351.411076211785,
       29301.70086480563,
       29250.006595240662,
       29244.84298676968,
       29217.38857006191,
       29197.54498742039,
       29220.005552322902,
       29217.05529059147,
       29239.485487664628,
       29208.638675444134,
       29225.78903990318,
       29283.257482890982,
       29196.40491920269,
       28933.589441398828,
       28836.362892634166,
       28859.850682516564,
       28902.83342032919,
       28923.047091180444,
       28922.768533406037,
       28950.689444814736,
       28926.692827318147,
       28914.78045754031,
       28876.0727583824,
       28873.94607766258,
       28878.68936584147,
       28811.350317624612,
       28893.17367623834,
       28904.107217880563,
       28932.211442017186,
       29162.211547116116,
       29257.225510262706,
       29220.838459786457,
       29190.624191620474,
       29199.152902607395,
       29694.16407843016,
       29772.298033304203,
       29874.280259270647,
       29824.984567470103,
       29613.437605238618,
       29654.778753257848,
       29632.470425628384,
       29545.913925908368,
       29569.174025467262,
       29501.940471874925,
       29434.31115633385,
       29513.004986158994,
       29530.810078113485,
       29479.24769486682,
       29377.98215801388,
       29287.230691691137,
       29316.111424627186,
       29063.914917151054,
       29119.789760388983,
       29113.959599852966,
       29163.6056046116,
       29124.141962846934,
       29173.77285335628,
       29179.087553123605,
       29153.01856112717,
       29169.734169773696,
       29216.64831869119,
       29158.702469495594,
       29166.053952967355,
       29122.06898772666,
       29120.23455864203,
       29082.237421463007,
       29010.543624142705,
       29062.278491352583,
       29115.370727426594,
       29156.419326711177,
       29107.671411490628,
       29068.72166655228,
       29166.28864445906,
       29362.22553327804,
       29232.176838879168,
       29287.205910225486,
       29215.037695810468,
       29245.262235366434,
       29258.097801696906,
       29289.158250324508,
       29228.811308779783,
       29220.722581707367,
       29172.607611740656,
       29185.574650803876,
       29181.163835515374,
       29158.337399031203,
       29137.03146339251,
       29146.82862350783,
       29218.412777883786,
       29162.440886609107,
       29162.872558628256,
       29155.971784390895,
       29170.958722116637,
       29140.928265326016,
       29150.25348478847,
       29211.16828963717,
       29220.587305520527,
       29228.354689887525,
       29255.678710525015,
       29233.862484554462,
       29183.67675299467,
       29006.38624309287,
       28994.495952653848,
       28942.92963349416,
       28996.862034751746,
       29031.83583532943,
       29080.301697276253,
       29084.13576958708,
       29036.497614644624,
       29046.942867196485,
       29052.63432879074,
       29003.612343742927,
       29044.975003576103,
       29022.019920681818,
       29012.49297178697,
       29033.155958406318,
       29021.640506440064,
       29017.11477580366,
       29011.88596931511,
       28975.30565274574,
       28989.54054090778,
       29037.450025275615,
       29012.99467622015,
       28999.881653309407,
       29029.779904664032,
       29041.885346364976,
       29036.34608849958,
       29032.53883362787,
       29043.013151782663,
       29056.16176947457,
       29046.800457023197,
       29035.694244417697,
       29019.350569450282,
       29036.84640475083,
       29028.030848530874,
       29043.307262735263,
       29062.06456952791,
       29022.50897002412,
       29058.8616045681,
       29083.604181543047,
       29046.521681920247,
       29018.877011522873,
       29031.818954761657,
       28989.885944889065,
       28989.31038180553,
       28987.226434775825,
       28978.415398708043,
       29022.360916022473,
       29049.80512740881,
       29049.411060168142,
       29044.47746048231,
       29045.277701984312,
       29038.83450939426,
       29047.04871719228,
       29044.204375577556,
       29003.687203096728,
       29094.937755851966,
       29164.21191891594,
       29106.42473929819,
       29138.026317681506
    ]
 }
}*/
struct CoinModel: Identifiable, Codable {
    let id, symbol, name: String?
    let image: String?
    let current_price: Double
    let market_cap, market_cap_rank: Double?
    let fully_diluted_valuation, total_volume: Double?
    let high_24h: Double?
    let low_24h: Double?
    let price_change_24h: Double?
    let price_change_percentage_24h: Double?
    let market_cap_change_24h: Double?
    let market_cap_change_percentage_24h: Double?
    let circulating_supply: Double?
    let total_supply: Double?
    let max_supply: Double?
    let ath: Double?
    let ath_change_percentage: Double?
    let ath_date: String?
    let atl: Double?
    let atl_change_percentage: Double?
    let atl_date: String?
    let last_updated: String?
    let sparkline_in_7d: SparklineIn7D?
    
//    enum CodingKeys: String, CodingKey {
//        case id, symbol, name, image
//        case currentPrice = "current_price"
//        case marketCap = "market_cap"
//        case marketCapRank = "market_cap_rank"
//        case fullyDilutedValuation = "fully_diluted_valuation"
//        case totalVolume = "total_volume"
//        case high24H = "high_24h"
//        case low24H = "low_24h"
//        case priceChange24H = "price_change_24h"
//        case priceChangePercentage24H = "price_change_percentage_24h"
//        case marketCapChange24H = "market_cap_change_24h"
//        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
//        case circulatingSupply = "circulating_supply"
//        case totalSupply = "total_supply"
//        case maxSupply = "max_supply"
//        case ath = "ath"
//        case athChangePercentage = "ath_change_percentage"
//        case athDate = "ath_date"
//        case atl = "atl"
//        case atlChangePercentage = "atl_change_percentage"
//        case atlDate = "atl_date"
//        case lastUpdated = "last_updated"
//        case sparklineIn7D = "sparkline_in_7d" // Düzeltildi
//    }
}

struct SparklineIn7D: Codable {
    var price: [Double]?
}

struct CoinResult: Codable {
    var coinResult: [CoinModel]?
}

