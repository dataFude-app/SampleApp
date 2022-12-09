import SwiftUI
import os

struct ContentView: View {
    @State private var offset = CGFloat.zero

    @State private var lastOffset = 0.0 {
        didSet {
            
        }
    }

    @State private var selection = Set<String>() {
        didSet {

        }
    }

    @State private var lastDirection = ""

    var body: some View {
        VStack {
            ScrollView {
                // List title
                Text("Select destination countries")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()

                // Countries list
                ScrollViewReader { proxy in
                    VStack(spacing: 0) {
                        ForEach(NSLocale.isoCountryCodes, id: \.self) { code in
                            // List row
                            HStack {
                                Text(countryFlag(code)).font(.largeTitle).padding(.horizontal, 8)
                                Text(Locale.current.localizedString(forRegionCode: code) ?? "").font(.title3)
                                Spacer()
                            }
                            .padding()
                            .background(selection.contains(code) ? Color.accentColor : Color.backgroundColor)
                            .id(code)
                            .onTapGesture {
                                // Toggle selection
                                withAnimation {
                                    if selection.contains(code) {
                                        selection.remove(code)
                                    } else {
                                        selection.insert(code)
                                    }
                                }
                            }
                        }
                    }
                    .background(Color.backgroundColor)
                }
                .background(GeometryReader {
                    // Read the table view scroll offset
                    Color.clear.preference(
                        key: ViewOffsetKey.self,
                        value: -$0.frame(in: .named("scroll")).origin.y
                    )
                })
                .onPreferenceChange(ViewOffsetKey.self) {
                    onScroll($0)
                }

            }
            .coordinateSpace(name: "scroll")
        }
        .background(.indigo)
    }

    func onScroll(_ offset: CGFloat) {
        let direction = offset > lastOffset ? "↘️": "↗️"
        if direction != lastDirection {
            //os_log("Direction: %@", direction)
            lastDirection = direction
        }

        lastOffset = offset
    }
}
