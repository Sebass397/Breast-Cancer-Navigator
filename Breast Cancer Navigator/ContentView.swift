import SwiftUI

struct ContentView: View {
    @State private var tumorType = ""
    @State private var tumorSubtype = ""
    @State private var tumorStage = ""
    @State private var tumorGrade = ""
    @State private var erStatus = ""
    @State private var prStatus = ""
    @State private var her2Status = ""
    @State private var lymphNodeStatus = ""
    @State private var geneticRisk = ""
    @State private var showSideEffects = false
    @State private var useLaymanTerms = false
    @State private var errorMessage = ""
    @State private var showingAlert = false
    @State private var recommendation = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Tumor Information")) {
                        TextField("Tumor Type (Invasive or In-situ)", text: $tumorType)
                        TextField("Tumor Subtype (Ductal, Lobular, or Other)", text: $tumorSubtype)
                        TextField("Tumor Stage (0-4)", text: $tumorStage)
                            .keyboardType(.numberPad)
                        TextField("Tumor Grade (1-3)", text: $tumorGrade)
                            .keyboardType(.numberPad)
                    }
                    
                    Section(header: Text("Biomarkers")) {
                        TextField("ER Status (Positive or Negative)", text: $erStatus)
                        TextField("PR Status (Positive or Negative)", text: $prStatus)
                        TextField("HER2 Status (Positive or Negative)", text: $her2Status)
                        TextField("Lymph Node Status (cN0-cN3 or pN0-pN3)", text: $lymphNodeStatus)
                    }
                    
                    Section(header: Text("Genetic Risk")) {
                        TextField("Genetic Risk (Low, High, or None)", text: $geneticRisk)
                    }
                    
                    Section(header: Text("Options")) {
                        Toggle("View Side Effects", isOn: $showSideEffects)
                        Toggle("Use Layman Terms", isOn: $useLaymanTerms)
                    }
                    
                    Section {
                        Button(action: {
                            if let stage = Int(self.tumorStage), let grade = Int(self.tumorGrade) {
                                let result = breastCancerTreatment(
                                    tumorType: self.tumorType,
                                    tumorSubtype: self.tumorSubtype,
                                    tumorStage: stage,
                                    tumorGrade: grade,
                                    erStatus: self.erStatus,
                                    prStatus: self.prStatus,
                                    her2Status: self.her2Status,
                                    lymphNodeStatus: self.lymphNodeStatus,
                                    geneticRisk: self.geneticRisk,
                                    viewSideEffects: self.showSideEffects,
                                    layman: self.useLaymanTerms
                                )
                                
                                self.recommendation = result.treatmentPlan
                                if self.recommendation.hasPrefix("Invalid") {
                                    self.errorMessage = self.recommendation
                                    self.showingAlert = true
                                }
                            } else {
                                self.errorMessage = "Please enter valid numeric values for Tumor Stage and Tumor Grade."
                                self.showingAlert = true
                            }
                        }) {
                            Text("Generate Recommendation")
                        }
                    }
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
                
                if !recommendation.isEmpty {
                    ScrollView {
                        VStack(alignment: .leading) {
                            Text(recommendation)
                                .padding()
                        }
                    }
                }
                
                Spacer()
            }
            .navigationBarTitle("Breast Cancer Navigator")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Sample breastCancerTreatment function
func breastCancerTreatment(tumorType: String, tumorSubtype: String, tumorStage: Int, tumorGrade: Int, erStatus: String, prStatus: String, her2Status: String, lymphNodeStatus: String, geneticRisk: String?, viewSideEffects: Bool, layman: Bool) -> (treatmentPlan: String, sideEffects: String, laymanExplanation: String) {
    // Implement the treatment algorithm logic with the selected options
    let treatmentPlan = "Treatment Plan for \(tumorType), \(tumorSubtype), Stage \(tumorStage), Grade \(tumorGrade), ER \(erStatus), PR \(prStatus), HER2 \(her2Status), Lymph Node \(lymphNodeStatus), Genetic Risk \(geneticRisk ?? "None")"
    let sideEffects = viewSideEffects ? "Detailed side effects based on the chosen treatment plan." : "Side effects not displayed."
    let laymanExplanation = layman ? "Layman's explanation of the treatment plan." : "Technical details of the treatment plan."
    return (treatmentPlan, sideEffects, laymanExplanation)
}

