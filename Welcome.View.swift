import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Welcome to the Breast Cancer NavigatorE")
                        .font(.largeTitle)
                        .padding()

                    Text("This app helps you with treatment options and finding support.")
                        .padding()

                    NavigationLink(destination: TreatmentAlgorithmView()) {
                        Text("Use Treatment Algorithm")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()

                    Button(action: {
                        // Action for finding oncologists
                        // Implement logic to search for oncologists based on user location
                    }) {
                        Text("Find Oncologist")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()

                    Button(action: {
                        // Action for finding therapists
                    }) {
                        Text("Find Therapist")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()

                    Button(action: {
                        // Action for finding support groups
                    }) {
                        Text("Find Support Group")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .padding()
                .navigationBarTitle("Welcome", displayMode: .inline)
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

