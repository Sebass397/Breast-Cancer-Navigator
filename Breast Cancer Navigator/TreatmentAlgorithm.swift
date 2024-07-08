import Foundation

struct TreatmentAlgorithm {

    struct Inputs {
        let tumorType: String
        let tumorSubtype: String
        let tumorStage: Int
        let tumorGrade: Int
        let erStatus: String
        let prStatus: String
        let her2Status: String
        let lymphNodeStatus: String
        let geneticRisk: String?
    }

    struct TreatmentPlan {
        let treatment: [String]
        let sideEffects: [String]?
    }

    static func validateInputs(tumorType: String, tumorSubtype: String, tumorStage: Int, tumorGrade: Int, erStatus: String, prStatus: String, her2Status: String, lymphNodeStatus: String, geneticRisk: String?) -> (Bool, String?) {
        let validTumorTypes = ["invasive", "in-situ"]
        let validTumorSubtypes = ["ductal", "lobular", "other"]
        let validTumorStages = [0, 1, 2, 3, 4]
        let validTumorGrades = [1, 2, 3]
        let validErStatuses = ["positive", "negative"]
        let validPrStatuses = ["positive", "negative"]
        let validHer2Statuses = ["positive", "negative"]
        let validLymphNodeStatuses = ["cn0", "cn1", "cn2", "cn3", "pn0", "pn1", "pn2", "pn3"]
        let validGeneticRisks = ["low", "high", nil]

        if !validTumorTypes.contains(tumorType) {
            return (false, "Invalid tumor type: \(tumorType). Valid options are 'Invasive' or 'In-situ'.")
        }
        if !validTumorSubtypes.contains(tumorSubtype) {
            return (false, "Invalid tumor subtype: \(tumorSubtype). Valid options are 'Ductal', 'Lobular', or 'Other'.")
        }
        if !validTumorStages.contains(tumorStage) {
            return (false, "Invalid tumor stage: \(tumorStage). Valid options are 0, 1, 2, 3, or 4.")
        }
        if !validTumorGrades.contains(tumorGrade) {
            return (false, "Invalid tumor grade: \(tumorGrade). Valid options are 1, 2, or 3.")
        }
        if !validErStatuses.contains(erStatus) {
            return (false, "Invalid ER status: \(erStatus). Valid options are 'Positive' or 'Negative'.")
        }
        if !validPrStatuses.contains(prStatus) {
            return (false, "Invalid PR status: \(prStatus). Valid options are 'Positive' or 'Negative'.")
        }
        if !validHer2Statuses.contains(her2Status) {
            return (false, "Invalid HER2 status: \(her2Status). Valid options are 'Positive' or 'Negative'.")
        }
        if !validLymphNodeStatuses.contains(lymphNodeStatus) {
            return (false, "Invalid lymph node status: \(lymphNodeStatus). Valid options are 'cN0', 'cN1', 'cN2', 'cN3', 'pN0', 'pN1', 'pN2', or 'pN3'.")
        }
        if geneticRisk != nil && !validGeneticRisks.contains(geneticRisk!) {
            return (false, "Invalid genetic risk: \(geneticRisk!). Valid options are 'Low', 'High', or None.")
        }

        return (true, nil)
    }

    static func determineSideEffects(treatmentPlan: [String]) -> [String] {
        let sideEffects: [String: [String]] = [
            "Hormonal Therapy": ["Hot flashes", "Vaginal dryness", "Mood changes", "Fatigue", "Nausea"],
            "HER2-targeted Therapy": ["Heart problems", "Diarrhea", "Liver problems", "Low white blood cell counts", "Fatigue"],
            "Chemotherapy": ["Hair loss", "Nausea and vomiting", "Fatigue", "Increased risk of infection", "Mouth sores", "Loss of appetite", "Diarrhea or constipation", "Neuropathy"],
            "Immunotherapy": ["Fatigue", "Skin reactions", "Diarrhea", "Shortness of breath", "Muscle or joint pain"],
            "Targeted Therapy": ["Diarrhea", "Liver problems", "Skin rash", "High blood pressure", "Blood clotting issues"],
            "Bisphosphonates": ["Bone, joint, or muscle pain", "Nausea", "Constipation", "Fatigue", "Low calcium levels in the blood"]
        ]

        var patientSideEffects = Set<String>()
        for treatment in treatmentPlan {
            for (key, effects) in sideEffects {
                if treatment.lowercased().contains(key.lowercased()) {
                    patientSideEffects.formUnion(effects)
                }
            }
        }

        return Array(patientSideEffects)
    }

