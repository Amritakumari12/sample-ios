//
//  QRCodeViewerViewController.swift
//  OMGShop
//
//  Created by Mederic Petit on 13/2/18.
//  Copyright © 2017-2018 Omise Go Ptd. Ltd. All rights reserved.
//

import UIKit

class QRCodeViewerViewController: BaseViewController {

    var viewModel: QRCodeViewerViewModel!
    @IBOutlet weak var qrImageView: UIImageView!

    @IBOutlet weak var waitingForScanLabel: UILabel!

    lazy var alertController: UIAlertController = {
        let alert = UIAlertController(title: self.viewModel.consumptionRequestTitle,
                                      message: self.viewModel.consumptionRequestMessage(),
                                      preferredStyle: .alert)
        let rejectAction = UIAlertAction(title: self.viewModel.rejectButtonTitle, style: .destructive, handler: { [weak self] _ in
            self?.viewModel.reject()
            alert.dismiss(animated: true, completion: nil)
        })
        let approveAction = UIAlertAction(title: self.viewModel.approveButtonTitle, style: .default, handler: { [weak self] _ in
            self?.viewModel.approve()
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(rejectAction)
        alert.addAction(approveAction)
        return alert
    }()

    override func configureView() {
        super.configureView()
        self.waitingForScanLabel.text = self.viewModel.waitingLabel
        self.qrImageView.image = self.viewModel.transactionRequest.qrImage()
    }

    override func configureViewModel() {
        super.configureViewModel()
        self.viewModel.onConsumptionRequest = {
            self.present(self.alertController, animated: true, completion: nil)
        }
        self.viewModel.onFailApprove = { self.showError(withMessage: $0.message) }
        self.viewModel.onFailReject = { self.showError(withMessage: $0.message) }
        self.viewModel.onSuccessApprove = { self.showMessage($0) }
        self.viewModel.onSuccessReject = { self.showMessage($0) }
        self.viewModel.onLoadStateChange = { $0 ? self.showLoading() : self.hideLoading() }
    }

}
