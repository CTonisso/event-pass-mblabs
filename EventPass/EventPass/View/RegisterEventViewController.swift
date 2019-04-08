//
//  RegisterEventViewController.swift
//  EventPass
//
//  Created by Carlos Marcelo Tonisso Junior on 4/5/19.
//  Copyright © 2019 Carlos Marcelo Tonisso Junior. All rights reserved.
//

import UIKit
import Cartography
import GeoFire
import FirebaseDatabase
import CodableFirebase

class RegisterEventViewController: UIViewController, UINavigationControllerDelegate {
    
    lazy var viewModel = RegisterEventViewModel(self.navigationController)
    
    lazy var firebaseRef = Database.database().reference().child("events")
    lazy var geoFire = GeoFire(firebaseRef: firebaseRef)
    let geocoder = CLGeocoder()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 12
        view.distribution = .fill
        view.axis = .vertical
        view.alignment = .center
        view.backgroundColor = .clear
        return view
    }()
    
    let eventPhotoImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "photo-camera")
        view.contentMode = UIImageView.ContentMode.scaleAspectFit
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    let nameTextField: EPTextField = {
        let view = EPTextField()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3
        view.font = UIFont(name: "Avenir-Book", size: 16)
        view.textColor = .highlightYellow
        view.attributedPlaceholder = NSAttributedString(string: "Nome", attributes: [NSAttributedString.Key.foregroundColor: UIColor.highlightYellow])
        view.leftPadding = 20
        view.keyboardType = .default
        view.clipsToBounds = true
        return view
    }()
    
    let addressTextField: EPTextField = {
        let view = EPTextField()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3
        view.font = UIFont(name: "Avenir-Book", size: 16)
        view.textColor = .highlightYellow
        view.attributedPlaceholder = NSAttributedString(string: "Endereço", attributes: [NSAttributedString.Key.foregroundColor: UIColor.highlightYellow])
        view.leftPadding = 20
        view.keyboardType = .default
        view.clipsToBounds = true
        return view
    }()
    
    let dateTextField: EPTextField = {
        let view = EPTextField()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3
        view.font = UIFont(name: "Avenir-Book", size: 16)
        view.textColor = .highlightYellow
        view.attributedPlaceholder = NSAttributedString(string: "Data", attributes: [NSAttributedString.Key.foregroundColor: UIColor.highlightYellow])
        view.leftPadding = 20
        view.keyboardType = .default
        view.clipsToBounds = true
        return view
    }()
    
    let descriptionTextField: EPTextField = {
        let view = EPTextField()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3
        view.font = UIFont(name: "Avenir-Book", size: 16)
        view.textColor = .highlightYellow
        view.attributedPlaceholder = NSAttributedString(string: "Descrição", attributes: [NSAttributedString.Key.foregroundColor: UIColor.highlightYellow])
        view.leftPadding = 20
        view.keyboardType = .default
        view.clipsToBounds = true
        return view
    }()
    
    let createEventButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(buildEvent), for: .touchUpInside)
        button.setTitle("Criar evento", for: .normal)
        button.backgroundColor = .highlightYellow
        button.setTitleColor(.baseBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Black", size: 18)
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.observeKeyboard()
        self.hideKeyboardWhenTappedAround()
        setupInitialState()
    }
    
    func setupInitialState() {
        self.view.backgroundColor = .baseBlue
        setupScrollView()
        setupStackView()
        setupEventPhotoImageView()
        setupNameTextField()
        setupAddressTextField()
        setupDateTextField()
        setupDescriptionTextField()
        setupButton()
    }
    
    func setupScrollView() {
        self.view.addSubview(scrollView)
        constrain(scrollView) { view in
            guard let superview = view.superview else { return }
            view.width == superview.width
            view.bottom == superview.bottom
            view.top == superview.top
            view.centerX == superview.centerX
        }
    }
    
    func setupStackView() {
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(eventPhotoImageView)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(addressTextField)
        stackView.addArrangedSubview(dateTextField)
        stackView.addArrangedSubview(descriptionTextField)
        stackView.addArrangedSubview(createEventButton)
        constrain(stackView) { view in
            guard let superview = view.superview else { return }
            view.top == superview.top
            view.bottom == superview.bottom
            view.width == superview.width
            view.centerX == superview.centerX
        }
    }
    
    func setupEventPhotoImageView() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        eventPhotoImageView.isUserInteractionEnabled = true
        eventPhotoImageView.addGestureRecognizer(gestureRecognizer)
        constrain(eventPhotoImageView) { photo in
            guard let superview = photo.superview else { return }
            photo.width == superview.width * 0.8
            photo.height == superview.width * 0.6
            photo.centerX == superview.centerX
        }
    }
    
    func setupNameTextField() {
        constrain(nameTextField) { view in
            guard let superview = view.superview else { return }
            view.width == superview.width * 0.87
            view.height == 52
        }
        
        nameTextField.layer.cornerRadius = 26
    }
    
    func setupAddressTextField() {
        constrain(addressTextField) { view in
            guard let superview = view.superview else { return }
            view.width == superview.width * 0.87
            view.height == 52
        }
        
        addressTextField.layer.cornerRadius = 26
    }
    
    func setupDateTextField() {
        constrain(dateTextField) { view in
            guard let superview = view.superview else { return }
            view.width == superview.width * 0.87
            view.height == 52
        }
        
        dateTextField.layer.cornerRadius = 26
    }
    
    func setupDescriptionTextField() {
        constrain(descriptionTextField) { view in
            guard let superview = view.superview else { return }
            view.width == superview.width * 0.87
            view.height == 52
        }
        
        descriptionTextField.layer.cornerRadius = 26
    }
    
    func setupButton() {
        constrain(createEventButton) { button in
            guard let superview = button.superview else { return }
            button.width == superview.width * 0.6
            button.height == 40
        }
        
        createEventButton.layer.cornerRadius = 20
    }

    @objc func buildEvent() {
        let event = Event()
        event.name = nameTextField.text
        event.address = addressTextField.text
        event.date = dateTextField.text
        event.description = descriptionTextField.text
        if let eventImage = eventPhotoImageView.image {
            viewModel.uploadMedia(image: eventImage) { (url) in
                event.imageURL = url
                self.createEvent(event: event)
            }
        }
    }
    
    func createEvent(event: Event) {
        let data = try! FirebaseEncoder().encode(event)
        
        geocoder.geocodeAddressString(event.address!) { (placemarks, error) in
            if error == nil {
                guard let location = placemarks?.first!.location! else { return }
                let eventUUID = UUID().uuidString
                Database.database().reference().child("events").child(eventUUID).setValue(data) { (error, reference) in
                    if error != nil {
                        print("Erro ao tentar salvar o objeto evento no banco: \(error)")
                        return
                    }
                    
                    if reference.key != nil {
                        self.geoFire.setLocation(location, forKey: reference.key!)
                    }
                    
                }
            }
            
            print("Erro ao tentar encontrar a localização pelo Geocoder: \(error)")
        }
    }
    
    @objc func selectImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = true
        
        self.present(imagePickerController, animated: true)
    }
}

extension RegisterEventViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        eventPhotoImageView.image = image

        self.dismiss(animated: true, completion: nil)
    }
}
