//
//  CreateTravelRewindViewController.swift
//  WithYou
//
//  Created by bryan on 9/23/24.
//

import RxCocoa
import RxGesture
import RxSwift
import UIKit
import SnapKit

protocol CreateTravelViewControllerDelgate {
    func openMoodPopup(_ delegate : MoodPopupDelegate)
    func dismiss()
}

class CreateTravelRewindViewController: BaseViewController{
    
    private let rewindView = CreateTravelRewindView()
    
    private let viewModel : CreateTravelRewindViewModel
    
    private let moodPopup = MoodPopupViewController()
    
    public var coordinator : CreateTravelViewControllerDelgate?
    
    init(viewModel : CreateTravelRewindViewModel){
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData()
    }
    
    override func setUp() {
        view.addSubview(rewindView)
    }
    
    override func setLayout() {
        rewindView.snp.makeConstraints{
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    override func setUpViewProperty() {
        view.backgroundColor = .white
        rewindView.titleLabel.text = viewModel.log.title
        rewindView.dayLabel.text = dateController.days(from: viewModel.log.startDate)
    }
    
    override func setFunc() {
        rewindView.selectImageButton
            .rx
            .tap
            .withUnretained(self)
            .subscribe { (owner, _) in
                owner.coordinator?.openMoodPopup(owner)
            }
            .disposed(by: disposeBag)
        
        viewModel.rewindQnaSubject
            .withUnretained(self)
            .subscribe { (owner, rewindQna) in
                [owner.rewindView.question2Label,owner.rewindView.question3Label,owner.rewindView.question4Label, owner.rewindView.question5Label].enumerated().forEach { (index, label) in
                    label.text = "#\(index + 2) " + rewindQna[index].content
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.travelersSubject
            .bind(to: self.rewindView.collectionView.rx.items(cellIdentifier: MemberCell.id, cellType: MemberCell.self)){ index, item, cell in
                cell.bind(traveler: item)
    
            }
            .disposed(by: disposeBag)
        
        rewindView.collectionView
            .rx
            .modelSelected(Traveler.self)
            .withUnretained(self)
            .subscribe { (owner, travler) in
                owner.viewModel.selectMVP(travler)
                owner.viewModel.checkInputs()
            }
            .disposed(by: disposeBag)
        
        viewModel.buttonColorRelay
            .map{ $0 ? WithYouAsset.mainColorDark.color : WithYouAsset.subColor.color }
            .bind(to: rewindView.addButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        rewindView.question2TextField
            .rx
            .text
            .orEmpty
            .withUnretained(self)
            .subscribe { (owner,text) in
                owner.viewModel.textField2String = text
            }
            .disposed(by: disposeBag)
        
        rewindView.question3TextField
            .rx
            .text
            .orEmpty
            .withUnretained(self)
            .subscribe { (owner,text) in
                owner.viewModel.textField3String = text
            }
            .disposed(by: disposeBag)
        
        rewindView.question4TextField
            .rx
            .text
            .orEmpty
            .withUnretained(self)
            .subscribe { (owner,text) in
                owner.viewModel.textField4String = text
            }
            .disposed(by: disposeBag)
        
        rewindView.question5TextField
            .rx
            .text
            .orEmpty
            .withUnretained(self)
            .subscribe { (owner,text) in
                owner.viewModel.textField5String = text
            }
            .disposed(by: disposeBag)
        
        rewindView.addButton
            .rx
            .tap
            .withUnretained(self)
            .subscribe { (owner, _) in
                owner.viewModel.createRewind()
                owner.coordinator?.dismiss()
            }
            .disposed(by: disposeBag)
    }
    
    override func setDelegate() {
        rewindView.question2TextField.delegate = self
        rewindView.question3TextField.delegate = self
        rewindView.question4TextField.delegate = self
        rewindView.question5TextField.delegate = self
    }
}

extension CreateTravelRewindViewController: MoodPopupDelegate {
    func didSelectMood(data: UIImage) {
        rewindView.selectImageButton.setImage(data, for: .normal)
        viewModel.moodImageTags.forEach{ tag in
            if UIImage(named: tag) == data {
                viewModel.moodTag = tag
            }
        }
        rewindView.selectImageButton.snp.remakeConstraints { make in
            // Set the desired size (e.g., width: 50, height: 50)
            make.width.height.equalTo(40)
            make.center.equalTo(rewindView.moodImageView)
        }
    }
}


///MARK: UITextFieldDelegate
extension CreateTravelRewindViewController: UITextFieldDelegate {
    //화면 터치시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.viewModel.checkInputs()
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //rewindView.scrollView.scrollsToTop = true
        if textField == rewindView.question5TextField || textField == rewindView.question4TextField {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= 200
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == rewindView.question5TextField || textField == rewindView.question4TextField {
            if view.frame.origin.y != 0 {
                view.frame.origin.y = 0
            }
        }
    }
    
    // return button 눌렀을 떄
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        self.view.endEditing(true)
        return true
    }
}