    static func breastCancerTreatment(inputs: Inputs, viewSideEffects: Bool, layman: Bool) -> TreatmentPlan {
        // Standardizing inputs
        let tumorType = inputs.tumorType.lowercased()
        let tumorSubtype = inputs.tumorSubtype.lowercased()
        let erStatus = inputs.erStatus.lowercased().replacingOccurrences(of: "+", with: "positive").replacingOccurrences(of: "-", with: "negative")
        let prStatus = inputs.prStatus.lowercased().replacingOccurrences(of: "+", with: "positive").replacingOccurrences(of: "-", with: "negative")
        let her2Status = inputs.her2Status.lowercased().replacingOccurrences(of: "+", with: "positive").replacingOccurrences(of: "-", with: "negative")
        let lymphNodeStatus = inputs.lymphNodeStatus.lowercased()
        let geneticRisk = inputs.geneticRisk?.lowercased()

        // Validate inputs
        let (valid, errorMessage) = validateInputs(tumorType: tumorType, tumorSubtype: tumorSubtype, tumorStage: inputs.tumorStage, tumorGrade: inputs.tumorGrade, erStatus: erStatus, prStatus: prStatus, her2Status: her2Status, lymphNodeStatus: lymphNodeStatus, geneticRisk: geneticRisk)
        guard valid else {
            return TreatmentPlan(treatment: [errorMessage!], sideEffects: nil)
        }

        var treatmentPlan = [String]()

        // In-situ Tumors
        if tumorType == "in-situ" {
            if inputs.tumorStage == 0 {
                treatmentPlan.append("Lumpectomy or mastectomy, often followed by radiation therapy.")
            }
        }

        // Invasive Tumors
        if tumorType == "invasive" {
            if inputs.tumorStage == 1 || inputs.tumorStage == 2 {
                treatmentPlan.append("Surgery (lumpectomy or mastectomy), followed by radiation therapy.")
                if erStatus == "positive" && prStatus == "positive" && her2Status == "negative" {
                    if geneticRisk == "low" {
                        treatmentPlan.append("Adjuvant hormone therapy (e.g., Tamoxifen, Aromatase inhibitors).")
                    } else if geneticRisk == "high" {
                        treatmentPlan.append("Chemotherapy followed by hormone therapy.")
                    }
                } else if erStatus == "positive" && her2Status == "positive" {
                    treatmentPlan.append("Combination of hormone therapy, HER2-targeted therapy (e.g., Trastuzumab), and chemotherapy.")
                } else if her2Status == "positive" {
                    treatmentPlan.append("HER2-targeted therapy with chemotherapy.")
                } else if erStatus == "negative" && prStatus == "negative" && her2Status == "negative" {
                    treatmentPlan.append("Chemotherapy is the mainstay, with possible addition of immunotherapy for advanced stages.")
                }
            }

            if inputs.tumorStage == 3 {
                treatmentPlan.append("Neoadjuvant chemotherapy to shrink the tumor, followed by surgery and radiation.")
                if erStatus == "positive" && prStatus == "positive" && her2Status == "negative" {
                    treatmentPlan.append("Adjuvant hormone therapy.")
                } else if her2Status == "positive" {
                    treatmentPlan.append("HER2-targeted therapy.")
                } else if erStatus == "negative" && prStatus == "negative" && her2Status == "negative" {
                    treatmentPlan.append("Chemotherapy.")
                }
            }

            if inputs.tumorStage == 4 {
                treatmentPlan.append("Systemic therapies to control spread and improve quality of life.")
                if erStatus == "positive" && prStatus == "positive" && her2Status == "negative" {
                    treatmentPlan.append("Options include hormone therapy and chemotherapy.")
                } else if her2Status == "positive" {
                    treatmentPlan.append("Options include HER2-targeted therapy and chemotherapy.")
                } else if erStatus == "negative" && prStatus == "negative" && her2Status == "negative" {
                    treatmentPlan.append("Options include chemotherapy and immunotherapy.")
                }
            }
        }

        // Determine side effects
        var sideEffects: [String]? = nil
        if viewSideEffects {
            sideEffects = determineSideEffects(treatmentPlan: treatmentPlan)
        }

        return TreatmentPlan(treatment: treatmentPlan, sideEffects: sideEffects)
    }
}

