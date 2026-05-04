//
//  SubscriptionsRepositoryImpl.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 21.04.2026.
//

import Foundation

protocol SubscriptionsRepository {
    func fetchAvailableSubscriptions() -> [Subscription]
    func fetchGroupedSubscriptions() -> [SubscriptionSection]

    func fetchAll() throws(DatabaseError) -> [Subscription]
    func add(subscription: Subscription, id: UUID) throws(DatabaseError)
    func update(id: UUID, with subscription: Subscription) throws(DatabaseError)
    func delete(id: UUID) throws(DatabaseError)
}

@Observable
final class SubscriptionsRepositoryImpl: SubscriptionsRepository {
    private let database: DatabaseServiceImpl<UserSubscription>

    init() throws(DatabaseError) {
        database = try DatabaseServiceImpl<UserSubscription>()
    }
    
    func fetchAvailableSubscriptions() -> [Subscription] {
        [
            Subscription(id: UUID(), identifier: .chatGPTPlus, group: .ai, name: "ChatGPT Plus", cost: 20.00, currency: .usd),
            Subscription(id: UUID(), identifier: .claudePro, group: .ai, name: "Claude Pro", cost: 20.00, currency: .usd),
            Subscription(id: UUID(), identifier: .cursorPro, group: .ai, name: "Cursor Pro", cost: 20.00, currency: .usd),
            Subscription(id: UUID(), identifier: .elevenLabs, group: .ai, name: "ElevenLabs", cost: 5.00, currency: .usd),
            Subscription(id: UUID(), identifier: .geminiAdvanced, group: .ai, name: "Gemini Advanced", cost: 19.99, currency: .usd),
            Subscription(id: UUID(), identifier: .ideogram, group: .ai, name: "Ideogram", cost: 8.00, currency: .usd),
            Subscription(id: UUID(), identifier: .jasper, group: .ai, name: "Jasper", cost: 39.00, currency: .usd),
            Subscription(id: UUID(), identifier: .leonardoAI, group: .ai, name: "Leonardo AI", cost: 10.00, currency: .usd),
            Subscription(id: UUID(), identifier: .microsoftCopilotPro, group: .ai, name: "Microsoft Copilot Pro", cost: 20.00, currency: .usd),
            Subscription(id: UUID(), identifier: .midjourney, group: .ai, name: "Midjourney", cost: 10.00, currency: .usd),
            Subscription(id: UUID(), identifier: .perplexityPro, group: .ai, name: "Perplexity Pro", cost: 20.00, currency: .usd),
            Subscription(id: UUID(), identifier: .poe, group: .ai, name: "Poe", cost: 19.99, currency: .usd),
            Subscription(id: UUID(), identifier: .runway, group: .ai, name: "Runway", cost: 12.00, currency: .usd),
            Subscription(id: UUID(), identifier: .sunoPro, group: .ai, name: "Suno Pro", cost: 8.00, currency: .usd),
            Subscription(id: UUID(), identifier: .superhuman, group: .ai, name: "Superhuman", cost: 30.00, currency: .usd),
            Subscription(id: UUID(), identifier: .synthesia, group: .ai, name: "Synthesia", cost: 22.00, currency: .usd),

            Subscription(id: UUID(), identifier: .appleArcade, group: .appleServices, name: "Apple Arcade", cost: 6.99, currency: .usd),
            Subscription(id: UUID(), identifier: .appleDeveloperProgram, group: .appleServices, name: "Apple Developer Program", cost: 99.00, currency: .usd, paymentCycle: .yearly),
            Subscription(id: UUID(), identifier: .appleFitnessPlus, group: .appleServices, name: "Apple Fitness+", cost: 9.99, currency: .usd),
            Subscription(id: UUID(), identifier: .appleMusic, group: .appleServices, name: "Apple Music", cost: 10.99, currency: .usd),
            Subscription(id: UUID(), identifier: .appleNewsPlus, group: .appleServices, name: "Apple News+", cost: 12.99, currency: .usd),
            Subscription(id: UUID(), identifier: .appleOne, group: .appleServices, name: "Apple One", cost: 19.95, currency: .usd),
            Subscription(id: UUID(), identifier: .appleTVPlus, group: .appleServices, name: "Apple TV+", cost: 9.99, currency: .usd),
            Subscription(id: UUID(), identifier: .appleCare, group: .appleServices, name: "AppleCare+", cost: 9.99, currency: .usd),
            Subscription(id: UUID(), identifier: .iCloudPlus, group: .appleServices, name: "iCloud+", cost: 0.99, currency: .usd),
            Subscription(id: UUID(), identifier: .iTunesMatch, group: .appleServices, name: "iTunes Match", cost: 24.99, currency: .usd, paymentCycle: .yearly),

            Subscription(id: UUID(), identifier: .audible, group: .audio, name: "Audible", cost: 14.95, currency: .usd),

            Subscription(id: UUID(), identifier: .linkedInPremium, group: .career, name: "LinkedIn Premium", cost: 39.99, currency: .usd),

            Subscription(id: UUID(), identifier: .box, group: .cloud, name: "Box", cost: 10.00, currency: .usd),
            Subscription(id: UUID(), identifier: .dropbox, group: .cloud, name: "Dropbox", cost: 9.99, currency: .usd),
            Subscription(id: UUID(), identifier: .googleOne, group: .cloud, name: "Google One", cost: 1.99, currency: .usd),
            Subscription(id: UUID(), identifier: .mega, group: .cloud, name: "MEGA", cost: 4.99, currency: .usd),
            Subscription(id: UUID(), identifier: .oneDrive, group: .cloud, name: "OneDrive", cost: 1.99, currency: .usd),
            Subscription(id: UUID(), identifier: .pCloud, group: .cloud, name: "pCloud", cost: 3.99, currency: .usd),
            Subscription(id: UUID(), identifier: .protonDrive, group: .cloud, name: "Proton Drive", cost: 3.99, currency: .usd),

            Subscription(id: UUID(), identifier: .discordNitro, group: .communication, name: "Discord Nitro", cost: 9.99, currency: .usd),
            Subscription(id: UUID(), identifier: .slackPro, group: .communication, name: "Slack Pro", cost: 7.25, currency: .usd),
            Subscription(id: UUID(), identifier: .telegramPremium, group: .communication, name: "Telegram Premium", cost: 4.99, currency: .usd),
            Subscription(id: UUID(), identifier: .zoomPro, group: .communication, name: "Zoom Pro", cost: 13.33, currency: .usd),

            Subscription(id: UUID(), identifier: .patreon, group: .creator, name: "Patreon", cost: 5.00, currency: .usd),

            Subscription(id: UUID(), identifier: .woltPlus, group: .delivery, name: "Wolt+", cost: 9.99, currency: .usd),

            Subscription(id: UUID(), identifier: .adobeCreativeCloud, group: .design, name: "Adobe Creative Cloud", cost: 54.99, currency: .usd),
            Subscription(id: UUID(), identifier: .canvaPro, group: .design, name: "Canva Pro", cost: 12.99, currency: .usd),
            Subscription(id: UUID(), identifier: .figma, group: .design, name: "Figma", cost: 12.00, currency: .usd),

            Subscription(id: UUID(), identifier: .digitalOcean, group: .developerTools, name: "DigitalOcean", cost: 6.00, currency: .usd),
            Subscription(id: UUID(), identifier: .gitHubCopilot, group: .developerTools, name: "GitHub Copilot", cost: 10.00, currency: .usd),
            Subscription(id: UUID(), identifier: .gitLabPremium, group: .developerTools, name: "GitLab Premium", cost: 19.00, currency: .usd),
            Subscription(id: UUID(), identifier: .heroku, group: .developerTools, name: "Heroku", cost: 5.00, currency: .usd),
            Subscription(id: UUID(), identifier: .jetBrainsAllProducts, group: .developerTools, name: "JetBrains All Products", cost: 24.90, currency: .usd),
            Subscription(id: UUID(), identifier: .linear, group: .developerTools, name: "Linear", cost: 8.00, currency: .usd),
            Subscription(id: UUID(), identifier: .mongoDBAtlas, group: .developerTools, name: "MongoDB Atlas", cost: 9.00, currency: .usd),
            Subscription(id: UUID(), identifier: .replitCore, group: .developerTools, name: "Replit Core", cost: 15.00, currency: .usd),
            Subscription(id: UUID(), identifier: .vercelPro, group: .developerTools, name: "Vercel Pro", cost: 20.00, currency: .usd),

            Subscription(id: UUID(), identifier: .babbel, group: .education, name: "Babbel", cost: 6.95, currency: .usd),
            Subscription(id: UUID(), identifier: .brilliant, group: .education, name: "Brilliant", cost: 24.99, currency: .usd),
            Subscription(id: UUID(), identifier: .codecademyPro, group: .education, name: "Codecademy Pro", cost: 17.49, currency: .usd),
            Subscription(id: UUID(), identifier: .courseraPlus, group: .education, name: "Coursera Plus", cost: 59.00, currency: .usd),
            Subscription(id: UUID(), identifier: .duolingoSuper, group: .education, name: "Duolingo Super", cost: 6.99, currency: .usd),
            Subscription(id: UUID(), identifier: .masterClass, group: .education, name: "MasterClass", cost: 10.00, currency: .usd),
            Subscription(id: UUID(), identifier: .skillshare, group: .education, name: "Skillshare", cost: 9.99, currency: .usd),

            Subscription(id: UUID(), identifier: .revolutPremium, group: .finance, name: "Revolut Premium", cost: 9.99, currency: .usd),
            Subscription(id: UUID(), identifier: .tradingViewEssential, group: .finance, name: "TradingView Essential", cost: 14.95, currency: .usd),
            Subscription(id: UUID(), identifier: .ynab, group: .finance, name: "YNAB", cost: 14.99, currency: .usd),

            Subscription(id: UUID(), identifier: .fitbod, group: .fitness, name: "Fitbod", cost: 12.99, currency: .usd),
            Subscription(id: UUID(), identifier: .myFitnessPalPremium, group: .fitness, name: "MyFitnessPal Premium", cost: 9.99, currency: .usd),
            Subscription(id: UUID(), identifier: .peloton, group: .fitness, name: "Peloton", cost: 12.99, currency: .usd),
            Subscription(id: UUID(), identifier: .strava, group: .fitness, name: "Strava", cost: 11.99, currency: .usd),

            Subscription(id: UUID(), identifier: .eaPlay, group: .gaming, name: "EA Play", cost: 4.99, currency: .usd),
            Subscription(id: UUID(), identifier: .nintendoSwitchOnline, group: .gaming, name: "Nintendo Switch Online", cost: 3.99, currency: .usd),
            Subscription(id: UUID(), identifier: .playStationPlus, group: .gaming, name: "PlayStation Plus", cost: 9.99, currency: .usd),
            Subscription(id: UUID(), identifier: .ubisoftPlus, group: .gaming, name: "Ubisoft+", cost: 17.99, currency: .usd),
            Subscription(id: UUID(), identifier: .xboxGamePass, group: .gaming, name: "Xbox Game Pass", cost: 14.99, currency: .usd),

            Subscription(id: UUID(), identifier: .boltPlus, group: .mobility, name: "Bolt Plus", cost: 9.99, currency: .usd),
            Subscription(id: UUID(), identifier: .uberOne, group: .mobility, name: "Uber One", cost: 9.99, currency: .usd),

            Subscription(id: UUID(), identifier: .deezer, group: .music, name: "Deezer", cost: 10.99, currency: .usd),
            Subscription(id: UUID(), identifier: .soundCloudGoPlus, group: .music, name: "SoundCloud Go+", cost: 9.99, currency: .usd),
            Subscription(id: UUID(), identifier: .spotify, group: .music, name: "Spotify", cost: 10.99, currency: .usd),
            Subscription(id: UUID(), identifier: .tidal, group: .music, name: "TIDAL", cost: 10.99, currency: .usd),
            Subscription(id: UUID(), identifier: .youTubeMusic, group: .music, name: "YouTube Music", cost: 10.99, currency: .usd),

            Subscription(id: UUID(), identifier: .substack, group: .news, name: "Substack", cost: 5.00, currency: .usd),
            Subscription(id: UUID(), identifier: .theAthletic, group: .news, name: "The Athletic", cost: 7.99, currency: .usd),
            Subscription(id: UUID(), identifier: .theNewYorkTimes, group: .news, name: "The New York Times", cost: 4.00, currency: .usd),
            Subscription(id: UUID(), identifier: .theWallStreetJournal, group: .news, name: "The Wall Street Journal", cost: 9.99, currency: .usd),

            Subscription(id: UUID(), identifier: .evernote, group: .productivity, name: "Evernote", cost: 14.99, currency: .usd),
            Subscription(id: UUID(), identifier: .microsoft365, group: .productivity, name: "Microsoft 365", cost: 6.99, currency: .usd),
            Subscription(id: UUID(), identifier: .notion, group: .productivity, name: "Notion", cost: 8.00, currency: .usd),
            Subscription(id: UUID(), identifier: .obsidianSync, group: .productivity, name: "Obsidian Sync", cost: 4.00, currency: .usd),
            Subscription(id: UUID(), identifier: .raycastPro, group: .productivity, name: "Raycast Pro", cost: 8.00, currency: .usd),
            Subscription(id: UUID(), identifier: .readwise, group: .productivity, name: "Readwise", cost: 7.99, currency: .usd),
            Subscription(id: UUID(), identifier: .todoist, group: .productivity, name: "Todoist", cost: 4.00, currency: .usd),

            Subscription(id: UUID(), identifier: .kindleUnlimited, group: .reading, name: "Kindle Unlimited", cost: 11.99, currency: .usd),

            Subscription(id: UUID(), identifier: .onePassword, group: .security, name: "1Password", cost: 2.99, currency: .usd),
            Subscription(id: UUID(), identifier: .bitwardenPremium, group: .security, name: "Bitwarden Premium", cost: 10.00, currency: .usd, paymentCycle: .yearly),
            Subscription(id: UUID(), identifier: .dashlane, group: .security, name: "Dashlane", cost: 4.99, currency: .usd),
            Subscription(id: UUID(), identifier: .expressVPN, group: .security, name: "ExpressVPN", cost: 8.32, currency: .usd),
            Subscription(id: UUID(), identifier: .nordVPN, group: .security, name: "NordVPN", cost: 3.79, currency: .usd),
            Subscription(id: UUID(), identifier: .protonMailPlus, group: .security, name: "Proton Mail Plus", cost: 3.99, currency: .usd),
            Subscription(id: UUID(), identifier: .protonPass, group: .security, name: "Proton Pass", cost: 1.99, currency: .usd),
            Subscription(id: UUID(), identifier: .surfshark, group: .security, name: "Surfshark", cost: 2.49, currency: .usd),

            Subscription(id: UUID(), identifier: .amazonPrime, group: .shopping, name: "Amazon Prime", cost: 14.99, currency: .usd),

            Subscription(id: UUID(), identifier: .xPremium, group: .social, name: "X Premium", cost: 8.00, currency: .usd),

            Subscription(id: UUID(), identifier: .crunchyroll, group: .streaming, name: "Crunchyroll", cost: 7.99, currency: .usd),
            Subscription(id: UUID(), identifier: .disneyPlus, group: .streaming, name: "Disney+", cost: 7.99, currency: .usd),
            Subscription(id: UUID(), identifier: .hboMax, group: .streaming, name: "HBO Max", cost: 9.99, currency: .usd),
            Subscription(id: UUID(), identifier: .hulu, group: .streaming, name: "Hulu", cost: 7.99, currency: .usd),
            Subscription(id: UUID(), identifier: .mubi, group: .streaming, name: "MUBI", cost: 12.99, currency: .usd),
            Subscription(id: UUID(), identifier: .netflix, group: .streaming, name: "Netflix", cost: 15.49, currency: .usd),
            Subscription(id: UUID(), identifier: .paramountPlus, group: .streaming, name: "Paramount+", cost: 5.99, currency: .usd),
            Subscription(id: UUID(), identifier: .primeVideo, group: .streaming, name: "Prime Video", cost: 8.99, currency: .usd),
            Subscription(id: UUID(), identifier: .twitchTurbo, group: .streaming, name: "Twitch Turbo", cost: 8.99, currency: .usd),

            Subscription(id: UUID(), identifier: .setapp, group: .utilities, name: "Setapp", cost: 9.99, currency: .usd),

            Subscription(id: UUID(), identifier: .youTubePremium, group: .video, name: "YouTube Premium", cost: 13.99, currency: .usd),

            Subscription(id: UUID(), identifier: .calm, group: .wellness, name: "Calm", cost: 14.99, currency: .usd),
            Subscription(id: UUID(), identifier: .headspace, group: .wellness, name: "Headspace", cost: 12.99, currency: .usd),
            Subscription(id: UUID(), identifier: .noom, group: .wellness, name: "Noom", cost: 60.00, currency: .usd),

            Subscription(id: UUID(), identifier: .grammarly, group: .writing, name: "Grammarly", cost: 12.00, currency: .usd),
            Subscription(id: UUID(), identifier: .mediumMember, group: .writing, name: "Medium Member", cost: 5.00, currency: .usd),
        ]
    }

    func fetchGroupedSubscriptions() -> [SubscriptionSection] {
        let grouped = Dictionary(grouping: fetchAvailableSubscriptions(), by: \.group)
        return SubscriptionGroup.allCases.compactMap { group in
            guard let subscriptions = grouped[group] else { return nil }
            return SubscriptionSection(group: group, subscriptions: subscriptions)
        }
    }
    
    func fetchAll() throws(DatabaseError) -> [Subscription] {
        try database.fetchAll()
    }

    func add(subscription: Subscription, id: UUID) throws(DatabaseError) {
        try database.create(from: subscription, id: id)
    }

    func update(id: UUID, with subscription: Subscription) throws(DatabaseError) {
        try database.update(id: id, with: subscription)
    }

    func delete(id: UUID) throws(DatabaseError) {
        try database.delete(id: id)
    }
}
