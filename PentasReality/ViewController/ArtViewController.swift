//
//  ViewController.swift
//  PentasReality
//
//  Created by Ikmal Azman on 19/01/2022.
//

import UIKit
import SceneKit
import ARKit

final class ArtViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet var sceneView: ARSCNView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = AppTheme.primaryColor
        setupConfiguration()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func setupConfiguration() {
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        // Set number of image to track at once
        configuration.maximumNumberOfTrackedImages = 1
        // Refer to folder contain image to track
        guard let imagesToDetect = ARReferenceImage.referenceImages(inGroupNamed: "Pentas NFT", bundle: Bundle.main) else {
            print("Could not find images to track at specify AR Resource Group")
            return
        }
        // Assign image to track to configuration
        configuration.trackingImages = imagesToDetect
        print("Image loaded")
        // Run the view's session
        sceneView.session.run(configuration)
    }
}

// MARK: - ARSCNViewDelegate
extension ArtViewController : ARSCNViewDelegate {
    
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let placeholderNode = SCNNode()
        
        guard let imageAnchor = anchor as? ARImageAnchor else {
            print("Could not find ARImageAnchor in the scene")
            return nil
        }
        let imageSize = imageAnchor.referenceImage.physicalSize
        // Creata a plane geometry
        let imagePlane = SCNPlane(width: imageSize.width, height: imageSize.height)
        imagePlane.firstMaterial?.diffuse.contents = UIColor.purple.withAlphaComponent(0.5)
        
        let imageNode = SCNNode(geometry: imagePlane)
        
        let nftScene = SCNScene(named: "art.scnassets/rumah-kampung.scn")!
        let nftNode = nftScene.rootNode.childNodes.first!
        
        // https://stackoverflow.com/questions/27570167/rotate-scnnode-infinitely-360
        // GLKMathDegreesToRadians - allow to convert degrees to radians
        // Make a 360 rotation on Y axis indifinitely
        let rotateAnimation = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(360)), z: 0, duration: 8)
        // Create action that repeat another action forever
        let rotateAction = SCNAction.repeatForever(rotateAnimation)
        
        let audioSource = SCNAudioSource(fileNamed: "make-me-feel.mp3")!
        let audioAction = SCNAction.playAudio(audioSource, waitForCompletion: false)
        
        // Add action to the node
        nftNode.runAction(rotateAction)
        nftNode.runAction(audioAction)
        
        imageNode.addChildNode(nftNode)
        
        // Rotate horizontal plane to vertical plane
        imageNode.eulerAngles.x = -.pi/2
        placeholderNode.addChildNode(imageNode)
        print("Plane Detected")
        return placeholderNode
    }
    
    // Tells delegate that SceneKit node's properties have been updated to match current state of its anchor.
    // https://stackoverflow.com/questions/60346491/arkit-stop-avplayer-audio-when-not-in-view
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // Determine if the node is hidden from the view
        if node.isHidden {
            guard let imageAnchor = anchor as? ARImageAnchor else {return}
            // Remove existing image anchor
            sceneView.session.remove(anchor: imageAnchor)
        }
    }
}

