
import Foundation
import UIKit

extension UIImage {
    public func toData() -> Data {
        return self.jpegData(compressionQuality: 0.7)!
    }
}
