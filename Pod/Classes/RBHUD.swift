//
//  RBHUD.swift
//
//  Created by Robert Bojor on 23/09/15.
//  Copyright © 2015 Robert Bojor. All rights reserved.
//

import UIKit
import QuartzCore

public class RBHUD: NSObject {
    
    public static let sharedInstance = RBHUD()
    
    // MARK: - Vars
    private var overlayView:UIView = UIView()
    private var parentView:UIView = UIView()
    private var progressView:UIImageView!
    private var progressImage = UIImage(named: "loader")
    private var titleLabel:UILabel!
    private var subtitleLabel:UILabel!
    private var subviewArray:Array<UIView>!
    
    private var finishedAnimations = false
    private var isLoaderShown = false
    private var wasTitleLabelInitialised = false
    private var wasSubtitleLabelInitialised = false
    private var wasProgressViewInitialised = false;
    
    private var titleLabelCurrentRect:CGRect!
    private var titleLabelTargetRect:CGRect!
    private var subtitleLabelCurrentRect:CGRect!
    private var subtitleLabelTargetRect:CGRect!
    private var progressViewCurrentRect:CGRect!
    private var progressViewTargetRect:CGRect!
    
    private let progressAnimationRepeatCount = 500.0
    private let progressAnimationDuration = 0.8
    
    public var backdropOpacity:CGFloat = 0.8
    public var backdropUsesBlur:Bool = true
    public var backdropBlurStyle:UIBlurEffectStyle = UIBlurEffectStyle.Dark
    public var backdropColor:UIColor = UIColor(red:0.23, green:0.26, blue:0.29, alpha:1)
    public var progressViewLineWidth:CGFloat = 1
    public var progressViewSize:CGFloat = 64.0
    public var progressViewPadding:CGFloat = 10.0
    public var progressViewStrokeColor:UIColor = UIColor.whiteColor()
    public var progressViewFillColor:UIColor = UIColor.clearColor()
    public var labelAnimationDistance:CGFloat = 50.0
    public var labelFontName:String = "HelveticaNeue-Light"
    public var labelTitleFontSize:CGFloat = 20.0
    public var labelTitleTextColor:UIColor = UIColor.whiteColor()
    public var labelSubtitleFontSize:CGFloat = 13.0
    public var labelSubtitleTextColor:UIColor = UIColor.whiteColor()
    
    public override init()
    {
        self.overlayView.alpha = 0
        
        self.progressView = UIImageView(frame: CGRectMake(0, 0, self.progressViewSize, self.progressViewSize))
        self.progressView.alpha = 0
        
        self.titleLabel = UILabel()
        self.titleLabel.numberOfLines = 0
        self.titleLabel.font = UIFont(name: self.labelFontName, size: self.labelTitleFontSize)
        self.titleLabel.tintColor = self.labelTitleTextColor
        self.titleLabel.textColor = self.labelTitleTextColor
        self.titleLabel.backgroundColor = UIColor.clearColor()
        self.titleLabel.textAlignment = NSTextAlignment.Center
        
        self.subtitleLabel = UILabel()
        self.subtitleLabel.numberOfLines = 0
        self.subtitleLabel.font = UIFont(name: self.labelFontName, size: self.labelSubtitleFontSize)
        self.subtitleLabel.tintColor = self.labelSubtitleTextColor
        self.subtitleLabel.textColor = self.labelSubtitleTextColor
        self.subtitleLabel.backgroundColor = UIColor.clearColor()
        self.subtitleLabel.textAlignment = NSTextAlignment.Center
    }
    
    // MARK: - Public methods
    public func showLoader(inView:UIView, withTitle:String?, withSubTitle:String?, withProgress:Bool)
    {
        self.setupOverlayView(inView)
        
        let willHaveTitle = (withTitle != nil) ? true : false
        let willHaveSubtitle = withSubTitle != nil ? true : false
        
        self.subviewArray = []
        if withProgress {
            self.setupProgressView()
            self.subviewArray.append(self.progressView)
        }
        if willHaveTitle {
            self.setupTitleLabel(withTitle!, withProgressView: withProgress, withSubtitle: willHaveSubtitle)
            self.subviewArray.append(self.titleLabel)
        }
        if willHaveSubtitle {
            self.setupSubtitleLabel(withSubTitle!, withProgressView: withProgress)
            self.subviewArray.append(self.subtitleLabel)
        }
        self.addSubviews()
        self.bringIntoView()
    }
    
    public func hideLoader()
    {
        self.removeFromView()
    }
    
