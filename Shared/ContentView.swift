//
//  ContentView.swift
//  Shared
//
//  Created by Katelyn Lydeen on 2/14/22.
//  Based on code created by Jeff Terry on 1/19/22.
//

import SwiftUI

struct ContentView: View {
    @State var totalIterationsString = "10"
    @State var guess = ""
    // @State private var totalIterations: Int? = 10
    @State private var kochAngle: Int? = 4
    @State var editedKochAngle: Int? = 4
    @State var editedTotalIterations: Int? = 10
    @State var viewArray :[AnyView] = []
    
    private var intFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        return f
    }()
    
    // Setup the GUI to monitor the data from the Koch Fractal Calculator
    /*
    @ObservedObject var kochFractalSmall = KochFractal(withData: true)
    @ObservedObject var kochFractalSmall2 = KochFractal(withData: true)
    @ObservedObject var kochFractalSmall3 = KochFractal(withData: true)
    @ObservedObject var kochFractalSmall4 = KochFractal(withData: true)
    @ObservedObject var kochFractalSmall5 = KochFractal(withData: true)
     */
    @ObservedObject var kochFractalLarge = KochFractal(withData: true)
    
    //Setup the GUI View
    var body: some View {
        HStack{
            VStack{
                VStack(alignment: .center) {
                    Text("Total iterations")
                        .font(.callout)
                        .bold()
                    TextField("# Total iterations", text: $totalIterationsString)
                        .padding()
                }
                
                /*
                Button("Sync", action: {Task.init{
                    
                    print("Start time \(Date())\n")
                    await self.calculateSyncKoch()}})
                    .padding()
                    .frame(width: 100.0)
                    .disabled(kochFractalLarge.enableButton == false)
                 */
                
                Button("Calculate", action: {Task.init{
                    
                    print("Start time \(Date())\n")
                    await self.calculateKoch()}})
                    .padding()
                    //.frame(width: 100.0)
                    .disabled(kochFractalLarge.enableButton == false)
                
                Button("Clear", action: {Task.init{
                    
                    await self.clear()}})
                    .padding(.bottom, 5.0)
                    .disabled(kochFractalLarge.enableButton == false)
                
                if (!kochFractalLarge.enableButton){
                    
                    ProgressView()
                }
                
            }
            .padding()
            
            //DrawingField
            
            KochView(kochVertices: $kochFractalLarge.kochVerticesForPath)
                .padding()
                .aspectRatio(1, contentMode: .fit)
                .drawingGroup()
            // Stop the window shrinking to zero.
            Spacer()
            
            /*
            HStack{
                KochView(kochVertices: $kochFractalSmall.kochVerticesForPath)
                    .padding()
                    .aspectRatio(1, contentMode: .fit)
                    .drawingGroup()
                // Stop the window shrinking to zero.
                Spacer()
                
                KochView(kochVertices: $kochFractalLarge.kochVerticesForPath)
                    .padding()
                    .aspectRatio(1, contentMode: .fit)
                    .drawingGroup()
                // Stop the window shrinking to zero.
                Spacer()
            }
            */
        }
    }
    
    /// calculateKoch
    ///
    /// Uses TaskGroup to calculate 6 Koch Fractals concurrently
    /// Should use await to update the GUI upon completion rather than printing time to console.
    ///
    func calculateKoch() async {
        
    kochFractalLarge.setButtonEnable(state: false)
    let totalIterations = Int(totalIterationsString)!
        
    let _ = await withTaskGroup(of:  Void.self) { taskGroup in
            
        taskGroup.addTask(priority: .high) {
            await kochFractalLarge.calculateKoch(iterations: totalIterations, piAngleDivisor: kochAngle)
        }
        
        /*
        taskGroup.addTask(priority: .high) {
            let iterations: Int? = 9
            let angle: Int? = 4
                
            await kochFractalSmall2.calculateKoch(iterations: iterations, piAngleDivisor: angle)
        }
                
        taskGroup.addTask(priority: .high) {
            let iterations: Int? = 8
            let angle: Int? = 4
                    
            await kochFractalSmall3.calculateKoch(iterations: iterations, piAngleDivisor: angle)
        }
                
        taskGroup.addTask(priority: .high) {
            let iterations: Int? = 7
            let angle: Int? = 4
                      
            await kochFractalSmall4.calculateKoch(iterations: iterations, piAngleDivisor: angle)
        }
                
        taskGroup.addTask(priority: .high) {
            let iterations: Int? = 5
            let angle: Int? = 4
                    
            await kochFractalSmall5.calculateKoch(iterations: iterations, piAngleDivisor: angle)
        }

        taskGroup.addTask(priority: .high) {
            let iterations: Int? = 1
            let angle: Int? = 4
                    
            await kochFractalSmall.calculateKoch(iterations: iterations, piAngleDivisor: angle)
        }
         */
    }

        
    kochFractalLarge.setButtonEnable(state: true)
        
    print("End Time of \(Date())\n")
        
    }
    
    /// clear
    ///
    /// Clears the two display views by erasing the Data
    ///
    func clear() async {
        // kochFractalSmall.eraseData()
        kochFractalLarge.eraseData()
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
