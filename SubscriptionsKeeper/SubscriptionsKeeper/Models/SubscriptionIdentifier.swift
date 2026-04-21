//
//  SubscriptionIdentifier.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 21.04.2026.
//

enum SubscriptionIdentifier: String {
    // AI
    case chatGPTPlus
    case claudePro
    case cursorPro
    case elevenLabs
    case geminiAdvanced
    case ideogram
    case jasper
    case leonardoAI
    case microsoftCopilotPro
    case midjourney
    case perplexityPro
    case poe
    case runway
    case sunoPro
    case superhuman
    case synthesia

    // Apple Services
    case appleArcade
    case appleDeveloperProgram
    case appleFitnessPlus
    case appleMusic
    case appleNewsPlus
    case appleOne
    case appleTVPlus
    case appleCare
    case iCloudPlus
    case iTunesMatch

    // Audio
    case audible

    // Career
    case linkedInPremium

    // Cloud
    case box
    case dropbox
    case googleOne
    case mega
    case oneDrive
    case pCloud
    case protonDrive

    // Communication
    case discordNitro
    case slackPro
    case telegramPremium
    case zoomPro

    // Creator
    case patreon

    // Delivery
    case woltPlus

    // Design
    case adobeCreativeCloud
    case canvaPro
    case figma

    // Developer Tools
    case digitalOcean
    case gitHubCopilot
    case gitLabPremium
    case heroku
    case jetBrainsAllProducts
    case linear
    case mongoDBAtlas
    case replitCore
    case vercelPro

    // Education
    case babbel
    case brilliant
    case codecademyPro
    case courseraPlus
    case duolingoSuper
    case masterClass
    case skillshare

    // Finance
    case revolutPremium
    case tradingViewEssential
    case ynab

    // Fitness
    case fitbod
    case myFitnessPalPremium
    case peloton
    case strava

    // Gaming
    case eaPlay
    case nintendoSwitchOnline
    case playStationPlus
    case ubisoftPlus
    case xboxGamePass

    // Mobility
    case boltPlus
    case uberOne

    // Music
    case deezer
    case soundCloudGoPlus
    case spotify
    case tidal
    case youTubeMusic

    // News
    case substack
    case theAthletic
    case theNewYorkTimes
    case theWallStreetJournal

    // Productivity
    case evernote
    case microsoft365
    case notion
    case obsidianSync
    case raycastPro
    case readwise
    case todoist

    // Reading
    case kindleUnlimited

    // Security
    case onePassword
    case bitwardenPremium
    case dashlane
    case expressVPN
    case nordVPN
    case protonMailPlus
    case protonPass
    case surfshark

    // Shopping
    case amazonPrime

    // Social
    case xPremium

    // Streaming
    case crunchyroll
    case disneyPlus
    case hboMax
    case hulu
    case mubi
    case netflix
    case paramountPlus
    case primeVideo
    case twitchTurbo

    // Utilities
    case setapp

    // Video
    case youTubePremium

    // Wellness
    case calm
    case headspace
    case noom

    // Writing
    case grammarly
    case mediumMember
}

extension SubscriptionIdentifier {
    var imageUrlString: String {
        "https://www.google.com/s2/favicons?domain=\(domain)&sz=256"
    }

