//
//  ContentView.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/5/23.
//

import AuthenticationServices
import SwiftUI
import UserNotifications

struct ContentView: View {
    @Environment(\.webAuthenticationSession) private var webAuthenticationSession

    let callbackURLScheme = "com.googleusercontent.apps.690844179795-j4vjeg85vsufev795lehv21i0ap7f994"

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://0.gravatar.com/avatar/ce8677131ede31409687636dea009c3a")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("There was an error loading the image.")
                } else {
                    ProgressView()
                }
            }
            .frame(width: 200, height: 200)

            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(
                    options: [.alert, .badge, .sound]
                ) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }

            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "New Access Request"
                content.subtitle = "Dean Clark is requesting access to Figma"
                content.sound = UNNotificationSound.default

                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request)
            }

            Button("Sign in") {
                Task {
                    do {
                        let urlWithToken = try await webAuthenticationSession.authenticate(
                            // swiftlint:disable:next line_length
                            using: URL(string: "https://accounts.google.com/o/oauth2/v2/auth?client_id=690844179795-j4vjeg85vsufev795lehv21i0ap7f994.apps.googleusercontent.com&response_type=code&scope=openid+profile+email&state&redirect_uri=com.googleusercontent.apps.690844179795-j4vjeg85vsufev795lehv21i0ap7f994:/oauth2callback")!,
                            callbackURLScheme: callbackURLScheme,
                            preferredBrowserSession: .ephemeral
                        )

                        let queryItems = URLComponents(string: urlWithToken.absoluteString)?.queryItems
                        let token = queryItems?.filter({ $0.name == "code" }).first?.value

                        print("\(String(describing: token))")

                        // Call the method that completes the authentication using the
                        // returned URL.
                        //                    try await signIn(using: urlWithToken)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
