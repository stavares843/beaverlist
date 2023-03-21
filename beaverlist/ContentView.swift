import SwiftUI

struct ContentView: View {
  @State public var searchText = ""
  @State public var selectedGradient = Color.mysticTwilight
  @State public var isTapped: Bool = false

  let userInputs: [String]

  init() {
    guard let url = Bundle.main.url(forResource: "user_inputs", withExtension: "txt"),
      let data = try? String(contentsOf: url)
    else {
      print("Failed to load user inputs from txt file.")
      self.userInputs = []
      return
    }

    do {
      let regex = try NSRegularExpression(pattern: #"user_input_\d+ = "(.*?)""#)
      self.userInputs = regex.matches(in: data, range: NSRange(data.startIndex..., in: data)).map {
        String(data[Range($0.range(at: 1), in: data)!])
      }
    } catch {
      print("Failed to create regular expression with error: \(error.localizedDescription)")
      self.userInputs = []
    }
  }

  var filteredUserInputs: [String] {
    if searchText.isEmpty {
      return userInputs
    } else {
      return userInputs.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
  }

  var body: some View {
    VStack {
      HStack {
        Text("User Inputs")
          .font(.title)
          .fontWeight(.bold)
          .padding()
        Spacer()

          Menu {
              Button(action: {
                  selectedGradient = Color.blueberryBlush
              }) {
                  Text("Blueberry Blush")
                  Image("blueberry_blush")
              }
              Button(action: {
                  selectedGradient = Color.slateMist
              }) {
                  Text("Slate Mist")
                  Image("slate_mist")
              }
              Button(action: {
                  selectedGradient = Color.mysticTwilight
              }) {
                  Text("Mystic Twilight")
                  Image("mystic_twilight")
              }
              Button(action: {
                  selectedGradient = Color.sunsetBlaze
              }) {
                  Text("Sunset Blaze")
                  Image("sunset_blaze")
              }
          } label: {
              Image("themes")
                  .resizable()
                  .frame(width: 40, height: 40)
                  .font(.system(size: 15))
          }
          .padding(.trailing, 16)
      }

      SearchBar(text: $searchText, placeholder: "Search")
        .padding(.horizontal, 16)

      if filteredUserInputs.isEmpty {
        Text("No results found for '\(searchText)' 🦫")
          .padding()
      } else {
        ScrollView {
          LazyVStack(alignment: .center, spacing: 1) {
            ForEach(filteredUserInputs, id: \.self) { input in
              HStack {
                Spacer()
                Text(input)
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .padding(.vertical, 10)
                  .padding(.horizontal, 5)
                  .foregroundColor(.white)
                  .background(selectedGradient)
                  .cornerRadius(10)
                  .onTapGesture {
                    let fullString = input
                    var textToCopy = ""

                    if let startRange = fullString.range(of: ">>"),
                      let endRange = fullString.range(
                        of: "<<", range: startRange.upperBound..<fullString.endIndex) {
                      textToCopy = String(fullString[startRange.upperBound..<endRange.lowerBound])
                    } else if let range = fullString.range(of: ":") {
                      textToCopy = String(fullString[range.upperBound...])
                    }

                    // Copy text to clipboard
                    UIPasteboard.general.string = textToCopy.trimmingCharacters(
                      in: .whitespacesAndNewlines)
                    print("Copied to clipboard: \(textToCopy)")
                  }

              }
              Spacer()
            }
            .padding(.trailing, 10)
          }
        }

      }
    }
    Spacer()
  }

  struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    let placeholder: String

    class Coordinator: NSObject, UISearchBarDelegate {
      @Binding var text: String

      init(text: Binding<String>) {
        _text = text
      }

      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        text = searchText

        // Show cancel button when user starts searching
        searchBar.showsCancelButton = true
      }

      func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        text = ""
      }

      func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
      }

      func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
      }
    }

    func makeCoordinator() -> Coordinator {
      return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
      let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
      searchBar.delegate = context.coordinator
      searchBar.placeholder = placeholder
      searchBar.showsCancelButton = false  // Hide cancel button initially
      return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
      uiView.text = text
    }
  }
}
