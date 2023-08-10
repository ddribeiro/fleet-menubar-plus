//
//  EscrowKeyView.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 8/7/23.
//

import SwiftUI

struct EscrowKeyView: View {
    @Environment(\.networkManager) var networkManager

    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.circle.fill")
                .foregroundColor(.red)
            Text("FileVault Encryption Key Not Escrowed")
                .font(.headline)
                .foregroundColor(.red)

            Spacer()

            Button {
                Task {
                    try await rotateEncryptionKey()
                }
            } label: {
                Text("Escrow Key")
            }
            .buttonStyle(.automatic)

        }
    }

    func rotateEncryptionKey() async throws {

        guard let deviceToken = readTokenFromFile() else {
            print("Failed to get device token")
            return
        }

        guard let url = URL(
            string: "device/\(deviceToken)/rotate_encryption_key",
            relativeTo: networkManager.environment.baseURL
        ) else {
            print("Unsupported URL")
            throw URLError(.unsupportedURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        var (_, _) = try await networkManager.environment.session.data(for: request)
    }

    func readTokenFromFile() -> String? {
        let fileURL = URL(fileURLWithPath: "/opt/orbit/identifier")

        do {
            // Read the content of the file into a string
            let token = try String(contentsOf: fileURL, encoding: .utf8)
            return token.trimmingCharacters(in: .whitespacesAndNewlines)
        } catch {
            // Handle any errors that might occur during file reading
            print("Error reading file: \(error)")
            return nil
        }
    }
}

struct EscrowKeyView_Previews: PreviewProvider {
    static var previews: some View {
        EscrowKeyView()
    }
}