    // MARK: - Private functions
    private func setupOverlayView(inView:UIView)
    {
        if !self.isLoaderShown {
            self.parentView = inView;
            self.overlayView = UIView(frame: inView.frame)
            self.overlayView.translatesAutoresizingMaskIntoConstraints = false
            if self.backdropUsesBlur {
                let blurEffect = UIBlurEffect(style: self.backdropBlurStyle)
                let blurView = UIVisualEffectView(frame: inView.frame)
                blurView.effect = blurEffect
                let vibrancyView: UIVisualEffectView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blurEffect))
                blurView.contentView.addSubview(vibrancyView)
                self.overlayView.addSubview(blurView)
            } else {
                self.overlayView.backgroundColor = self.backdropColor
            }
            self.overlayView.alpha = 0;
        }
    }
    
    private func setupProgressView()
    {
        if !self.wasProgressViewInitialised {
            self.progressView = UIImageView(frame: CGRectMake(0, 0, self.progressViewSize, self.progressViewSize))
            self.progressView.layer.addSublayer(self.setupProgressViewLayer())
            
            let progressWidth:CGFloat = self.progressView.frame.size.width
            let progressHeight:CGFloat = self.progressView.frame.size.height
            let progressX:CGFloat = (self.parentView.frame.size.width / 2) - (progressWidth / 2)
            let progressY:CGFloat = (self.parentView.frame.size.height / 2) - (progressHeight / 2)
            self.progressViewCurrentRect = CGRectMake(progressX, progressY, progressWidth, progressHeight)
            self.progressViewTargetRect = CGRectMake(progressX, progressY, progressWidth, progressHeight)
            self.progressView.frame = self.progressViewCurrentRect
        }
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = M_PI
        rotationAnimation.duration = self.progressAnimationDuration
        rotationAnimation.cumulative = true
        rotationAnimation.repeatCount = Float(self.progressAnimationRepeatCount)
        self.progressView.layer.addAnimation(rotationAnimation, forKey: "rotation")
        self.progressView.transform = CGAffineTransformMakeScale(0, 0)
        self.wasProgressViewInitialised = true
    }
    private func setupProgressViewLayer() -> CAShapeLayer
    {
        let boundsRect = CGRectMake(0, 0, self.progressViewSize, self.progressViewSize)
        let partialPath = UIBezierPath()
        partialPath.addArcWithCenter(CGPointMake(boundsRect.midX, boundsRect.midY), radius: boundsRect.width / 2, startAngle: 0 * CGFloat(M_PI)/180, endAngle: -45 * CGFloat(M_PI)/180, clockwise: true)
        
        let fullPath = UIBezierPath(ovalInRect: boundsRect)
        
        let fullCircle = CAShapeLayer()
        fullCircle.path = fullPath.CGPath
        fullCircle.bounds = CGPathGetBoundingBox(fullCircle.path)
        fullCircle.strokeColor = UIColor.clearColor().CGColor
        fullCircle.fillColor = self.progressViewFillColor.CGColor
        fullCircle.lineWidth = 0.0
        fullCircle.position = CGPointMake(0, 0)
        fullCircle.anchorPoint = CGPointMake(0, 0)
        
        let strokeLine = CAShapeLayer()
        strokeLine.path = partialPath.CGPath
        strokeLine.bounds = CGPathGetBoundingBox(strokeLine.path)
        strokeLine.strokeColor = self.progressViewStrokeColor.CGColor
        strokeLine.fillColor = UIColor.clearColor().CGColor
        strokeLine.lineWidth = self.progressViewLineWidth
        strokeLine.position = CGPointMake(0, 0)
        strokeLine.anchorPoint = CGPointMake(0, 0)
        strokeLine.addSublayer(fullCircle)
        
        return strokeLine
    }
    
    private func setupTitleLabel(havingTitle:String, withProgressView:Bool, withSubtitle:Bool)
    {
        self.titleLabel.text = havingTitle
        self.titleLabel.sizeToFit()
        let titleLabelWidth:CGFloat = self.parentView.frame.size.width - 40.0
        let titleLabelHeight:CGFloat = self.titleLabel.frame.size.height
        let titleLabelX:CGFloat = 20.0
        var titleLabelY:CGFloat = (self.parentView.frame.size.height / 2) - titleLabelHeight / 2
        
        if withSubtitle {
            titleLabelY -= titleLabelHeight / 2
        }
        if withProgressView {
            if !withSubtitle {
                titleLabelY -= titleLabelHeight / 2
            }
            let prevTransform = self.progressView.transform
            self.progressView.transform = CGAffineTransformMakeScale(1, 1)
            titleLabelY -= self.progressView.frame.size.height / 2
            self.progressView.transform = prevTransform
            titleLabelY -= self.progressViewPadding
        }
        self.titleLabelTargetRect = CGRectMake(titleLabelX, titleLabelY, titleLabelWidth, titleLabelHeight)
        self.titleLabelCurrentRect = self.titleLabel.frame
        
        if !self.wasTitleLabelInitialised {
            self.titleLabelCurrentRect = CGRectMake(titleLabelX, titleLabelY - self.labelAnimationDistance, titleLabelWidth, titleLabelHeight)
            self.titleLabel.frame = self.titleLabelCurrentRect
            self.titleLabel.alpha = 0
            wasTitleLabelInitialised = true
        }
    }
    
    private func setupSubtitleLabel(havingSubtitle:String, withProgressView:Bool)
    {
        self.subtitleLabel.text = havingSubtitle
        self.subtitleLabel.sizeToFit()
        
        let subtitleLabelWidth:CGFloat = self.parentView.frame.size.width - 40.0
        let subtitleLabelHeight:CGFloat = self.subtitleLabel.frame.size.height
        let subtitleLabelX:CGFloat = 20.0
        var subtitleLabelY:CGFloat = self.parentView.frame.size.height / 2
        if withProgressView {
            let prevTransform = self.progressView.transform
            self.progressView.transform = CGAffineTransformMakeScale(1, 1)
            subtitleLabelY += self.progressView.frame.size.height / 2
            self.progressView.transform = prevTransform
            subtitleLabelY += self.progressViewPadding
        }
        self.subtitleLabelTargetRect = CGRectMake(subtitleLabelX, subtitleLabelY, subtitleLabelWidth, subtitleLabelHeight)
        self.subtitleLabelCurrentRect = self.subtitleLabel.frame
        
        if !self.wasSubtitleLabelInitialised {
            self.subtitleLabelCurrentRect = CGRectMake(subtitleLabelX, subtitleLabelY + self.labelAnimationDistance, subtitleLabelWidth, subtitleLabelHeight)
            self.subtitleLabel.frame = subtitleLabelCurrentRect
            self.subtitleLabel.alpha = 0
            self.wasSubtitleLabelInitialised = true
        }
        
    }
    
    private func addSubviews()
    {
        
        for (_,subview) in self.subviewArray.enumerate() {
            if !self.overlayView.subviews.contains(subview) {
                self.overlayView.addSubview(subview)
            }
        }
        if !self.parentView.subviews.contains(self.overlayView) {
            self.parentView.addSubview(self.overlayView)
        }
    }
    
    private func bringIntoView()
    {
        self.finishedAnimations = false
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            if !self.isLoaderShown {
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.overlayView.alpha = self.backdropOpacity
                    }) { (Bool) -> Void in
                        self.finishedAnimations = true
                        self.isLoaderShown = true
                        self.parentView.userInteractionEnabled = false
                }
            }
            if self.subviewArray.contains(self.titleLabel) {
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.titleLabel.frame = self.titleLabelTargetRect
                    self.titleLabel.alpha = 1
                    }, completion:nil)
            } else {
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.titleLabel.alpha = 0
                    self.wasTitleLabelInitialised = false
                    }, completion:nil)
            }
            if self.subviewArray.contains(self.subtitleLabel) {
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.subtitleLabel.frame = self.subtitleLabelTargetRect
                    self.subtitleLabel.alpha = 1
                    }, completion:nil)
            } else {
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.subtitleLabel.alpha = 0
                    self.wasSubtitleLabelInitialised = false
                    }, completion:nil)
            }
            if self.subviewArray.contains(self.progressView) {
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.progressView.transform = CGAffineTransformMakeScale(1, 1)
                    self.progressView.frame = self.progressViewTargetRect
                    self.progressView.alpha = 1
                    }, completion:nil)
            } else {
                self.progressView.transform = CGAffineTransformMakeScale(1, 1)
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.progressView.alpha = 0
                    }, completion:nil)
            }
        })
    }
    
    private func removeFromView()
    {
        if self.parentView.subviews.contains(self.overlayView) {
            self.finishedAnimations = false
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    self.overlayView.alpha = 0
                    }) { (Bool) -> Void in
                        self.finishedAnimations = true
                        self.isLoaderShown = false
                        self.parentView.userInteractionEnabled = true
                        self.overlayView.removeFromSuperview()
                }
            })
        }
    }
}
