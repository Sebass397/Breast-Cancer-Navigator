import SwiftUI

struct TreatmentAlgorithmView: View {
    @State private var tumorType = "Invasive"
    @State private var tumorSubtype = "Ductal"
    @State private var tumorStage = 0
    @State private var tumorGrade = 1
    @State private var erStatus = "Positive"
    @State private var prStatus = "Positive"
    @State private var her2Status = "Negative"
    @State private var lymphNodeStatus = "cN0"
    @State private var geneticRisk: String? = "Low"
    @State private var treatmentPlan: TreatmentAlgorithm.TreatmentPlan?
    @State private var showSideEffects = false
    @State private var isLayman = false

    var body: some View {
        VStack {
            // Tumor Type
            Picker("Tumor Type", selection: $tumorType) {
                Text("Invasive").tag("Invasive")
                Text("In-situ").tag("In-situ")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // Tumor Subtype
            Picker("Tumor Subtype", selection: $tumorSubtype) {
                Text("Ductal").tag("Ductal")
                Text("Lobular").tag("Lobular")
                Text("Other").tag("Other")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // Tumor Stage
            Stepper(value: $tumorStage, in: 0...4) {
                Text("Tumor Stage: \(tumorStage)")
            }
            .padding()

            // Tumor Grade
            Stepper(value: $tumorGrade, in: 1...3) {
                Text("Tumor Grade: \(tumorGrade)")
            }
            .padding()

            // ER Status
            Picker("ER Status", selection: $erStatus) {
                Text("Positive").tag("Positive")
                Text("Negative").tag("Negative")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // PR Status
            Picker("PR Status", selection: $prStatus) {
                Text("Positive").tag("Positive")
                Text("Negative").tag("Negative")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // HER2 Status
            Picker("HER2 Status", selection: $her2Status) {
                Text("Positive").tag("Positive")
                Text("Negative").tag("Negative")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // Lymph Node Status
            Picker("Lymph Node Status", selection: $lymphNodeStatus) {
                Text("cN0").tag("cN0")
                Text("cN1").tag("cN1")
                Text("cN2").tag("cN2")
                Text("cN3").tag("cN3")
                Text("pN0").tag("pN0")
                Text("pN1").tag("pN1")
                Text("pN2").tag("pN2")
                Text("pN3").tag("pN3")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // Genetic Risk
            Picker("Genetic Risk", selection: $geneticRisk) {
                Text("Low").tag("Low")
                Text("High").tag("High")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // Toggle for Side Effects
            Toggle("View Side Effects", isOn: $showSideEffects)
                .padding()

            // Toggle for Layman Terms
            Toggle("View Layman Terms", isOn: $isLayman)
                .padding()

            Button(action: {
                let inputs = TreatmentAlgorithm.Inputs(
                    tumorType: tumorType,
                    tumorSubtype: tumorSubtype,
                    tumorStage: tumorStage,
                    tumorGrade: tumorGrade,
                    erStatus: erStatus,
                    prStatus: prStatus,
                    her2Status: her2Status,
                    lymphNodeStatus: lymphNodeStatus,
                    geneticRisk: geneticRisk
                )
                treatmentPlan = TreatmentAlgorithm.breastCancerTreatment(inputs: inputs, viewSideEffects: showSideEffects, layman: isLayman)
            }) {
                Text("Generate Treatment Plan")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            // Display Treatment Plan and Side Effects
            if let treatmentPlan = treatmentPlan {
                Text("Treatment Plan: \(treatmentPlan.treatment.joined(separator: ", "))")
                    .padding()

                if let sideEffects = treatmentPlan.sideEffects {
                    Text("Side Effects: \(sideEffects.joined(separator: ", "))")
                        .padding()
                }
            }
        }
        .padding()
        .navigationBarTitle("Treatment Algorithm", displayMode: .inline)
    }
}

struct TreatmentAlgorithmView_Previews: PreviewProvider {
    static var previews: some View {
        TreatmentAlgorithmView()
    }
}

