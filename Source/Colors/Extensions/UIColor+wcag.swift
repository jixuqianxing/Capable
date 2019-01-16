//
//  UIColor+wcag.swift
//  Capable
//
//  Created by Christoph Wendt on 20.11.18.
//

#if os(iOS) || os(tvOS) || os(watchOS)

import UIKit

/// Extension that adds functionality for calculating colors that conform to WCAG success criterias.
extension UIColor {

    /**
     Calculates the color ratio for a text color on a background color.
     
     - Parameters:
         - textColor: The text color.
         - backgroundColor: The background color.

     - Returns: The contrast ratio for a given pair of colors.

     - Warning: This function only accepts RGB compatible colors and will fail otherwise.
    */
    public class func getContrastRatio(forTextColor textColor: UIColor, onBackgroundColor backgroundColor: UIColor) -> CGFloat {
        let textColor = textColor.rgbaColor
        let backgroundColor = backgroundColor.rgbaColor

        return RGBAColor.getContrastRatio(forTextColor: textColor, onBackgroundColor: backgroundColor)
    }

    /**
     Returns the text color with the highest contrast (black or white) for a given background color.

     - Parameters:
        - backgroundColor: The background color.

     - Returns: A color that has the highest contrast with the given background color.

     - Warning: This function only accepts RGB compatible colors and will fail otherwise.
     */
    public class func getTextColor(onBackgroundColor backgroundColor: UIColor) -> UIColor {
        let textColor = RGBAColor.getTextColor(onBackgroundColor: backgroundColor.rgbaColor)

        return textColor == RGBAColor.Colors.black ? .black : .white
    }

    /**
     Calculates the contrast ratio of a given list of text colors and a background color. The first color that conforms to the conformance level defined gets returned. The default conformance level is .AA.

     - Parameters:
         - colors: A list of possible text colors.
         - font: The font used for the text.
         - backgroundColor: The background color that the text should be displayed on.
         - conformanceLevel: The conformance level that needs to be passed when calculating the contrast ratio. The default conformance level is .AA.

     - Returns: The first color that conforms to the conformance level defined.

     - Warning: This function only accepts RGB compatible colors and will fail otherwise.
     */
    public class func getTextColor(fromColors colors: [UIColor] = [], withFont font: UIFont, onBackgroundColor backgroundColor: UIColor, conformanceLevel: ConformanceLevel = .AA) -> UIColor? {
        let backgroundColor = backgroundColor.rgbaColor
        for textColor in colors {
            let isValidTextColor = RGBAColor.isValidColorCombination(textColor: textColor.rgbaColor, fontProps: font.fontProps, onBackgroundColor: backgroundColor, conformanceLevel: conformanceLevel)
            if isValidTextColor {
                return textColor
            }
        }

        return nil
    }

    /**
     Returns the background color with the highest contrast (black or white) for a given text color.

     - Parameters:
        - textColor: The textColor color.

     - Returns: A color that has the highest contrast with the given text color.

     - Warning: This function only accepts RGB compatible colors and will fail otherwise.
     */
    public class func getBackgroundColor(forTextColor textColor: UIColor) -> UIColor {
        let backgroundColor = RGBAColor.getBackgroundColor(forTextColor: textColor.rgbaColor)

        return backgroundColor == RGBAColor.Colors.black ? .black : .white
    }

    /**
     Calculates the contrast ratio of a given list of background colors and a text color. The first color that conforms to the conformance level defined gets returned. The default conformance level is .AA.

     - Parameters:
         - colors: A list of possible background colors.
         - font: The font used for the text.
         - textColor: The text color that should be used.
         - conformanceLevel: The conformance level that needs to be passed when calculating the contrast ratio. The default conformance level is .AA.

     - Returns: The first color that conforms to the conformance level defined.

     - Warning: This function only accepts RGB compatible colors and will fail otherwise.
     */
    public class func getBackgroundColor(fromColors colors: [UIColor], withFont font: UIFont, belowTextColor textColor: UIColor, conformanceLevel: ConformanceLevel = .AA) -> UIColor? {
        let textColor = textColor.rgbaColor

        for backgroundColor in colors {
            let isValidBackgroundColor = RGBAColor.isValidColorCombination(textColor: textColor, fontProps: font.fontProps, onBackgroundColor: backgroundColor.rgbaColor, conformanceLevel: conformanceLevel)
            if isValidBackgroundColor {
                return backgroundColor
            }
        }

        return nil
    }

    var rgbaColor: RGBAColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, white: CGFloat = 0, alpha: CGFloat = 0

        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return RGBAColor(red: red, green: green, blue: blue, alpha: alpha)
        } else if self.getWhite(&white, alpha: &alpha) {
            return RGBAColor(red: white, green: white, blue: white, alpha: alpha)
        } else {
            let errorMessage = "Calculating WCAG compliant colors is only supported for RGB compatible input colors."
            Logger.error(errorMessage)
            fatalError(errorMessage)
        }
    }
}

#endif
