import UIKit
import RxCocoa
import RxSwift

/// 닉네임 프로필 설정 시 프로필의 배경색을 조절하는 컬러 슬라이더
final class ColorSlider: UISlider {
    
    // MARK: - Rx
    
    private let colorSubject = PublishSubject<UIColor>()
    var colorObservable: Observable<UIColor> {
        return colorSubject.asObservable()
    }
    
    // MARK: - Propeties
    
    private let baseLayer = CALayer()
    private let trackLayer = CAGradientLayer()
    private let thumbView = ThumbView()
    private var color: UIColor
    
    public func setColor(color: UIColor) {
        self.color = color
    }
    // MARK: - Initializers
    
    /// 초기화 메서드
    /// - Parameter color: 색상 값
    init(color: UIColor) {
        self.color = color
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    /// 뷰가 그려질 때 호출되는 메서드
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        configure()
    }

    // MARK: - Configuration
    
    /// 초기 설정을 진행하는 메서드
    private func configure() {
        clearDefaultStyle()
        createBaseLayer()
        createThumbView()
        configureTrackLayer()
        addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
    }

    /// 기본 스타일을 제거하는 메서드
    private func clearDefaultStyle() {
        self.value = 1.0
        tintColor = .clear
        backgroundColor = .clear
        maximumTrackTintColor = .clear
        minimumTrackTintColor = .clear
        thumbTintColor = .clear
    }

    /// 배경 레이어를 설정하는 메서드
    private func createBaseLayer() {
        baseLayer.backgroundColor = UIColor.white.cgColor
        baseLayer.frame = CGRect(x: 0,
                                 y: frame.height / 4,
                                 width: frame.width,
                                 height: frame.height / 2)
        baseLayer.cornerRadius = baseLayer.frame.height / 2
        layer.insertSublayer(baseLayer, at: 0)
    }

    /// 트랙 레이어를 설정하는 메서드
    private func configureTrackLayer() {
        let light = getLightColor(overlay: color, overlayAlpha: 0.2).cgColor
        let dark = color.cgColor
        trackLayer.colors = [light, dark]
        trackLayer.startPoint = CGPoint(x: 0, y: 0.5)
        trackLayer.endPoint = CGPoint(x: 1, y: 0.5)
        trackLayer.frame = CGRect(x: 0,
                                  y: frame.height / 4,
                                  width: frame.width,
                                  height: frame.height / 2)
        trackLayer.cornerRadius = trackLayer.frame.height / 2
        layer.insertSublayer(trackLayer, above: baseLayer)
    }
    
    /// 두 색상을 alpha 값을 반영하여 혼합하는 메서드
    private func getLightColor(base: UIColor = .white, overlay: UIColor, overlayAlpha: CGFloat) -> UIColor {
        var br: CGFloat = 0, bg: CGFloat = 0, bb: CGFloat = 0, ba: CGFloat = 0
        var or: CGFloat = 0, og: CGFloat = 0, ob: CGFloat = 0, oa: CGFloat = 0

        base.getRed(&br, green: &bg, blue: &bb, alpha: &ba)
        overlay.getRed(&or, green: &og, blue: &ob, alpha: &oa)

        let alpha = overlayAlpha
        let r = or * alpha + br * (1 - alpha)
        let g = og * alpha + bg * (1 - alpha)
        let b = ob * alpha + bb * (1 - alpha)

        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }

    /// Thumb view를 생성하는 메서드
    private func createThumbView() {
        let size = (2 * frame.height) / 3
        thumbView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        thumbView.layer.masksToBounds = true
        thumbView.layer.borderWidth = 1
        thumbView.layer.borderColor = UIColor.lightGray.cgColor
        thumbView.layer.cornerRadius = size / 2
        thumbView.centerDot.backgroundColor = getThumbColor(from: 1.0)
        colorSubject.onNext(getThumbColor(from: 1.0))
        thumbView.backgroundColor = .white
        updateThumbImage()
    }

    /// Thumb의 이미지를 업데이트하는 메서드
    private func updateThumbImage() {
        let image = thumbView.snapshot
        setThumbImage(image, for: .normal)
        setThumbImage(image, for: .highlighted)
    }

    /// 슬라이더의 값에 맞는 Thumb 색상을 계산하는 메서드
    private func getThumbColor(from value: CGFloat) -> UIColor {
        let alpha = 0.8 * value + 0.2
        
        func blend(_ fg: CGFloat, _ alpha: CGFloat) -> CGFloat {
            return (1.0 - alpha) * 1.0 + fg * alpha
        }
        
        guard let rgb = color.getRGBComponents() else {
            return color // 값 추출 실패시 원본 색 반환
        }
        
        let r = blend(rgb.r, alpha)
        let g = blend(rgb.g, alpha)
        let b = blend(rgb.b, alpha)

        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    // MARK: - Action
    
    /// 값이 변경되었을 때 호출되는 메서드
    @objc private func valueChanged(_ sender: ColorSlider) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        let thumbColor = getThumbColor(from: CGFloat(sender.value))
        thumbView.centerDot.backgroundColor = thumbColor
        colorSubject.onNext(thumbColor)
        updateThumbImage()
        CATransaction.commit()
    }
    
    public func colorChanged(color: UIColor) {
        self.color = color
        self.value = 1.0
        configure()
    }
}

// MARK: - ThumbView

final class ThumbView: UIView {
    let centerDot = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    /// Thumb view의 설정을 초기화하는 메서드
    private func setup() {
        let dotSize = CGFloat(40).adjusted
        centerDot.frame = CGRect(x: bounds.midX - dotSize / 2,
                                 y: bounds.midY - dotSize / 2,
                                 width: dotSize,
                                 height: dotSize)
        centerDot.backgroundColor = .white
        centerDot.layer.cornerRadius = dotSize / 2
        centerDot.isUserInteractionEnabled = false
        
        addSubview(centerDot)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        centerDot.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
}
