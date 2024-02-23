//
//  DrawingView.swift
//  Hizibizi Guess
//
//  Created by Rakibul Nasib on 22/11/23.
//

import SwiftUI
import PencilKit

struct DrawingView: UIViewRepresentable {
    
    
    var canvasView = PKCanvasView()
    

    class Coordinator: NSObject,PKCanvasViewDelegate{
        var matchManager: MatchManager
        init(matchManager: MatchManager) {
            self.matchManager = matchManager
        }
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            guard canvasView.isUserInteractionEnabled else {return}
            //matchManager.sendData(canvasView.drawing.dataRepresentation(), mode: .reliable)
        }
    }
    
    @ObservedObject var matchManager: MatchManager
    @Binding var eraserEnabled: Bool

    
    func makeUIView(context: Context) -> PKCanvasView {
        let canvasView = PKCanvasView()
        canvasView.drawingPolicy = .anyInput
        canvasView.tool = PKInkingTool( .pen, color: .black,
        width: 5)
        canvasView.delegate = context.coordinator
        canvasView.isUserInteractionEnabled = matchManager.currentlyDrawing
        return canvasView
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(matchManager: matchManager)
    }
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        let wasDrawing = canvasView.isUserInteractionEnabled
        uiView.isUserInteractionEnabled = matchManager.currentlyDrawing
        if !wasDrawing && matchManager.currentlyDrawing {
            uiView.drawing = PKDrawing()
        }
        if !matchManager.inGame {
            uiView.drawing = PKDrawing()
        }
        uiView.tool = eraserEnabled ? PKEraserTool(.vector) : PKInkingTool( .pen, color: .black,width: 5)
    }
    func clearDrawing() {
        canvasView.drawing = PKDrawing() // Reset the drawing to an empty drawing
    }
    
}

struct DrawingView_Previews: PreviewProvider {
   // @Binding var isDrawingCleared: Bool
    @State static var eraser = false
    static var previews: some View {
        DrawingView(matchManager: MatchManager(), eraserEnabled: $eraser)
    }}