    private var domain: String {
        switch self {
        // AI
        case .chatGPTPlus: return "openai.com"
        case .claudePro: return "claude.ai"
        case .cursorPro: return "cursor.sh"
        case .elevenLabs: return "elevenlabs.io"
        case .geminiAdvanced: return "gemini.google.com"
        case .ideogram: return "ideogram.ai"
        case .jasper: return "jasper.ai"
        case .leonardoAI: return "leonardo.ai"
        case .microsoftCopilotPro: return "microsoft.com"
        case .midjourney: return "midjourney.com"
        case .perplexityPro: return "perplexity.ai"
        case .poe: return "poe.com"
        case .runway: return "runwayml.com"
        case .sunoPro: return "suno.ai"
        case .superhuman: return "superhuman.com"
        case .synthesia: return "synthesia.io"
        // Apple Services
        case .appleArcade: return "apple.com"
        case .appleDeveloperProgram: return "developer.apple.com"
        case .appleFitnessPlus: return "apple.com"
        case .appleMusic: return "apple.com"
        case .appleNewsPlus: return "apple.com"
        case .appleOne: return "apple.com"
        case .appleTVPlus: return "apple.com"
        case .appleCare: return "apple.com"
        case .iCloudPlus: return "icloud.com"
        case .iTunesMatch: return "apple.com"
        // Audio
        case .audible: return "audible.com"
        // Career
        case .linkedInPremium: return "linkedin.com"
        // Cloud
        case .box: return "box.com"
        case .dropbox: return "dropbox.com"
        case .googleOne: return "google.com"
        case .mega: return "mega.io"
        case .oneDrive: return "microsoft.com"
        case .pCloud: return "pcloud.com"
        case .protonDrive: return "proton.me"
        // Communication
        case .discordNitro: return "discord.com"
        case .slackPro: return "slack.com"
        case .telegramPremium: return "telegram.org"
        case .zoomPro: return "zoom.us"
        // Creator
        case .patreon: return "patreon.com"
        // Delivery
        case .woltPlus: return "wolt.com"
        // Design
        case .adobeCreativeCloud: return "adobe.com"
        case .canvaPro: return "canva.com"
        case .figma: return "figma.com"
        // Developer Tools
        case .digitalOcean: return "digitalocean.com"
        case .gitHubCopilot: return "github.com"
        case .gitLabPremium: return "gitlab.com"
        case .heroku: return "heroku.com"
        case .jetBrainsAllProducts: return "jetbrains.com"
        case .linear: return "linear.app"
        case .mongoDBAtlas: return "mongodb.com"
        case .replitCore: return "replit.com"
        case .vercelPro: return "vercel.com"
        // Education
        case .babbel: return "babbel.com"
        case .brilliant: return "brilliant.org"
        case .codecademyPro: return "codecademy.com"
        case .courseraPlus: return "coursera.org"
        case .duolingoSuper: return "duolingo.com"
        case .masterClass: return "masterclass.com"
        case .skillshare: return "skillshare.com"
        // Finance
        case .revolutPremium: return "revolut.com"
        case .tradingViewEssential: return "tradingview.com"
        case .ynab: return "ynab.com"
        // Fitness
        case .fitbod: return "fitbod.me"
        case .myFitnessPalPremium: return "myfitnesspal.com"
        case .peloton: return "onepeloton.com"
        case .strava: return "strava.com"
        // Gaming
        case .eaPlay: return "ea.com"
        case .nintendoSwitchOnline: return "nintendo.com"
        case .playStationPlus: return "playstation.com"
        case .ubisoftPlus: return "ubisoft.com"
        case .xboxGamePass: return "xbox.com"
        // Mobility
        case .boltPlus: return "bolt.eu"
        case .uberOne: return "uber.com"
        // Music
        case .deezer: return "deezer.com"
        case .soundCloudGoPlus: return "soundcloud.com"
        case .spotify: return "spotify.com"
        case .tidal: return "tidal.com"
        case .youTubeMusic: return "youtube.com"
        // News
        case .substack: return "substack.com"
        case .theAthletic: return "theathletic.com"
        case .theNewYorkTimes: return "nytimes.com"
        case .theWallStreetJournal: return "wsj.com"
        // Productivity
        case .evernote: return "evernote.com"
        case .microsoft365: return "microsoft.com"
        case .notion: return "notion.so"
        case .obsidianSync: return "obsidian.md"
        case .raycastPro: return "raycast.com"
        case .readwise: return "readwise.io"
        case .todoist: return "todoist.com"
        // Reading
        case .kindleUnlimited: return "amazon.com"
        // Security
        case .onePassword: return "1password.com"
        case .bitwardenPremium: return "bitwarden.com"
        case .dashlane: return "dashlane.com"
        case .expressVPN: return "expressvpn.com"
        case .nordVPN: return "nordvpn.com"
        case .protonMailPlus: return "proton.me"
        case .protonPass: return "proton.me"
        case .surfshark: return "surfshark.com"
        // Shopping
        case .amazonPrime: return "amazon.com"
        // Social
        case .xPremium: return "x.com"
        // Streaming
        case .crunchyroll: return "crunchyroll.com"
        case .disneyPlus: return "disneyplus.com"
        case .hboMax: return "max.com"
        case .hulu: return "hulu.com"
        case .mubi: return "mubi.com"
        case .netflix: return "netflix.com"
        case .paramountPlus: return "paramountplus.com"
        case .primeVideo: return "primevideo.com"
        case .twitchTurbo: return "twitch.tv"
        // Utilities
        case .setapp: return "setapp.com"
        // Video
        case .youTubePremium: return "youtube.com"
        // Wellness
        case .calm: return "calm.com"
        case .headspace: return "headspace.com"
        case .noom: return "noom.com"
        // Writing
        case .grammarly: return "grammarly.com"
        case .mediumMember: return "medium.com"
        }
    }
}
