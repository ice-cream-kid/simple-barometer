//
//  GaugeView.swift
//  simple-barometer
//
//  Created by Michael Johnson on 2/13/23.
//

import UIKit

class GaugeView: UIView {

    var outerBezelColor = UIColor.clear
    var outerBezelWidth: CGFloat = 0

    var innerBezelColor = UIColor.clear
    var innerBezelWidth: CGFloat = 0

    var insideColor = UIColor.clear
    
    var segmentThickness: CGFloat = 20
    var segmentWidth: CGFloat = 20

    var segmentColors = [UIColor.red,
                         UIColor.yellow,
                         UIColor.green,
                         UIColor.yellow,
                         UIColor.red]
    
    let majorSegmentsCount = 2
    
    var totalAngle: CGFloat = 270
    var rotation: CGFloat = -135
    
    var majorTickColor = UIColor.black
    var majorTickWidth: CGFloat = 2
    var majorTickLength: CGFloat = 25

    var minorTickColor = UIColor.black.withAlphaComponent(0.5)
    var minorTickWidth: CGFloat = 1
    var minorTickLength: CGFloat = 20
    var minorTickCountPerSegment = 9
    var minorTickCount = 3
    
    var outerCenterDiscColor = UIColor.white
    var outerCenterDiscWidth: CGFloat = 35
    var innerCenterDiscColor = UIColor.white
    var innerCenterDiscWidth: CGFloat = 25
    
    var needleColor = UIColor.white
    var needleWidth: CGFloat = 3
    let needle = UIView()
    
    let valueLabel = UILabel()
    var valueFont = UIFont.systemFont(ofSize: 33)
    var valueColor = UIColor.white
    
