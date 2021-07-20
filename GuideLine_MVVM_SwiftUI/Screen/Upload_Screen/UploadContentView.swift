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
                    }// 양식 설정 Section
                    
                    Section(header: Text("사진을 추가하세요")) {
                      
                        //img picker
                        Button(action: {
                            self.isShowingImagePicker.toggle()
                        }, label: {
                            Text("이미지 선택")
                                
                        })
                        .sheet(isPresented: $isShowingImagePicker, content: {
                            
                            //ImagePicker(image: self.$selectedImage)
                            
                            
                            //isShowingImage와 ImagePickerViewdml ispresented와 등록
                            ImagePickerView(isPresented: self.$isShowingImagePicker, selectedImage: self.$imageInBlackBox)
                            
                        }) // imgPicker Btn
                        
                        
                        Image(uiImage: imageInBlackBox)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100 , height: 100)
                            .border(Color.gray, width: 1)
                            .cornerRadius(10)
                            
                            .clipped()
                        
                        
                        
                        
                        
//                        Button(action: {
//                            let url: URL = URL(string: "http://127.0.0.1:8000/api/feed/")!
//                            let uiImage: UIImage = self.imageInBlackBox
//                            let imageData = uiImage.jpegData(compressionQuality: 0.8) ?? Data()
////                            let imageData: Data = uiImage.jpegData(compressionQuality: 0.1) ?? Data()
//
//                            AF.upload(multipartFormData: { multipartFormData in
//                                multipartFormData.append(Data(title.utf8), withName: "title")
//                                multipartFormData.append(Data(content.utf8), withName: "content")
//                                multipartFormData.append(imageData, withName: "feed_img", fileName: "photo.jpg", mimeType: "jpg/png")
//                            }, to: url)
//                            .responseJSON {
//                                response in
//                                print(response)
//                            }
//                        }, label: {
//                            Text("upload Img")
//                        })
                    
                    
                    }// 사진 작성 Section
                    
                    Section(header: Text("작성 양식")){
                        TextField("게시물 제목을 입력하세요!!", text:
                                    $title)
                            .autocapitalization(.none)
                        CustomTextEditor.init(placeholder: "게시물 내용을 작성해 주세요!!", text: $content)
                            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity, alignment: .topLeading)
                    }// 작성 양식 Section

                }// form
  
                
                Button(action: {
                    
                    let url: URL = URL(string: "http://127.0.0.1:8000/api/feed/")!
                    let uiImage: UIImage = self.imageInBlackBox
                    let imageData = uiImage.jpegData(compressionQuality: 0.8) ?? Data()
//                            let imageData: Data = uiImage.jpegData(compressionQuality: 0.1) ?? Data()
                    
                    AF.upload(multipartFormData: { multipartFormData in
                        multipartFormData.append(Data(title.utf8), withName: "title")
                        multipartFormData.append(Data(content.utf8), withName: "content")
                        multipartFormData.append(imageData, withName: "feed_img", fileName: "photo.jpg", mimeType: "jpg/png")
                    }, to: url)
                    .responseJSON {
                        response in
                        print(response)
                    }
                    
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 60)
                        .overlay(
                            Text("Upload!!")
                                .foregroundColor(.white)
                        )
                }.padding() // 업로드 버튼
            }//Vstack
            
            
           
            
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

struct CustomTextEditor: View {
    let placeholder: String
    @Binding var text: String
    let internalPadding: CGFloat = 0
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty  {
                Text(placeholder)
                    
                    .foregroundColor(Color.primary.opacity(0.3))
                    .padding(EdgeInsets(top: 7, leading: 0, bottom: 0, trailing: 0))
                    .padding(internalPadding)
            }
            TextEditor(text: $text)
                .padding(internalPadding)
        }.onAppear() {
            UITextView.appearance().backgroundColor = .clear
        }.onDisappear() {
            UITextView.appearance().backgroundColor = nil
        }
    }
}
