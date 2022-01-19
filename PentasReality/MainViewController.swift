//
//  ViewController.swift
//  PentasReality
//
//  Created by Ikmal Azman on 19/01/2022.
//

import UIKit
import SceneKit
import ARKit

final class MainViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet var sceneView: ARSCNView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        
        let asset = SCNScene(named: "art.scnassets/rumah-kampung.scn")!
        sceneView.scene = asset
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        // Set number of image to track at once
        configuration.maximumNumberOfTrackedImages = 1
        guard let imagesToDetect = ARReferenceImage.referenceImages(inGroupNamed: "Pentas NFT", bundle: Bundle.main) else {
            print("Could not find images to track at specify AR Resource Group")
            return
            
        }
        configuration.trackingImages = imagesToDetect
        print("Image loaded")
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        sceneView.session.pause()
    }
    
}

// MARK: - ARSCNViewDelegate
extension MainViewController : ARSCNViewDelegate {
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
