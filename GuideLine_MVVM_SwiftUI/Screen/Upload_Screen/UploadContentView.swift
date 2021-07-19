//
//  UploadContentView.swift
//  GuideLine_MVVM_SwiftUI
//
//  Created by 최승원 on 2021/07/18.
//

import Foundation
import SwiftUI
import Alamofire

struct UploadContentView: View {
    
    @State var isShowingImagePicker = false
    
    @State var imageInBlackBox = UIImage()
    //@State var selectedImage: Image? = Image("")
    
    ///
    
    @State  var shouldSendCampus: Bool = false
    @State  var shouldWriteQusetion: Bool = false
    @State  var title = ""
    @State  var content: String = ""
    //@ObservedObject var uploadViewModel: UploadViewModel()
    ////
    
    var body: some View {
        
        VStack{
            VStack{
                
                Form {
                    
                    Section(header: Text("양식 설정")) {
                        Toggle("학교 전체 대상 업로드", isOn: $shouldSendCampus)
                        Toggle("질문 양식", isOn: $shouldWriteQusetion)
                    }
                    
                    Section(header: Text("작성 양식")){
                        TextField("게시물 제목을 입력하세요!!", text:
                                    $title)
                            .autocapitalization(.none)
                        TextEditor(text: $content)
                            
                            .frame(minHeight: 30, alignment: .leading)

    //                            .autocapitalization(.none)
                                //.multilineTextAlignment(.leading)
                            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity, alignment: .topLeading)
                    }
                    
                    if content.isEmpty {
                        
                    }
                    
                    
                    //title
                    
                 
                    
                }// form
                
                Button(action: {}) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 60)
                        .overlay(
                            Text("Upload!!")
                                .foregroundColor(.white)
                        )
                }.padding()
                    
            
                
            }// text form
            
            
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
            
            
            
            Button(action: {
                let url: URL = URL(string: "http://localhost:3000/test_post_img")!
                let uiImage: UIImage = self.imageInBlackBox
                let imageData: Data = uiImage.jpegData(compressionQuality: 0.1) ?? Data()
                
                AF.upload(multipartFormData: { multipartFormData in
                    multipartFormData.append(Data("value".utf8), withName: "key")
                    multipartFormData.append(imageData, withName: "image")
                }, to: url)
                .responseJSON {
                    response in
                    print(response)
                }
            }, label: {
                Text("upload Img")
            })
            
            
            
            
            
            
            //imgupload
//            Button(action: {
//
//                // convert image into base 64
//                let uiImage: UIImage = self.imageInBlackBox
//                let imageData: Data = uiImage.jpegData(compressionQuality: 0.1) ?? Data()
//                let imageStr: String = imageData.base64EncodedString()
//
//                //send request to server
//                guard let url: URL = URL(string: "http://localhost:3000/test_post_img") else {
//                    print("invalid URL")
//                    return
//                }
//
//                // create parameters
//                let paramStr: String = "image=\(imageStr)"
//                let paramData: Data = paramStr.data(using: .utf8) ?? Data()
//
//                var urlRequest: URLRequest =
//                URLRequest(url: url)
//                urlRequest.httpMethod = "POST"
//                urlRequest.httpBody = paramData
//
//                // required for sending large data
//                urlRequest
//                    .setValue(
//                        "application/x-www-form-urlencoded",
//                        forHTTPHeaderField: "Content-Type")
//
//                // send the request
//                URLSession.shared.dataTask(with:
//                    urlRequest, completionHandler: {
//
//                        (data, response, error) in
//                        guard let data = data else {
//                            print("invalid data")
//                            return
//                        }
//
//                        //show response in str
//                        let responseStr: String = String(data: data, encoding: .utf8) ?? ""
//                        print(responseStr)
//
//                    })
//                    .resume()
//
//            }, label: {
//                Text("Upload Image")
//            }) // Button
            
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