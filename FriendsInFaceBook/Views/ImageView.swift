//
//  ImageView.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 12/20/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation
import UIKit

// TODO: Use SnapKit

public class ImageView: UIView, Reusable {
    
    // MARK: -
    // MARK: Properties
    
    public let contentImageView = UIImageView()
    public var model: ImageModel? {
        didSet { self.fill(with: model) }
    }
    
    private let cancellableProperty = CancellableProperty()
    
    // MARK: -
    // MARK: Init and Deinit
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    // MARK: -
    // MARK: Open
    
    /// Prepares subviews. This method is called during init.
    /// - warning: This is an override point. Never call it directly.
    open func setup() {
        let imageView = self.contentImageView
        self.addSubview(imageView)
        imageView.frame = self.bounds
        
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.contentMode = .scaleAspectFill
    }
    
    open func prepareForReuse() {
        self.contentImageView.image = nil
        self.model = nil
    }
    
    // MARK: -
    // MARK: Private
    
    private func fill(with model: ImageModel?) {
        self.cancellableProperty.value = model?.load { [weak self] image in
            DispatchQueue.main.async {
                if lift(self?.model, model).map(==) ?? false {
                    self?.contentImageView.image = image
                }
            }
        }
    }
}
