// https://www.hackingwithswift.com/books/ios-swiftui/adding-codable-conformance-for-published-properties

//class User: ObservableObject, Codable {
//    @Published var name = "Paul Hudson"
//
//    enum CodingKeys: CodingKey {
//        case name
//    }
//
//    required init(from decoder: Decoder) throws {
//        //このデータにCodingKeys enumの中で記載したデータをcontainerに入れる？
//        let container = try decoder.container(keyedBy: CodingKeys.self)
////        enumのcaseを使えばそのまま取り出せる
//        name = try container.decode(String.self, forKey: .name) //CodingKeys.name
////            enum使って、CodingKeyプロトコルにも準拠して、タイプミスもなくなる
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//    }
//}


//https://www.hackingwithswift.com/books/ios-swiftui/sending-and-receiving-codable-data-with-urlsession-and-swiftui

////array of results.
//struct Response: Codable {
//    var results: [Result]
//}
//
////store a track ID, its name, and the album it belongs to
//struct Result: Codable {
//    var trackId: Int
//    var trackName: String
//    var collectionName: String
//}
//
//struct ContentView: View {
//    @State private var results = [Result]()
//
//    var body: some View {
//        List(results, id: \.trackId) { item in
//            VStack(alignment: .leading) {
//                Text(item.trackName)
//                    .font(.headline)
//                Text(item.collectionName)
//            }
//        }
//        .onAppear(perform: loadData) //List表示時に発動
//    }
//    func loadData() {
//        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
//            print("Invalid URL")
//            return
//        }
//        let request = URLRequest(url: url)
////        URLSession is the iOS class responsible for managing network requests. You can make your own session if you want to, but it’s very common to use the shared session that iOS creates for us to use
//
////        dataTask(with:) creates a networking task from a URLRequest and a closure that should be run when the task completes
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data { //dataはこの時点でData型
//                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
//                    //Data型のdataをデコードして、Responseの形に直し、swiftで使えるようにしてる
//                    // we have good data – go back to the main thread
//                    DispatchQueue.main.async {
//                        // update our UI
//                        self.results = decodedResponse.results
//                    }
//
//                    // everything is good, so we can exit
//                    return
//                }
//            }
//
//            // if we're still here it means there was a problem
//            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
//        }.resume() //This makes request start immediately, and control gets handed over to the system
//    }
//}


//https://www.hackingwithswift.com/books/ios-swiftui/validating-and-disabling-forms

//struct ContentView: View {
//    @State private var username = ""
//    @State private var email = ""
//
//    var disableForm: Bool {
//        username.count < 5 || email.count < 5
//    }
//
//    var body: some View {
//        Form {
//            Section {
//                TextField("Username", text: $username)
//                TextField("Email", text: $email)
//            }
//
//            Section {
//                Button("Create account") {
//                    print("Creating account…")
//                }
//            }
////            .disabled(username.isEmpty || email.isEmpty)
//            .disabled(disableForm)
//        }
//    }
//}
