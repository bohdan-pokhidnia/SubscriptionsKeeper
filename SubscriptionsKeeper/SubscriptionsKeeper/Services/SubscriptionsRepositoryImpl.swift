//
//  SubscriptionsRepositoryImpl.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 21.04.2026.
//

protocol SubscriptionsRepository {
    func fetchAvailableSubscriptions() -> [Subscription]
}

final class SubscriptionsRepositoryImpl: SubscriptionsRepository {
    func fetchAvailableSubscriptions() -> [Subscription] {
        [
            // AI
            Subscription(identifier: .chatGPTPlus, name: "ChatGPT Plus"),
            Subscription(identifier: .claudePro, name: "Claude Pro"),
            Subscription(identifier: .cursorPro, name: "Cursor Pro"),
            Subscription(identifier: .elevenLabs, name: "ElevenLabs"),
            Subscription(identifier: .geminiAdvanced, name: "Gemini Advanced"),
            Subscription(identifier: .ideogram, name: "Ideogram"),
            Subscription(identifier: .jasper, name: "Jasper"),
            Subscription(identifier: .leonardoAI, name: "Leonardo AI"),
            Subscription(identifier: .microsoftCopilotPro, name: "Microsoft Copilot Pro"),
            Subscription(identifier: .midjourney, name: "Midjourney"),
            Subscription(identifier: .perplexityPro, name: "Perplexity Pro"),
            Subscription(identifier: .poe, name: "Poe"),
            Subscription(identifier: .runway, name: "Runway"),
            Subscription(identifier: .sunoPro, name: "Suno Pro"),
            Subscription(identifier: .superhuman, name: "Superhuman"),
            Subscription(identifier: .synthesia, name: "Synthesia"),

            // Apple Services
            Subscription(identifier: .appleArcade, name: "Apple Arcade"),
            Subscription(identifier: .appleDeveloperProgram, name: "Apple Developer Program"),
            Subscription(identifier: .appleFitnessPlus, name: "Apple Fitness+"),
            Subscription(identifier: .appleMusic, name: "Apple Music"),
            Subscription(identifier: .appleNewsPlus, name: "Apple News+"),
            Subscription(identifier: .appleOne, name: "Apple One"),
            Subscription(identifier: .appleTVPlus, name: "Apple TV+"),
            Subscription(identifier: .appleCare, name: "AppleCare+"),
            Subscription(identifier: .iCloudPlus, name: "iCloud+"),
            Subscription(identifier: .iTunesMatch, name: "iTunes Match"),

            // Audio
            Subscription(identifier: .audible, name: "Audible"),

            // Career
            Subscription(identifier: .linkedInPremium, name: "LinkedIn Premium"),

            // Cloud
            Subscription(identifier: .box, name: "Box"),
            Subscription(identifier: .dropbox, name: "Dropbox"),
            Subscription(identifier: .googleOne, name: "Google One"),
            Subscription(identifier: .mega, name: "MEGA"),
            Subscription(identifier: .oneDrive, name: "OneDrive"),
            Subscription(identifier: .pCloud, name: "pCloud"),
            Subscription(identifier: .protonDrive, name: "Proton Drive"),

            // Communication
            Subscription(identifier: .discordNitro, name: "Discord Nitro"),
            Subscription(identifier: .slackPro, name: "Slack Pro"),
            Subscription(identifier: .telegramPremium, name: "Telegram Premium"),
            Subscription(identifier: .zoomPro, name: "Zoom Pro"),

            // Creator
            Subscription(identifier: .patreon, name: "Patreon"),

            // Delivery
            Subscription(identifier: .woltPlus, name: "Wolt+"),

            // Design
            Subscription(identifier: .adobeCreativeCloud, name: "Adobe Creative Cloud"),
            Subscription(identifier: .canvaPro, name: "Canva Pro"),
            Subscription(identifier: .figma, name: "Figma"),

            // Developer Tools
            Subscription(identifier: .digitalOcean, name: "DigitalOcean"),
            Subscription(identifier: .gitHubCopilot, name: "GitHub Copilot"),
            Subscription(identifier: .gitLabPremium, name: "GitLab Premium"),
            Subscription(identifier: .heroku, name: "Heroku"),
            Subscription(identifier: .jetBrainsAllProducts, name: "JetBrains All Products"),
            Subscription(identifier: .linear, name: "Linear"),
            Subscription(identifier: .mongoDBAtlas, name: "MongoDB Atlas"),
            Subscription(identifier: .replitCore, name: "Replit Core"),
            Subscription(identifier: .vercelPro, name: "Vercel Pro"),

            // Education
            Subscription(identifier: .babbel, name: "Babbel"),
            Subscription(identifier: .brilliant, name: "Brilliant"),
            Subscription(identifier: .codecademyPro, name: "Codecademy Pro"),
            Subscription(identifier: .courseraPlus, name: "Coursera Plus"),
            Subscription(identifier: .duolingoSuper, name: "Duolingo Super"),
            Subscription(identifier: .masterClass, name: "MasterClass"),
            Subscription(identifier: .skillshare, name: "Skillshare"),

            // Finance
            Subscription(identifier: .revolutPremium, name: "Revolut Premium"),
            Subscription(identifier: .tradingViewEssential, name: "TradingView Essential"),
            Subscription(identifier: .ynab, name: "YNAB"),

            // Fitness
            Subscription(identifier: .fitbod, name: "Fitbod"),
            Subscription(identifier: .myFitnessPalPremium, name: "MyFitnessPal Premium"),
            Subscription(identifier: .peloton, name: "Peloton"),
            Subscription(identifier: .strava, name: "Strava"),

            // Gaming
            Subscription(identifier: .eaPlay, name: "EA Play"),
            Subscription(identifier: .nintendoSwitchOnline, name: "Nintendo Switch Online"),
            Subscription(identifier: .playStationPlus, name: "PlayStation Plus"),
            Subscription(identifier: .ubisoftPlus, name: "Ubisoft+"),
            Subscription(identifier: .xboxGamePass, name: "Xbox Game Pass"),

            // Mobility
            Subscription(identifier: .boltPlus, name: "Bolt Plus"),
            Subscription(identifier: .uberOne, name: "Uber One"),

            // Music
            Subscription(identifier: .deezer, name: "Deezer"),
            Subscription(identifier: .soundCloudGoPlus, name: "SoundCloud Go+"),
            Subscription(identifier: .spotify, name: "Spotify"),
            Subscription(identifier: .tidal, name: "TIDAL"),
            Subscription(identifier: .youTubeMusic, name: "YouTube Music"),

            // News
            Subscription(identifier: .substack, name: "Substack"),
            Subscription(identifier: .theAthletic, name: "The Athletic"),
            Subscription(identifier: .theNewYorkTimes, name: "The New York Times"),
            Subscription(identifier: .theWallStreetJournal, name: "The Wall Street Journal"),

            // Productivity
            Subscription(identifier: .evernote, name: "Evernote"),
            Subscription(identifier: .microsoft365, name: "Microsoft 365"),
            Subscription(identifier: .notion, name: "Notion"),
            Subscription(identifier: .obsidianSync, name: "Obsidian Sync"),
            Subscription(identifier: .raycastPro, name: "Raycast Pro"),
            Subscription(identifier: .readwise, name: "Readwise"),
            Subscription(identifier: .todoist, name: "Todoist"),

            // Reading
            Subscription(identifier: .kindleUnlimited, name: "Kindle Unlimited"),

            // Security
            Subscription(identifier: .onePassword, name: "1Password"),
            Subscription(identifier: .bitwardenPremium, name: "Bitwarden Premium"),
            Subscription(identifier: .dashlane, name: "Dashlane"),
            Subscription(identifier: .expressVPN, name: "ExpressVPN"),
            Subscription(identifier: .nordVPN, name: "NordVPN"),
            Subscription(identifier: .protonMailPlus, name: "Proton Mail Plus"),
            Subscription(identifier: .protonPass, name: "Proton Pass"),
            Subscription(identifier: .surfshark, name: "Surfshark"),

            // Shopping
            Subscription(identifier: .amazonPrime, name: "Amazon Prime"),

            // Social
            Subscription(identifier: .xPremium, name: "X Premium"),

            // Streaming
            Subscription(identifier: .crunchyroll, name: "Crunchyroll"),
            Subscription(identifier: .disneyPlus, name: "Disney+"),
            Subscription(identifier: .hboMax, name: "HBO Max"),
            Subscription(identifier: .hulu, name: "Hulu"),
            Subscription(identifier: .mubi, name: "MUBI"),
            Subscription(identifier: .netflix, name: "Netflix"),
            Subscription(identifier: .paramountPlus, name: "Paramount+"),
            Subscription(identifier: .primeVideo, name: "Prime Video"),
            Subscription(identifier: .twitchTurbo, name: "Twitch Turbo"),

            // Utilities
            Subscription(identifier: .setapp, name: "Setapp"),

            // Video
            Subscription(identifier: .youTubePremium, name: "YouTube Premium"),

            // Wellness
            Subscription(identifier: .calm, name: "Calm"),
            Subscription(identifier: .headspace, name: "Headspace"),
            Subscription(identifier: .noom, name: "Noom"),

            // Writing
            Subscription(identifier: .grammarly, name: "Grammarly"),
            Subscription(identifier: .mediumMember, name: "Medium Member"),
        ]
    }
}
