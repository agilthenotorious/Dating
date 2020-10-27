//
//  ApiResponse.swift
//  Dating
//
//  Created by Agil Madinali on 10/24/20.
//

// swiftlint:disable identifier_name

// MARK: - Welcome
struct ApiResponse: Codable {
    let results: [Person]
    let info: Info
}

// MARK: - Info
struct Info: Codable {
    let seed: String
    let results, page: Int
    let version: String
}

// MARK: - Result
struct Person: Codable {
    
    let name: NameClass
    let dob: Dob
    let location: Location
    let picture: Picture
    let gender: Gender
    let email: String
    let login: Login
    let registered: Dob
    let phone, cell: String
    let id: Identifier
    let nat: Nat
    
    var fullName: String {
        return name.first + " " + name.last
    }
    
    var age: String {
        return String(dob.age)
    }
}

// MARK: - Dob
struct Dob: Codable {
    let date: String
    let age: Int
}

enum Gender: String, Codable {
    case female
    case male
}

// MARK: - ID
struct Identifier: Codable {
    let name: NameEnum
    let value: String?
}

enum NameEnum: String, Codable {
    case avs = "AVS"
    case bsn = "BSN"
    case cpr = "CPR"
    case dni = "DNI"
    case empty = ""
    case fn = "FN"
    case hetu = "HETU"
    case insee = "INSEE"
    case nino = "NINO"
    case pps = "PPS"
    case ssn = "SSN"
    case tfn = "TFN"
}

// MARK: - Location
struct Location: Codable {
    let street: Street
    let city, state: String
    let country: Country
    let postcode: Postcode
    let coordinates: Coordinates
    let timezone: Timezone
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: String
}

enum Country: String, Codable {
    case australia = "Australia"
    case brazil = "Brazil"
    case canada = "Canada"
    case denmark = "Denmark"
    case finland = "Finland"
    case france = "France"
    case germany = "Germany"
    case iran = "Iran"
    case ireland = "Ireland"
    case netherlands = "Netherlands"
    case newZealand = "New Zealand"
    case norway = "Norway"
    case spain = "Spain"
    case switzerland = "Switzerland"
    case turkey = "Turkey"
    case unitedKingdom = "United Kingdom"
    case unitedStates = "United States"
}

enum Postcode: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Postcode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
            
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Street
struct Street: Codable {
    let number: Int
    let name: String
}

// MARK: - Timezone
struct Timezone: Codable {
    let offset: Offset
    let timezoneDescription: Description

    enum CodingKeys: String, CodingKey {
        case offset
        case timezoneDescription = "description"
    }
}

enum Offset: String, Codable {
    case offset100 = "+1:00"
    case offset1000 = "+10:00"
    case offset1100 = "-11:00"
    case offset200 = "+2:00"
    case offset300 = "-3:00"
    case offset330 = "-3:30"
    case offset400 = "+4:00"
    case offset500 = "+5:00"
    case offset600 = "-6:00"
    case offset700 = "+7:00"
    case offset800 = "+8:00"
    case offset900 = "-9:00"
    case the000 = "0:00"
    case the100 = "-1:00"
    case the1000 = "-10:00"
    case the1100 = "+11:00"
    case the1200 = "-12:00"
    case the200 = "-2:00"
    case the300 = "+3:00"
    case the330 = "+3:30"
    case the400 = "-4:00"
    case the430 = "+4:30"
    case the500 = "-5:00"
    case the530 = "+5:30"
    case the545 = "+5:45"
    case the600 = "+6:00"
    case the700 = "-7:00"
    case the800 = "-8:00"
    case the900 = "+9:00"
    case the930 = "+9:30"
}

enum Description: String, Codable {
    case abuDhabiMuscatBakuTbilisi = "Abu Dhabi, Muscat, Baku, Tbilisi"
    case adelaideDarwin = "Adelaide, Darwin"
    case alaska = "Alaska"
    case almatyDhakaColombo = "Almaty, Dhaka, Colombo"
    case atlanticTimeCanadaCaracasLaPaz = "Atlantic Time (Canada), Caracas, La Paz"
    case azoresCapeVerdeIslands = "Azores, Cape Verde Islands"
    case baghdadRiyadhMoscowStPetersburg = "Baghdad, Riyadh, Moscow, St. Petersburg"
    case bangkokHanoiJakarta = "Bangkok, Hanoi, Jakarta"
    case beijingPerthSingaporeHongKong = "Beijing, Perth, Singapore, Hong Kong"
    case bombayCalcuttaMadrasNewDelhi = "Bombay, Calcutta, Madras, New Delhi"
    case brazilBuenosAiresGeorgetown = "Brazil, Buenos Aires, Georgetown"
    case brusselsCopenhagenMadridParis = "Brussels, Copenhagen, Madrid, Paris"
    case centralTimeUSCanadaMexicoCity = "Central Time (US & Canada), Mexico City"
    case easternAustraliaGuamVladivostok = "Eastern Australia, Guam, Vladivostok"
    case easternTimeUSCanadaBogotaLima = "Eastern Time (US & Canada), Bogota, Lima"
    case ekaterinburgIslamabadKarachiTashkent = "Ekaterinburg, Islamabad, Karachi, Tashkent"
    case eniwetokKwajalein = "Eniwetok, Kwajalein"
    case hawaii = "Hawaii"
    case kabul = "Kabul"
    case kaliningradSouthAfrica = "Kaliningrad, South Africa"
    case kathmandu = "Kathmandu"
    case magadanSolomonIslandsNewCaledonia = "Magadan, Solomon Islands, New Caledonia"
    case midAtlantic = "Mid-Atlantic"
    case midwayIslandSamoa = "Midway Island, Samoa"
    case mountainTimeUSCanada = "Mountain Time (US & Canada)"
    case newfoundland = "Newfoundland"
    case pacificTimeUSCanada = "Pacific Time (US & Canada)"
    case tehran = "Tehran"
    case tokyoSeoulOsakaSapporoYakutsk = "Tokyo, Seoul, Osaka, Sapporo, Yakutsk"
    case westernEuropeTimeLondonLisbonCasablanca = "Western Europe Time, London, Lisbon, Casablanca"
}

// MARK: - Login
struct Login: Codable {
    let uuid, username, password, salt: String
    let md5, sha1, sha256: String
}

// MARK: - NameClass
struct NameClass: Codable {
    let title: Title
    let first, last: String
}

enum Title: String, Codable {
    case madame = "Madame"
    case mademoiselle = "Mademoiselle"
    case miss = "Miss"
    case monsieur = "Monsieur"
    case mr = "Mr"
    case mrs = "Mrs"
    case ms = "Ms"
}

enum Nat: String, Codable {
    case au = "AU"
    case br = "BR"
    case ca = "CA"
    case ch = "CH"
    case de = "DE"
    case dk = "DK"
    case es = "ES"
    case fi = "FI"
    case fr = "FR"
    case gb = "GB"
    case ie = "IE"
    case ir = "IR"
    case nl = "NL"
    case no = "NO"
    case nz = "NZ"
    case tr = "TR"
    case us = "US"
}

// MARK: - Picture
struct Picture: Codable {
    let large, medium, thumbnail: String
}
