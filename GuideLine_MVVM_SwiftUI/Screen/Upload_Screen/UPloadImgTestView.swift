////
//  UploadContentView.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/07/18.
//

import Foundation
import SwiftUI

struct UploadImgTest: View {
    
    @State var isShowingImagePicker = false
    
    @State var imageInBlackBox = UIImage()
    //@State var selectedImage: Image? = Image("")
    
    
    
    var body: some View {
        
        VStack{
            
            Image(uiImage: imageInBlackBox)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .border(Color.black, width: 1)
                .clipped()
            
            //img picker
            Button(action: {
                self.isShowingImagePicker.toggle()
            }, label: {
                Text("이미지 선택")
                    .font(.system(size: 24))
            })
            .sheet(isPresented: $isShowingImagePicker, content: {
                
                //ImagePicker(image: self.$selectedImage)
                
                
                //isShowingImage와 ImagePickerViewdml ispresented와 등록
                ImagePickerView(isPresented: self.$isShowingImagePicker, selectedImage: self.$imageInBlackBox)
                
            }) // imgPicker Btn
            
            
            //imgupload
            Button(action: {
                
                // convert image into base 64
                let uiImage: UIImage = self.imageInBlackBox
                let imageData: Data = uiImage.jpegData(compressionQuality: 0.1) ?? Data()
                let imageStr: String = imageData.base64EncodedString()
                
                //send request to server
                guard let url: URL = URL(string: "http://localhost:3000/test_post_img") else {
                    print("invalid URL")
                    return
                }
                
                // create parameters
                let paramStr: String = "image=\(imageStr)"
                let paramData: Data = paramStr.data(using: .utf8) ?? Data()
                
                var urlRequest: URLRequest =
                URLRequest(url: url)
                urlRequest.httpMethod = "POST"
                urlRequest.httpBody = paramData
                
                // required for sending large data
                urlRequest
                    .setValue(
                        "application/x-www-form-urlencoded",
                        forHTTPHeaderField: "Content-Type")
                
                // send the request
                URLSession.shared.dataTask(with:
                    urlRequest, completionHandler: {
                    
                        (data, response, error) in
                        guard let data = data else {
                            print("invalid data")
                            return
                        }
                        
                        //show response in str
                        let responseStr: String = String(data: data, encoding: .utf8) ?? ""
                        print(responseStr)
                        
                    })
                    .resume()

            }, label: {
                Text("Upload Image")
            })
            
        }
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    
    
    @Binding var isPresented: Bool
    @Binding var selectedImage: UIImage
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) ->
        UIViewController {
    
        let controller = UIImagePickerController()
        
        // Coodinator 등록
        controller.delegate = context.coordinator
        return controller
    }
    
    // Tricky part to using coordinator 굳이 필요한가 싶긴한데
    // https://www.youtube.com/watch?v=PN9wpxZ6MjY
    
    func makeCoordinator() -> ImagePickerView.Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        // to binding coordinator with ImagePickerView 생성자를 통해서
        let parent: ImagePickerView
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImageFromPicker = info[.originalImage] as? UIImage {
                print(selectedImageFromPicker)
                self.parent.selectedImage = selectedImageFromPicker
             }
            self.parent.isPresented = false
        }
    }
    
    
    func updateUIViewController(_ uiViewController: ImagePickerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePickerView>) {
        
    }
}
