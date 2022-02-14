//
//  KochView.swift
//  Koch-Snowflake
//
//  Created by Katelyn Lydeen on 2/14/22.
//  Based on code created by Jeff Terry on 1/19/22.
//

import Foundation
import SwiftUI

struct KochView: View {
    @Binding var kochVertices : [(xPoint: Double, yPoint: Double)]
    
    var body: some View {
        //Create the displayed View
        KochFractalShape(KochPoints: kochVertices)
            .stroke(Color.red, lineWidth: 1)
            .frame(width: 600, height: 600)
            .background(Color.white)
    }
    
    /// KochFractalShape
    ///
    /// calculates the Shape displayed in the Koch Fractal View
    ///
    /// - Parameters:
    ///   - KochPoints: array of tuples containing the Koch Fractal Vertices
    ///
    struct KochFractalShape: Shape {
        
        var KochPoints: [(xPoint: Double, yPoint: Double)] = []  ///Array of tuples
        
        /// path
        ///
        /// - Parameter rect: rect in which to draw the path
        /// - Returns: path for the Shape
        ///
        func path(in rect: CGRect) -> Path {
            

            // Create the Path for the Koch Fractal
            var path = Path()
            
            if KochPoints.isEmpty {
                
                return path
            }

            // move to the initial position
            path.move(to: CGPoint(x: KochPoints[0].xPoint, y: KochPoints[0].yPoint))

            // loop over all our points to draw create the paths
            for item in 1..<(KochPoints.endIndex)  {
            
                path.addLine(to: CGPoint(x: KochPoints[item].xPoint, y: KochPoints[item].yPoint))
                                
            }

            return (path)
        }
    }
}
    

struct KochView_Previews: PreviewProvider {
    @State static var myKochVertices = [(xPoint:75.0, yPoint:25.0), (xPoint:32.0, yPoint:22.0), (xPoint:210.0, yPoint:78.0), (xPoint:75.0, yPoint:25.0)]
    
    static var previews: some View {
        KochView(kochVertices: $myKochVertices)
    }
}
