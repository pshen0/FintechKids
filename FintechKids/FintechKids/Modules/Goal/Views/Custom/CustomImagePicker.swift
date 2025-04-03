import SwiftUI
import PhotosUI

struct CustomImagePickerView: View {
    var imageName: String
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    @State private var isCropping = false
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    @State var changed: Bool = false
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $selectedItem, matching: .images) {
                Image(uiImage: selectedImage ?? loadSavedImage(imageName: imageName))
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(.black)
            }
        }
        .onAppear() {
            selectedImage = loadSavedImage(imageName: imageName)
        }
        .onChange(of: selectedItem) { _, newItem in
            if let newItem {
                loadImage(from: newItem)
            }
        }
        .onChange(of: selectedImage) {
            if let image = selectedImage {
                saveImageToDocuments(image: image)
            }
        }
        .sheet(isPresented: Binding(
            get: { isCropping && selectedImage != nil },
            set: { if !$0 { isCropping = false } }
        )) {
            if let selectedImage {
                CropView(image: selectedImage, croppedImage: $selectedImage, width: screenWidth * 0.783, height: screenHeight * 0.2, location: CGPoint(x: screenWidth / 2, y: screenHeight / 8))
                    .background(Color.background)
            }
        }
    }
    
    private func loadImage(from item: PhotosPickerItem) {
        Task {
            if let data = try? await item.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    selectedImage = image
                    isCropping = true
                    saveImageToDocuments(image: image)
                }
            } else {
                DispatchQueue.main.async {
                    selectedImage = nil
                    isCropping = false
                }
            }
        }
    }
    
    func saveImageToDocuments(image: UIImage) {
        if let data = image.jpegData(compressionQuality: 0.8) {
            let filepath = getDocumentsDirectory().appendingPathComponent(imageName)
            try? data.write(to: filepath)
        }
    }
}