    var value: Double = 0.0 {
        didSet {
        
            valueLabel.alpha = 0.0
            
            // update the value label to show the exact number
            valueLabel.text = String(format: "%.2f", value)
            
            var firstNumber = 0.0

            if (value <= 29.99) {
                firstNumber = 0.0

            } else if (value > 29.99 && value < 31) {
                firstNumber = 1.0
            }

            value = value.truncatingRemainder(dividingBy: 1)
            value = value + firstNumber
            
            // figure out where the needle is, between 0 and 1
            let needlePosition = CGFloat(value) / 2

            // create a lerp from the start angle (rotation) through to the end angle (rotation + totalAngle)
            let lerpFrom = rotation
            let lerpTo = rotation + totalAngle

            // lerp from the start to the end position, based on the needle's position
            let needleRotation = lerpFrom + (lerpTo - lerpFrom) * needlePosition
            needle.transform = CGAffineTransform(rotationAngle: deg2rad(needleRotation))
            valueLabel.alpha = 1.0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {

        needle.backgroundColor = needleColor
        needle.translatesAutoresizingMaskIntoConstraints = false

        // make the needle a third of our height
        needle.bounds = CGRect(x: 0, y: 0, width: needleWidth, height: bounds.height / 3)

        // align it so that it is positioned and rotated from the bottom center
        needle.layer.anchorPoint = CGPoint(x: 0.5, y: 1)

        // now center the needle over our center point
        needle.center = CGPoint(x: bounds.midX, y: bounds.midY)
        addSubview(needle)
        
        valueLabel.font = valueFont
        valueLabel.textColor = valueColor
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(valueLabel)

        NSLayoutConstraint.activate([
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -75)
        ])
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        drawBackground(in: rect, context: ctx)
        
        drawSegments(in: rect, context: ctx)
        drawTicks(in: rect, context: ctx)

        drawCenterDisc(in: rect, context: ctx)
    }
    
    func drawBackground(in rect: CGRect, context ctx: CGContext) {
        
        // draw the outer bezel as the largest circle
        outerBezelColor.set()
        ctx.fillEllipse(in: rect)

        // move in a little on each edge, then draw the inner bezel
        let innerBezelRect = rect.insetBy(dx: outerBezelWidth, dy: outerBezelWidth)
        innerBezelColor.set()
        ctx.fillEllipse(in: innerBezelRect)

        // finally, move in some more and draw the inside of our gauge
        let insideRect = innerBezelRect.insetBy(dx: innerBezelWidth, dy: innerBezelWidth)
        insideColor.set()
        ctx.fillEllipse(in: insideRect)
    }
    
    func drawSegments(in rect: CGRect, context ctx: CGContext) {

        // 1: Save the current drawing configuration
        ctx.saveGState()

        // 2: Move to the center of our drawing rectangle and rotate so that we're pointing at the start of the first segment
        ctx.translateBy(x: rect.midX, y: rect.midY)
        ctx.rotate(by: deg2rad(rotation) - (.pi / 2))

        // 3: Set up the user's line width
        ctx.setLineWidth(segmentThickness)
        
        // 5: Calculate how thick the segment arcs should be
        let segmentRadius = (((rect.width - segmentThickness) / 2) - outerBezelWidth) - innerBezelWidth
        
        // 6: Draw each segment
        for (index, color) in segmentColors.enumerated() {
            
            let segmentAngle = deg2rad(getAngleForIndex(index: index))
            // figure out where the segment starts in our arc
            let start = deg2rad(CGFloat(getStartPointForIndex(index: index)))
            // activate its color, add a path for the segment, and stroke it using the activated color
            color.set()
            ctx.addArc(center: .zero, radius: segmentRadius, startAngle: start, endAngle: start + segmentAngle, clockwise: false)
            ctx.drawPath(using: .stroke)
        }

        // 7: Reset the graphics state
        ctx.restoreGState()
    }
    
    func drawTicks(in rect: CGRect, context ctx: CGContext) {
       
        // save our clean graphics state
        ctx.saveGState()
        ctx.translateBy(x: rect.midX, y: rect.midY)
        ctx.rotate(by: deg2rad(rotation) - (.pi / 2))

        let segmentAngle = deg2rad(totalAngle / CGFloat(majorSegmentsCount))
        
        let segmentRadius = (((rect.width - segmentThickness) / 2) - outerBezelWidth) - innerBezelWidth

        // save the graphics state where we've moved to the center and rotated towards the start of the first segment
        ctx.saveGState()

        // draw major ticks
        ctx.setLineWidth(majorTickWidth)
        majorTickColor.set()
        let majorEnd = segmentRadius + (segmentThickness / 2)
        let majorStart = majorEnd - majorTickLength
        
        for _ in 0 ... majorSegmentsCount {
            ctx.move(to: CGPoint(x: majorStart, y: 0))
            ctx.addLine(to: CGPoint(x: majorEnd, y: 0))
            ctx.drawPath(using: .stroke)
            ctx.rotate(by: segmentAngle)
        }

        ctx.restoreGState()
        ctx.saveGState()

        // draw minor ticks
        ctx.setLineWidth(minorTickWidth)
        minorTickColor.set()
        
        let minorTickSliceSize = segmentAngle / CGFloat(minorTickCountPerSegment + 1)
        let minorEnd = segmentRadius + (segmentThickness / 2)
        let minorStart = minorEnd - minorTickLength
        
        for _ in 0 ..< majorSegmentsCount {
            ctx.rotate(by: minorTickSliceSize)

            for _ in 0 ..< minorTickCountPerSegment {
                ctx.move(to: CGPoint(x: minorStart, y: 0))
                ctx.addLine(to: CGPoint(x: minorEnd, y: 0))
                ctx.drawPath(using: .stroke)
                ctx.rotate(by: minorTickSliceSize)
            }
        }

        // go back to the graphics state where we've moved to the center and rotated towards the start of the first segment
        ctx.restoreGState()

        // go back to the original graphics state
        ctx.restoreGState()
    }
    
    func drawCenterDisc(in rect: CGRect, context ctx: CGContext) {
        
        ctx.saveGState()
        ctx.translateBy(x: rect.midX, y: rect.midY)

        let outerCenterRect = CGRect(x: -outerCenterDiscWidth / 2, y: -outerCenterDiscWidth / 2, width: outerCenterDiscWidth, height: outerCenterDiscWidth)
        outerCenterDiscColor.set()
        ctx.fillEllipse(in: outerCenterRect)

        let innerCenterRect = CGRect(x: -innerCenterDiscWidth / 2, y: -innerCenterDiscWidth / 2, width: innerCenterDiscWidth, height: innerCenterDiscWidth)
        innerCenterDiscColor.set()
        ctx.fillEllipse(in: innerCenterRect)
        ctx.restoreGState()
    }
    
    func originalDrawTicks(in rect: CGRect, context ctx: CGContext) {
          
           // save our clean graphics state
           ctx.saveGState()
           ctx.translateBy(x: rect.midX, y: rect.midY)
           ctx.rotate(by: deg2rad(rotation) - (.pi / 2))

           let segmentAngle = deg2rad(totalAngle / CGFloat(segmentColors.count))

           let segmentRadius = (((rect.width - segmentThickness) / 2) - outerBezelWidth) - innerBezelWidth

           // save the graphics state where we've moved to the center and rotated towards the start of the first segment
           ctx.saveGState()

           // draw major ticks
           ctx.setLineWidth(majorTickWidth)
           majorTickColor.set()
           let majorEnd = segmentRadius + (segmentThickness / 2)
           let majorStart = majorEnd - majorTickLength
           
           for _ in 0 ... segmentColors.count {
               ctx.move(to: CGPoint(x: majorStart, y: 0))
               ctx.addLine(to: CGPoint(x: majorEnd, y: 0))
               ctx.drawPath(using: .stroke)
               ctx.rotate(by: segmentAngle)
           }

           // go back to the state we had before we drew the major ticks
           ctx.restoreGState()

           // save it again, because we're about to draw the minor ticks
           ctx.saveGState()

           // draw minor ticks
           ctx.setLineWidth(minorTickWidth)
           minorTickColor.set()
           
           let minorTickSize = segmentAngle / CGFloat(minorTickCount + 1)
           
           let minorEnd = segmentRadius + (segmentThickness / 2)
           let minorStart = minorEnd - minorTickLength
           
           for _ in 0 ..< segmentColors.count {
               ctx.rotate(by: minorTickSize)

               for _ in 0 ..< minorTickCount {
                   ctx.move(to: CGPoint(x: minorStart, y: 0))
                   ctx.addLine(to: CGPoint(x: minorEnd, y: 0))
                   ctx.drawPath(using: .stroke)
                   ctx.rotate(by: minorTickSize)
               }
           }

           // go back to the graphics state where we've moved to the center and rotated towards the start of the first segment
           ctx.restoreGState()

           // go back to the original graphics state
           ctx.restoreGState()
       }
    
    func originalDrawSegments(in rect: CGRect, context ctx: CGContext) {

        // 1: Save the current drawing configuration
        ctx.saveGState()

        // 2: Move to the center of our drawing rectangle and rotate so that we're pointing at the start of the first segment
        ctx.translateBy(x: rect.midX, y: rect.midY)
        ctx.rotate(by: deg2rad(rotation) - (.pi / 2))

        // 3: Set up the user's line width
        ctx.setLineWidth(segmentWidth)

        // 4: Calculate the size of each segment in the total gauge
        let segmentAngle = deg2rad(totalAngle / CGFloat(segmentColors.count))

        // 5: Calculate how wide the segment arcs should be
        let segmentRadius = (((rect.width - segmentWidth) / 2) - outerBezelWidth) - innerBezelWidth

        // 6: Draw each segment
        for (index, segment) in segmentColors.enumerated() {
            // figure out where the segment starts in our arc
            let start = CGFloat(index) * segmentAngle

            // activate its color
            segment.set()

            // add a path for the segment
            ctx.addArc(center: .zero, radius: segmentRadius, startAngle: start, endAngle: start + segmentAngle, clockwise: false)

            // and stroke it using the activated color
            ctx.drawPath(using: .stroke)
        }

        // 7: Reset the graphics state
        ctx.restoreGState()
    }
    
    // MARK: Helpers
    
    func deg2rad(_ number: CGFloat) -> CGFloat {
        
        return number * .pi / 180
    }
    
    func getStartPointForIndex(index : Int) -> Double {
        
        if (index == 0) {
            return 0.0
            
        } else {
            
            // new start point is last start point + last angle
            return (getStartPointForIndex(index: index - 1) + getAngleForIndex(index: index - 1))
        }
    }
    
    func getAngleForIndex(index : Int) -> Double {
        
        switch index {
            case 0:
                return (7/20) * 270
            case 1:
                return (1/20) * 270
            case 2:
                return (7/20) * 270
            case 3:
                return (4/20) * 270
            case 4:
                return (1/20) * 270
            default:
                return 0
        }
    }
}
