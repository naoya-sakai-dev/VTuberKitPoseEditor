
import UIKit
import SceneKit
import VTuberKit
import VRMKit
import VRMSceneKit


class ViewController: UIViewController {
    @IBOutlet private weak var avatarView: AvatarView!

    override func viewDidLoad() {
        super.viewDidLoad()

        avatarView.autoenablesDefaultLighting = true
        avatarView.allowsCameraControl = true
        avatarView.showsStatistics = true
        avatarView.backgroundColor = UIColor.clear

        do {
            try avatarView.loadModel(withName: "AliciaSolid.vrm")
        } catch {
            print(error)
        }
        
        postureDictionary = postureStorage.load()
        userDefaults.register(defaults:postureDictionary) //初期設定は０
        
        setUpScene()
        
        buttonNameArray = [self.hipsXbutton,self.hipsYbutton,self.hipsZbutton,self.leftUpperLegXbutton,self.leftUpperLegYbutton,self.leftUpperLegZbutton,self.rightUpperLegXbutton,self.rightUpperLegYbutton,self.rightUpperLegZbutton,self.leftLowerLegXbutton,self.leftLowerLegYbutton,self.leftLowerLegZbutton,self.rightLowerLegXbutton,self.rightLowerLegYbutton,self.rightLowerLegZbutton,self.leftFootXbutton,self.leftFootYbutton,self.leftFootZbutton,self.rightFootXbutton,self.rightFootYbutton,self.rightFootZbutton,self.spineXbutton,self.spineYbutton,self.spineZbutton,self.neckXbutton,self.neckYbutton,self.neckZbutton,self.headXbutton,self.headYbutton,self.headZbutton,self.leftShoulderXbutton,self.leftShoulderYbutton,self.leftShoulderZbutton,self.rightShoulderXbutton,self.rightShoulderYbutton,self.rightShoulderZbutton,self.leftUpperArmXbutton,self.leftUpperArmYbutton,self.leftUpperArmZbutton,self.rightUpperArmXbutton,self.rightUpperArmYbutton,self.rightUpperArmZbutton,self.leftLowerArmXbutton,self.leftLowerArmYbutton,self.leftLowerArmZbutton,self.rightLowerArmXbutton,self.rightLowerArmYbutton,self.rightLowerArmZbutton,self.leftHandXbutton,self.leftHandYbutton,self.leftHandZbutton,self.rightHandXbutton,self.rightHandYbutton,self.rightHandZbutton,self.leftToesXbutton,self.leftToesYbutton,self.leftToesZbutton,self.rightToesXbutton,self.rightToesYbutton,self.rightToesZbutton,self.leftEyeXbutton,self.leftEyeYbutton,self.leftEyeZbutton,self.rightEyeXbutton,self.rightEyeYbutton,self.rightEyeZbutton,self.jawXbutton,self.jawYbutton,self.jawZbutton,self.leftThumbProximalXbutton,self.leftThumbProximalYbutton,self.leftThumbProximalZbutton,self.leftThumbIntermediateXbutton,self.leftThumbIntermediateYbutton,self.leftThumbIntermediateZbutton,self.leftThumbDistalXbutton,self.leftThumbDistalYbutton,self.leftThumbDistalZbutton,self.leftIndexProximalXbutton,self.leftIndexProximalYbutton,self.leftIndexProximalZbutton,self.leftIndexIntermediateXbutton,self.leftIndexIntermediateYbutton,self.leftIndexIntermediateZbutton,self.leftIndexDistalXbutton,self.leftIndexDistalYbutton,self.leftIndexDistalZbutton,self.leftMiddleProximalXbutton,self.leftMiddleProximalYbutton,self.leftMiddleProximalZbutton,self.leftMiddleIntermediateXbutton,self.leftMiddleIntermediateYbutton,self.leftMiddleIntermediateZbutton,self.leftMiddleDistalXbutton,self.leftMiddleDistalYbutton,self.leftMiddleDistalZbutton,self.leftRingProximalXbutton,self.leftRingProximalYbutton,self.leftRingProximalZbutton,self.leftRingIntermediateXbutton,self.leftRingIntermediateYbutton,self.leftRingIntermediateZbutton,self.leftRingDistalXbutton,self.leftRingDistalYbutton,self.leftRingDistalZbutton,self.leftLittleProximalXbutton,self.leftLittleProximalYbutton,self.leftLittleProximalZbutton,self.leftLittleIntermediateXbutton,self.leftLittleIntermediateYbutton,self.leftLittleIntermediateZbutton,self.leftLittleDistalXbutton,self.leftLittleDistalYbutton,self.leftLittleDistalZbutton,self.rightThumbProximalXbutton,self.rightThumbProximalYbutton,self.rightThumbProximalZbutton,self.rightThumbIntermediateXbutton,self.rightThumbIntermediateYbutton,self.rightThumbIntermediateZbutton,self.rightThumbDistalXbutton,self.rightThumbDistalYbutton,self.rightThumbDistalZbutton,self.rightIndexProximalXbutton,self.rightIndexProximalYbutton,self.rightIndexProximalZbutton,self.rightIndexIntermediateXbutton,self.rightIndexIntermediateYbutton,self.rightIndexIntermediateZbutton,self.rightIndexDistalXbutton,self.rightIndexDistalYbutton,self.rightIndexDistalZbutton,self.rightMiddleProximalXbutton,self.rightMiddleProximalYbutton,self.rightMiddleProximalZbutton,self.rightMiddleIntermediateXbutton,self.rightMiddleIntermediateYbutton,self.rightMiddleIntermediateZbutton,self.rightMiddleDistalXbutton,self.rightMiddleDistalYbutton,self.rightMiddleDistalZbutton,self.rightRingProximalXbutton,self.rightRingProximalYbutton,self.rightRingProximalZbutton,self.rightRingIntermediateXbutton,self.rightRingIntermediateYbutton,self.rightRingIntermediateZbutton,self.rightRingDistalXbutton,self.rightRingDistalYbutton,self.rightRingDistalZbutton,self.rightLittleProximalXbutton,self.rightLittleProximalYbutton,self.rightLittleProximalZbutton,self.rightLittleIntermediateXbutton,self.rightLittleIntermediateYbutton,self.rightLittleIntermediateZbutton,self.rightLittleDistalXbutton,self.rightLittleDistalYbutton,self.rightLittleDistalZbutton,self.upperChestXbutton,self.upperChestYbutton,self.upperChestZbutton]
        setupPoseControlMap()
    }
    
    //保存ボタンを押したら、保存。読み出しボタンを押したら読み出し
    let cameraFieldOfView0:CGFloat = 0
    let cameraPositionaryX0:Float = 0.0
    let cameraPositionaryY0:Float = 0.0
    let cameraPositionaryZ0:Float = 0.0
    let cameraEulerAnglesX0:Float = 0
    let cameraEulerAnglesY0:Float = 0
    let cameraEulerAnglesZ0:Float = 0
    
    var cameraFieldOfView:CGFloat = 0
    var cameraPositionaryX:Float = 0.0
    var cameraPositionaryY:Float = 0.0
    var cameraPositionaryZ:Float = 0.0
    var cameraEulerAnglesX:Float = 0
    var cameraEulerAnglesY:Float = 0
    var cameraEulerAnglesZ:Float = 0
    
    
    private func setUpScene() {

        print("cameraSetting")
        
        let camera = avatarView.cameraNode
        cameraFieldOfView = 60
        camera.camera?.fieldOfView = cameraFieldOfView
        cameraPositionaryX = 0
        cameraPositionaryY = Float(countArray[2])
        cameraPositionaryZ = Float(countArray[3])
        camera.position = SCNVector3(cameraPositionaryX,cameraPositionaryY,cameraPositionaryZ)
        camera.eulerAngles = SCNVector3(0,0,0)
        camera.rotation = SCNVector4(0,0,0,Float.pi / 180) //1で1度回転する
        
        cPosYcount = 2
        cPosZcount = 3
        updateCameraButtonTitles()
        
        print("fieldOfView",camera.camera?.fieldOfView as Any)//カメラの垂直または水平の視野角。
        print("focalLength",camera.camera?.fieldOfView as Any)//カメラの焦点距離（ミリメートル単位）
        print("sensorHeight",camera.camera?.sensorHeight as Any)//カメラのイメージングプレーンの垂直サイズ（ミリメートル単位）
        print("projectionDirection",camera.camera?.projectionDirection as Any)//視野または正書法のスケールを決定するために使用される軸。
        
        
        print("position",camera.position)
        print("eulerAngles",camera.eulerAngles)
        let edx = camera.eulerAngles.x * 180 / Float.pi
        let edy = camera.eulerAngles.y * 180 / Float.pi
        let edz = camera.eulerAngles.z * 180 / Float.pi
        print("eulerAngles",floor(edx),floor(edy),floor(edz))
        print("rotation",camera.rotation)
        
        
        print("avatarSetting")
        
        let avatar = avatarView.avatar
        avatar.humanoid.node(for: .hips)?.eulerAngles.y = 180 * Float.pi / 180 //デフォルトで後向きなので元に戻す
        hipsYcount = 15 //max(180)はrangeYArrayの15番目
        hipsYbutton.setTitle("180",for: UIControl.State.normal)
        
        print("position",avatar.position)
        print("eulerAngles",avatar.eulerAngles)
        print("rotation",avatar.rotation)
    }
    
    //cameraSetting
    let countArray = [0,1,2,3,4,5,4,3,2,1,0,-1,-2,-3,-4,-5,-4,-3,-2,-1]
    let cFOVArray:[CGFloat] = [0,3,6,9,12,15,18,20,18,15,12,9,6,3,0,-3,-6,-9,-12,-15,-18,-20,-18,-15,-12,-9,-6,-3]//27
    
    var cFOVcount = 0
    @IBOutlet weak var cFOVbutton: UIButton!
    @IBAction func cFOV(_ sender: Any) {
        print("cFOV")
        
        if cFOVcount == (cFOVArray.count - 1) {
            cFOVcount = 0
        }else{
            cFOVcount += 1
        }
        
        cameraFieldOfView = cFOVArray[cFOVcount]
        let camera = avatarView.cameraNode
        camera.camera?.fieldOfView = cameraFieldOfView
        
        cFOVbutton.setTitle("\(floor(cameraFieldOfView))", for: UIControl.State.normal)
        
        print("cFOVcount",cFOVcount,"cameraFieldOfView",cameraFieldOfView)
    }
    
    var cPosXcount = 0
    @IBOutlet weak var cPosXbutton: UIButton!
    @IBAction func cPosX(_ sender: Any) {
        print("cPosX")
        
        if cPosXcount == 19 {
            cPosXcount = 0
        }else{
            cPosXcount += 1
        }
        
        let amp = countArray[cPosXcount]
        cameraPositionaryX = Float(amp)
        let camera = avatarView.cameraNode
        camera.position.x = cameraPositionaryX
        
        let cpx = cameraPositionaryX * 10 //少数第二を切り捨て
        
        cPosXbutton.setTitle("\(floor(cpx)/10)", for: UIControl.State.normal)
        
        print("cPosXcount",cPosXcount,"amp",amp,"cameraPositionaryX",cameraPositionaryX)
    }
    
    var cPosYcount = 0
    @IBOutlet weak var cPosYbutton: UIButton!
    @IBAction func cPosY(_ sender: Any) {
        print("cPosY")
        if cPosYcount == 19 {
            cPosYcount = 0
        }else{
            cPosYcount += 1
        }
                
        let amp = countArray[cPosYcount]
        cameraPositionaryY = Float(amp)
        let camera = avatarView.cameraNode
        camera.position.y = cameraPositionaryY
        
        let cpy = cameraPositionaryY * 10
        
        cPosYbutton.setTitle("\(floor(cpy)/10)", for: UIControl.State.normal)
        
        print("cPosYcount",cPosYcount,"amp",amp,"cameraPositionaryY",cameraPositionaryY)
        
    }
    
    var cPosZcount = 0
    @IBOutlet weak var cPosZbutton: UIButton!
    @IBAction func cPosZ(_ sender: Any) {
        print("cPosZ")
        
        if cPosZcount == 19 {
            cPosZcount = 0
        }else{
            cPosZcount += 1
        }
                
        let amp = countArray[cPosZcount ]
        cameraPositionaryZ = Float(amp)
        let camera = avatarView.cameraNode
        camera.position.z = cameraPositionaryZ
        
        let cpz = cameraPositionaryZ * 10
        
        cPosZbutton.setTitle("\(floor(cpz)/10)", for: UIControl.State.normal)
        
        print("cPosZcount",cPosZcount,"amp",amp,"cameraPositionaryZ",cameraPositionaryZ)
        
    }
    
    let eulCountArray:[Float] = [0,30,60,90,120,180,210,240,270,300,330]//11
    var cEulXcount = 0
    @IBOutlet weak var cEulXbutton: UIButton!
    @IBAction func cEulX(_ sender: Any) {
        print("cEulX")
        
        if cEulXcount == 10 {
            cEulXcount = 0
        }else{
            cEulXcount += 1
        }
        
        let amp = eulCountArray[cEulXcount]
        cameraEulerAnglesX = amp
        let camera = avatarView.cameraNode
        camera.eulerAngles.x += cameraEulerAnglesX * Float.pi / 180
        
        cEulXbutton.setTitle("\(floor(cameraEulerAnglesX))", for: UIControl.State.normal)
        
        print("cEulXcount",cEulXcount,"amp",amp,"cameraEulerAnglesX",cameraEulerAnglesX)
    }
    
    var cEulYcount = 0
    @IBOutlet weak var cEulYbutton: UIButton!
    @IBAction func cEulY(_ sender: Any) {
        print("cEulY")
        
        if cEulYcount == 10 {
            cEulYcount = 0
        }else{
            cEulYcount += 1
        }
        let amp = eulCountArray[cEulYcount]
        cameraEulerAnglesY = amp
        let camera = avatarView.cameraNode
        camera.eulerAngles.y += cameraEulerAnglesY * Float.pi / 180
        
        cEulYbutton.setTitle("\(floor(cameraEulerAnglesY))", for: UIControl.State.normal)
        
        print("cEulYcount",cEulYcount,"amp",amp,"cameraEulerAnglesY",cameraEulerAnglesY)
    }
    
    var cEulZcount = 0
    @IBOutlet weak var cEulZbutton: UIButton!
    @IBAction func cEulZ(_ sender: Any) {
        print("cEulZ")
        
        if cEulZcount == 10 {
            cEulZcount = 0
        }else{
            cEulZcount += 1
        }

        let amp = eulCountArray[cEulZcount]
        cameraEulerAnglesZ = amp
        let camera = avatarView.cameraNode
        camera.eulerAngles.z += cameraEulerAnglesZ * Float.pi / 180
        
        cEulZbutton.setTitle("\(floor(cameraEulerAnglesZ))", for: UIControl.State.normal)
        
        print("cEulZcount",cEulZcount,"amp",amp,"cameraEulerAnglesZ",cameraEulerAnglesZ)
    }
    
    //xyz移動
    let xyzCountArray:[Float] = [0,1,2,3,4,5,4,3,2,1,0,-1,-2,-3,-4,-5,-4,-3,-2,-1] //20要素
    var xMoveCount = 0
    @IBOutlet weak var xMoveButton: UIButton!
    @IBAction func xMove(_ sender: Any) {
        print("xMove")
        
        if xMoveCount == 19{
            xMoveCount = 0
        }else{
            xMoveCount += 1
        }
                
        let amp = xyzCountArray[xMoveCount]
        let avatar = avatarView.avatar
        avatar.position.x = amp
        
        xMoveButton.setTitle(String(amp), for: UIControl.State.normal)
        
        print("xMoveCount",xMoveCount,"x",amp)
    }
    
    var yMoveCount = 0
    @IBOutlet weak var yMoveButton: UIButton!
    @IBAction func yMove(_ sender: Any) {
        print("yMove")
        
        if yMoveCount == 19{
            yMoveCount = 0
        }else{
            yMoveCount += 1
        }
                
        let amp = xyzCountArray[yMoveCount]
        let avatar = avatarView.avatar
        avatar.position.y = amp
        yMoveButton.setTitle(String(amp), for: UIControl.State.normal)
        print("yMoveCount",yMoveCount,"y",amp)
    }
    
    var zMoveCount = 0
    @IBOutlet weak var zMoveButton: UIButton!
    @IBAction func zMove(_ sender: Any) {
        print("zMove")
        
        if zMoveCount == 19{
            zMoveCount = 0
        }else{
            zMoveCount += 1
        }
                
        let amp = xyzCountArray[zMoveCount]
        let avatar = avatarView.avatar
        avatar.position.z = amp
        zMoveButton.setTitle(String(amp), for: UIControl.State.normal)
        print("zMoveCount",zMoveCount,"z",amp)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        avatarView.startFaceTracking()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        avatarView.stopFaceTracking()
    }

    let completion = {
        print("faceAnimationFinish")
        SCNTransaction.animationDuration = 0.0
    }
    
    @IBAction func neutralBP(_ sender: Any) {
        print("neutralBP")
        let avatar = avatarView.avatar
        
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        SCNTransaction.completionBlock = completion
        BlendShapeHelper.resetPresets(for: avatar)

        SCNTransaction.commit()
    }
    
    @IBAction func joyBP(_ sender: Any) {
        print("joyBP")
        let avatar = avatarView.avatar
        
        BlendShapeHelper.resetExceptJoy(for: avatar)
        
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        SCNTransaction.completionBlock = completion
        avatar.setBlendShape(value: 1, for: .preset(.joy))

        SCNTransaction.commit()
    }
    
    @IBAction func funBP(_ sender: Any) {
        print("funBP")
        let avatar = avatarView.avatar
        BlendShapeHelper.resetExceptFun(for: avatar)
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        SCNTransaction.completionBlock = completion
        avatar.setBlendShape(value: 1, for: .preset(.fun))

        SCNTransaction.commit()
    }
    
    @IBAction func sorrowBP(_ sender: Any) {
        print("sorrowBP")
        let avatar = avatarView.avatar
        BlendShapeHelper.resetExceptSorrow(for: avatar)
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        SCNTransaction.completionBlock = completion
        avatar.setBlendShape(value: 1, for: .preset(.sorrow))

        SCNTransaction.commit()
    }
    
    @IBAction func angryBP(_ sender: Any) {
        print("angryBP")
        let avatar = avatarView.avatar
        BlendShapeHelper.resetExceptAngry(for: avatar)
        
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        SCNTransaction.completionBlock = completion
        avatar.setBlendShape(value: 1, for: .preset(.angry))

        SCNTransaction.commit()
    }
    
    //(><)の表情は未実装
    
    @IBAction private func didFaceChanged(_ sender: UISegmentedControl) {
        let avatar = avatarView.avatar
        avatar.setBlendShape(value: 0, for: .preset(.joy))
        avatar.setBlendShape(value: 0, for: .preset(.fun))
        avatar.setBlendShape(value: 0, for: .preset(.sorrow))
        avatar.setBlendShape(value: 0, for: .preset(.angry))
        avatar.setBlendShape(value: 0, for: .custom("><"))

        let index = sender.selectedSegmentIndex
        avatarView.isBlinkTrackingEnabled = index == 0 //無表情ならまばたき可能
        avatarView.isMouthTrackingEnabled = index != 1 && index != 4 //joy angry以外は口パク可能

        switch index {
        case 1:
            StartBlendShapeTimer()
        case 2:
            avatar.setBlendShape(value: 1.0, for: .preset(.fun))
        case 3:
            avatar.setBlendShape(value: 1.0, for: .preset(.sorrow))
        case 4:
            avatar.setBlendShape(value: 1.0, for: .preset(.angry))
        case 5:
            avatar.setBlendShape(value: 1.0, for: .custom("><"))
        default: ()
        }
    }
    
    //タイマー
    var BlendShapeTimer = Timer()
    var timerCount = 0
    var bsp = ""
    func StartBlendShapeTimer() { //timeCheckを毎秒実行する
        print("StartBlendShapeTimer")
        BlendShapeTimer = Timer(timeInterval: 0.02,
                              target: self,
                              selector: #selector(AnimeBlendShape),
                              userInfo: nil,
                              repeats: true)
        RunLoop.main.add(BlendShapeTimer, forMode: .default)
    }
    
    @objc func AnimeBlendShape(){//２秒くらいで表情を往復
        timerCount += 1
        print("timerCount=",timerCount)
        switch timerCount{
        case 1 : avatarView.avatar.setBlendShape(value: 0.1, for: .preset(.joy))
        case 2 : avatarView.avatar.setBlendShape(value: 0.2, for: .preset(.joy))
        case 3 : avatarView.avatar.setBlendShape(value: 0.3, for: .preset(.joy))
        case 4 : avatarView.avatar.setBlendShape(value: 0.4, for: .preset(.joy))
        case 5 : avatarView.avatar.setBlendShape(value: 0.5, for: .preset(.joy))
        case 6 : avatarView.avatar.setBlendShape(value: 0.6, for: .preset(.joy))
        case 7 : avatarView.avatar.setBlendShape(value: 0.7, for: .preset(.joy))
        case 8 : avatarView.avatar.setBlendShape(value: 0.8, for: .preset(.joy))
        case 9 : avatarView.avatar.setBlendShape(value: 0.9, for: .preset(.joy))
        case 10 : avatarView.avatar.setBlendShape(value: 1.0, for: .preset(.joy))
        case 11 : avatarView.avatar.setBlendShape(value: 1.0, for: .preset(.joy))
        case 12 : avatarView.avatar.setBlendShape(value: 1.0, for: .preset(.joy))
        case 13 : avatarView.avatar.setBlendShape(value: 1.0, for: .preset(.joy))
        case 14 : avatarView.avatar.setBlendShape(value: 1.0, for: .preset(.joy))
        case 15 : avatarView.avatar.setBlendShape(value: 1.0, for: .preset(.joy))
        case 16 : avatarView.avatar.setBlendShape(value: 1.0, for: .preset(.joy))
        case 17 : avatarView.avatar.setBlendShape(value: 1.0, for: .preset(.joy))
        case 18 : avatarView.avatar.setBlendShape(value: 1.0, for: .preset(.joy))
        case 19 : avatarView.avatar.setBlendShape(value: 1.0, for: .preset(.joy))
        case 20 : avatarView.avatar.setBlendShape(value: 1.0, for: .preset(.joy))
        case 21 : avatarView.avatar.setBlendShape(value: 0.9, for: .preset(.joy))
        case 22 : avatarView.avatar.setBlendShape(value: 0.8, for: .preset(.joy))
        case 23 : avatarView.avatar.setBlendShape(value: 0.7, for: .preset(.joy))
        case 24 : avatarView.avatar.setBlendShape(value: 0.6, for: .preset(.joy))
        case 25 : avatarView.avatar.setBlendShape(value: 0.5, for: .preset(.joy))
        case 26 : avatarView.avatar.setBlendShape(value: 0.4, for: .preset(.joy))
        case 27 : avatarView.avatar.setBlendShape(value: 0.3, for: .preset(.joy))
        case 28 : avatarView.avatar.setBlendShape(value: 0.2, for: .preset(.joy))
        case 29 : avatarView.avatar.setBlendShape(value: 0.1, for: .preset(.joy))
        case 30 : avatarView.avatar.setBlendShape(value: 0.0, for: .preset(.joy))
            BlendShapeTimerEnd()
        default:
            print("AnimeBlendShapeTimerDefault",timerCount)
        }
    }
    
    func BlendShapeTimerEnd(){
        print("BlendShapeTimerEnd")
        BlendShapeTimer.invalidate()
        timerCount = 0
        bsp = ""
    }
    
    var xbutton = false //左右方向を軸にした回転　鉄棒の坂上がり状態
    var ybutton = false //上下方向を軸にした回転　ヘリのプロペラ
    var zbutton = false //奥行き方向を軸にした回転 円を描く
    @IBAction func XbuttonPushed(_ sender: Any) {
        
        let avatar = avatarView.avatar
        SCNTransaction.animationDuration = 1.0
        
        if !xbutton{
            avatar.humanoid.node(for: .leftShoulder)?.eulerAngles = SCNVector3( 0.0 * .pi / 180,0,0)
            xbutton = true
        }else{
            avatar.humanoid.node(for: .leftShoulder)?.eulerAngles = SCNVector3( 180.0 * .pi / 180,0,0)
            xbutton = false
        }
    }
    
    @IBAction func YbuttonPushed(_ sender: Any) {
        
        let avatar = avatarView.avatar
        SCNTransaction.animationDuration = 1.0
        
        if !ybutton{
            avatar.humanoid.node(for: .leftShoulder)?.eulerAngles = SCNVector3( 0, 0.0 * .pi / 180,0)
            ybutton = true
        }else{
            avatar.humanoid.node(for: .leftShoulder)?.eulerAngles = SCNVector3( 0, 180.0 * .pi / 180,0)
            ybutton = false
        }
    }
    
    @IBAction func ZbuttonPushed(_ sender: Any) {
        
        let avatar = avatarView.avatar
        SCNTransaction.animationDuration = 1.0
        
        if !zbutton{
            avatar.humanoid.node(for: .leftShoulder)?.eulerAngles = SCNVector3( 0, 0, 0.0 * .pi / 180)
            zbutton = true
        }else{
            avatar.humanoid.node(for: .leftShoulder)?.eulerAngles = SCNVector3( 0, 0, 180.0 * .pi / 180)
            zbutton = false
        }
    }
    
    var replayMode = false
    
    private enum Axis: Int {
        case x = 1
        case y = 2
        case z = 3
    }
    
    typealias AvatarNode = VRMNode
    
    private struct PoseControl {
        let button: UIButton
        let bone: Humanoid.Bones
        let axis: Axis
    }
    
    private struct PostureStorage {
        let defaultsKey: String
        let defaultPosture: [String:Int]
        let userDefaults: UserDefaults
        
        func load() -> [String:Int] {
            let saved = userDefaults.object(forKey: defaultsKey) as? [String : Int]
            return saved ?? defaultPosture
        }
        
        func save(_ posture: [String:Int]) {
            userDefaults.set(posture, forKey: defaultsKey)
        }
    }
    
    private struct MotionRange {
        let xMin: Double
        let xMax: Double
        let yMin: Double
        let yMax: Double
        let zMin: Double
        let zMax: Double
        
        static let zero = MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: 0, zMax: 0)
    }

    private struct BlendShapeHelper {
        static func resetPresets(for avatar: AvatarNode) {
            avatar.setBlendShape(value: 0, for: .preset(.joy))
            avatar.setBlendShape(value: 0, for: .preset(.fun))
            avatar.setBlendShape(value: 0, for: .preset(.sorrow))
            avatar.setBlendShape(value: 0, for: .preset(.angry))
        }
        
        static func resetExceptJoy(for avatar: AvatarNode) {
            avatar.setBlendShape(value: 0, for: .preset(.fun))
            avatar.setBlendShape(value: 0, for: .preset(.sorrow))
            avatar.setBlendShape(value: 0, for: .preset(.angry))
        }
        
        static func resetExceptFun(for avatar: AvatarNode) {
            avatar.setBlendShape(value: 0, for: .preset(.joy))
            avatar.setBlendShape(value: 0, for: .preset(.sorrow))
            avatar.setBlendShape(value: 0, for: .preset(.angry))
        }
        
        static func resetExceptSorrow(for avatar: AvatarNode) {
            avatar.setBlendShape(value: 0, for: .preset(.joy))
            avatar.setBlendShape(value: 0, for: .preset(.fun))
            avatar.setBlendShape(value: 0, for: .preset(.angry))
        }
        
        static func resetExceptAngry(for avatar: AvatarNode) {
            avatar.setBlendShape(value: 0, for: .preset(.joy))
            avatar.setBlendShape(value: 0, for: .preset(.fun))
            avatar.setBlendShape(value: 0, for: .preset(.sorrow))
        }
    }
    
    private var poseControlMap: [String: PoseControl] = [:]
    private let motionRanges: [Humanoid.Bones: MotionRange] = [
        .hips: MotionRange(xMin: -180, xMax: 180, yMin: -180, yMax: 180, zMin: -180, zMax: 180),
        .leftUpperLeg: MotionRange(xMin: -30, xMax: 150, yMin: -90, yMax: 90, zMin: -30, zMax: 30),
        .rightUpperLeg: MotionRange(xMin: -30, xMax: 150, yMin: -90, yMax: 90, zMin: -30, zMax: 30),
        .leftLowerLeg: MotionRange(xMin: -150, xMax: 0, yMin: 0, yMax: 0, zMin: 0, zMax: 0),
        .rightLowerLeg: MotionRange(xMin: -150, xMax: 0, yMin: 0, yMax: 0, zMin: 0, zMax: 0),
        .leftFoot: MotionRange(xMin: -30, xMax: 30, yMin: -30, yMax: 30, zMin: 0, zMax: 0),
        .rightFoot: MotionRange(xMin: -30, xMax: 30, yMin: -30, yMax: 30, zMin: 0, zMax: 0),
        .spine: MotionRange(xMin: -90, xMax: 30, yMin: -60, yMax: 60, zMin: -60, zMax: 60),
        .neck: MotionRange(xMin: -30, xMax: 60, yMin: -60, yMax: 60, zMin: -60, zMax: 60),
        .head: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: 0, zMax: 0),
        .leftShoulder: MotionRange(xMin: -180, xMax: 180, yMin: -30, yMax: 30, zMin: -80, zMax: 0),
        .rightShoulder: MotionRange(xMin: -30, xMax: 180, yMin: -30, yMax: 30, zMin: 0, zMax: 80),
        .leftUpperArm: MotionRange(xMin: -30, xMax: 30, yMin: -180, yMax: 180, zMin: -120, zMax: 120),
        .rightUpperArm: MotionRange(xMin: -30, xMax: 30, yMin: -30, yMax: 180, zMin: -120, zMax: 120),
        .leftLowerArm: MotionRange(xMin: -30, xMax: 30, yMin: -150, yMax: 0, zMin: 0, zMax: 150),
        .rightLowerArm: MotionRange(xMin: -30, xMax: 30, yMin: 0, yMax: 150, zMin: -150, zMax: 0),
        .leftHand: MotionRange(xMin: 0, xMax: 0, yMin: -30, yMax: 30, zMin: -60, zMax: 60),
        .rightHand: MotionRange(xMin: 0, xMax: 0, yMin: -30, yMax: 30, zMin: -60, zMax: 60),
        .leftToes: MotionRange(xMin: -30, xMax: 30, yMin: 0, yMax: 0, zMin: 0, zMax: 0),
        .rightToes: MotionRange(xMin: -30, xMax: 30, yMin: 0, yMax: 0, zMin: 0, zMax: 0),
        .leftEye: MotionRange(xMin: -10, xMax: 10, yMin: -10, yMax: 10, zMin: -10, zMax: 10),
        .rightEye: MotionRange(xMin: -10, xMax: 10, yMin: -10, yMax: 10, zMin: -10, zMax: 10),
        .jaw: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: 0, zMax: 0),
        .leftThumbProximal: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: 0, zMax: 0),
        .leftThumbIntermediate: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 60, zMin: 0, zMax: 0),
        .leftThumbDistal: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 60, zMin: 0, zMax: 0),
        .leftIndexProximal: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: 0, zMax: 90),
        .leftIndexIntermediate: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: 0, zMax: 90),
        .leftIndexDistal: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: 0, zMax: 60),
        .leftMiddleProximal: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: 0, zMax: 90),
        .leftMiddleIntermediate: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: 0, zMax: 90),
        .leftMiddleDistal: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: 0, zMax: 60),
        .leftRingProximal: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: 0, zMax: 90),
        .leftRingIntermediate: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: 0, zMax: 90),
        .leftRingDistal: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: 0, zMax: 60),
        .leftLittleProximal: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: 0, zMax: 90),
        .leftLittleIntermediate: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: 0, zMax: 90),
        .leftLittleDistal: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: 0, zMax: 60),
        .rightThumbProximal: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: 0, zMax: 0),
        .rightThumbIntermediate: MotionRange(xMin: 0, xMax: 0, yMin: -60, yMax: 0, zMin: 0, zMax: 0),
        .rightThumbDistal: MotionRange(xMin: 0, xMax: 0, yMin: -60, yMax: 0, zMin: 0, zMax: 0),
        .rightIndexProximal: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: -90, zMax: 0),
        .rightIndexIntermediate: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: -90, zMax: 0),
        .rightIndexDistal: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: -60, zMax: 0),
        .rightMiddleProximal: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: -90, zMax: 0),
        .rightMiddleIntermediate: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: -90, zMax: 0),
        .rightMiddleDistal: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: -60, zMax: 0),
        .rightRingProximal: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: -90, zMax: 0),
        .rightRingIntermediate: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: -90, zMax: 0),
        .rightRingDistal: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: -60, zMax: 0),
        .rightLittleProximal: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: -90, zMax: 0),
        .rightLittleIntermediate: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: -90, zMax: 0),
        .rightLittleDistal: MotionRange(xMin: 0, xMax: 0, yMin: 0, yMax: 0, zMin: -60, zMax: 0),
        .upperChest: MotionRange(xMin: -30, xMax: 30, yMin: -30, yMax: 30, zMin: -30, zMax: 30)
    ]
    
    private func setupPoseControlMap() {
        poseControlMap = [
            "hipsX": PoseControl(button: hipsXbutton, bone: .hips, axis: .x),
            "hipsY": PoseControl(button: hipsYbutton, bone: .hips, axis: .y),
            "hipsZ": PoseControl(button: hipsZbutton, bone: .hips, axis: .z),
            
            "leftUpperLegX": PoseControl(button: leftUpperLegXbutton, bone: .leftUpperLeg, axis: .x),
            "leftUpperLegY": PoseControl(button: leftUpperLegYbutton, bone: .leftUpperLeg, axis: .y),
            "leftUpperLegZ": PoseControl(button: leftUpperLegZbutton, bone: .leftUpperLeg, axis: .z),
            "rightUpperLegX": PoseControl(button: rightUpperLegXbutton, bone: .rightUpperLeg, axis: .x),
            "rightUpperLegY": PoseControl(button: rightUpperLegYbutton, bone: .rightUpperLeg, axis: .y),
            "rightUpperLegZ": PoseControl(button: rightUpperLegZbutton, bone: .rightUpperLeg, axis: .z),
            
            "leftLowerLegX": PoseControl(button: leftLowerLegXbutton, bone: .leftLowerLeg, axis: .x),
            "leftLowerLegY": PoseControl(button: leftLowerLegYbutton, bone: .leftLowerLeg, axis: .y),
            "leftLowerLegZ": PoseControl(button: leftLowerLegZbutton, bone: .leftLowerLeg, axis: .z),
            "rightLowerLegX": PoseControl(button: rightLowerLegXbutton, bone: .rightLowerLeg, axis: .x),
            "rightLowerLegY": PoseControl(button: rightLowerLegYbutton, bone: .rightLowerLeg, axis: .y),
            "rightLowerLegZ": PoseControl(button: rightLowerLegZbutton, bone: .rightLowerLeg, axis: .z),
            
            "leftFootX": PoseControl(button: leftFootXbutton, bone: .leftFoot, axis: .x),
            "leftFootY": PoseControl(button: leftFootYbutton, bone: .leftFoot, axis: .y),
            "leftFootZ": PoseControl(button: leftFootZbutton, bone: .leftFoot, axis: .z),
            "rightFootX": PoseControl(button: rightFootXbutton, bone: .rightFoot, axis: .x),
            "rightFootY": PoseControl(button: rightFootYbutton, bone: .rightFoot, axis: .y),
            "rightFootZ": PoseControl(button: rightFootZbutton, bone: .rightFoot, axis: .z),
            
            "spineX": PoseControl(button: spineXbutton, bone: .spine, axis: .x),
            "spineY": PoseControl(button: spineYbutton, bone: .spine, axis: .y),
            "spineZ": PoseControl(button: spineZbutton, bone: .spine, axis: .z),
            
            "neckX": PoseControl(button: neckXbutton, bone: .neck, axis: .x),
            "neckY": PoseControl(button: neckYbutton, bone: .neck, axis: .y),
            "neckZ": PoseControl(button: neckZbutton, bone: .neck, axis: .z),
            
            "headX": PoseControl(button: headXbutton, bone: .head, axis: .x),
            "headY": PoseControl(button: headYbutton, bone: .head, axis: .y),
            "headZ": PoseControl(button: headZbutton, bone: .head, axis: .z),
            
            "leftShoulderX": PoseControl(button: leftShoulderXbutton, bone: .leftShoulder, axis: .x),
            "leftShoulderY": PoseControl(button: leftShoulderYbutton, bone: .leftShoulder, axis: .y),
            "leftShoulderZ": PoseControl(button: leftShoulderZbutton, bone: .leftShoulder, axis: .z),
            "rightShoulderX": PoseControl(button: rightShoulderXbutton, bone: .rightShoulder, axis: .x),
            "rightShoulderY": PoseControl(button: rightShoulderYbutton, bone: .rightShoulder, axis: .y),
            "rightShoulderZ": PoseControl(button: rightShoulderZbutton, bone: .rightShoulder, axis: .z),
            
            "leftUpperArmX": PoseControl(button: leftUpperArmXbutton, bone: .leftUpperArm, axis: .x),
            "leftUpperArmY": PoseControl(button: leftUpperArmYbutton, bone: .leftUpperArm, axis: .y),
            "leftUpperArmZ": PoseControl(button: leftUpperArmZbutton, bone: .leftUpperArm, axis: .z),
            "rightUpperArmX": PoseControl(button: rightUpperArmXbutton, bone: .rightUpperArm, axis: .x),
            "rightUpperArmY": PoseControl(button: rightUpperArmYbutton, bone: .rightUpperArm, axis: .y),
            "rightUpperArmZ": PoseControl(button: rightUpperArmZbutton, bone: .rightUpperArm, axis: .z),
            
            "leftLowerArmX": PoseControl(button: leftLowerArmXbutton, bone: .leftLowerArm, axis: .x),
            "leftLowerArmY": PoseControl(button: leftLowerArmYbutton, bone: .leftLowerArm, axis: .y),
            "leftLowerArmZ": PoseControl(button: leftLowerArmZbutton, bone: .leftLowerArm, axis: .z),
            "rightLowerArmX": PoseControl(button: rightLowerArmXbutton, bone: .rightLowerArm, axis: .x),
            "rightLowerArmY": PoseControl(button: rightLowerArmYbutton, bone: .rightLowerArm, axis: .y),
            "rightLowerArmZ": PoseControl(button: rightLowerArmZbutton, bone: .rightLowerArm, axis: .z),
            
            "leftHandX": PoseControl(button: leftHandXbutton, bone: .leftHand, axis: .x),
            "leftHandY": PoseControl(button: leftHandYbutton, bone: .leftHand, axis: .y),
            "leftHandZ": PoseControl(button: leftHandZbutton, bone: .leftHand, axis: .z),
            "rightHandX": PoseControl(button: rightHandXbutton, bone: .rightHand, axis: .x),
            "rightHandY": PoseControl(button: rightHandYbutton, bone: .rightHand, axis: .y),
            "rightHandZ": PoseControl(button: rightHandZbutton, bone: .rightHand, axis: .z),
            
            "leftToesX": PoseControl(button: leftToesXbutton, bone: .leftToes, axis: .x),
            "leftToesY": PoseControl(button: leftToesYbutton, bone: .leftToes, axis: .y),
            "leftToesZ": PoseControl(button: leftToesZbutton, bone: .leftToes, axis: .z),
            "rightToesX": PoseControl(button: rightToesXbutton, bone: .rightToes, axis: .x),
            "rightToesY": PoseControl(button: rightToesYbutton, bone: .rightToes, axis: .y),
            "rightToesZ": PoseControl(button: rightToesZbutton, bone: .rightToes, axis: .z),
            
            "leftEyeX": PoseControl(button: leftEyeXbutton, bone: .leftEye, axis: .x),
            "leftEyeY": PoseControl(button: leftEyeYbutton, bone: .leftEye, axis: .y),
            "leftEyeZ": PoseControl(button: leftEyeZbutton, bone: .leftEye, axis: .z),
            "rightEyeX": PoseControl(button: rightEyeXbutton, bone: .rightEye, axis: .x),
            "rightEyeY": PoseControl(button: rightEyeYbutton, bone: .rightEye, axis: .y),
            "rightEyeZ": PoseControl(button: rightEyeZbutton, bone: .rightEye, axis: .z),
            
            "jawX": PoseControl(button: jawXbutton, bone: .jaw, axis: .x),
            "jawY": PoseControl(button: jawYbutton, bone: .jaw, axis: .y),
            "jawZ": PoseControl(button: jawZbutton, bone: .jaw, axis: .z),
            
            "upperChestX": PoseControl(button: upperChestXbutton, bone: .upperChest, axis: .x),
            "upperChestY": PoseControl(button: upperChestYbutton, bone: .upperChest, axis: .y),
            "upperChestZ": PoseControl(button: upperChestZbutton, bone: .upperChest, axis: .z),
            
            // 左手指
            "leftThumbProximalX": PoseControl(button: leftThumbProximalXbutton, bone: .leftThumbProximal, axis: .x),
            "leftThumbProximalY": PoseControl(button: leftThumbProximalYbutton, bone: .leftThumbProximal, axis: .y),
            "leftThumbProximalZ": PoseControl(button: leftThumbProximalZbutton, bone: .leftThumbProximal, axis: .z),
            "leftThumbIntermediateX": PoseControl(button: leftThumbIntermediateXbutton, bone: .leftThumbIntermediate, axis: .x),
            "leftThumbIntermediateY": PoseControl(button: leftThumbIntermediateYbutton, bone: .leftThumbIntermediate, axis: .y),
            "leftThumbIntermediateZ": PoseControl(button: leftThumbIntermediateZbutton, bone: .leftThumbIntermediate, axis: .z),
            "leftThumbDistalX": PoseControl(button: leftThumbDistalXbutton, bone: .leftThumbDistal, axis: .x),
            "leftThumbDistalY": PoseControl(button: leftThumbDistalYbutton, bone: .leftThumbDistal, axis: .y),
            "leftThumbDistalZ": PoseControl(button: leftThumbDistalZbutton, bone: .leftThumbDistal, axis: .z),
            
            "leftIndexProximalX": PoseControl(button: leftIndexProximalXbutton, bone: .leftIndexProximal, axis: .x),
            "leftIndexProximalY": PoseControl(button: leftIndexProximalYbutton, bone: .leftIndexProximal, axis: .y),
            "leftIndexProximalZ": PoseControl(button: leftIndexProximalZbutton, bone: .leftIndexProximal, axis: .z),
            "leftIndexIntermediateX": PoseControl(button: leftIndexIntermediateXbutton, bone: .leftIndexIntermediate, axis: .x),
            "leftIndexIntermediateY": PoseControl(button: leftIndexIntermediateYbutton, bone: .leftIndexIntermediate, axis: .y),
            "leftIndexIntermediateZ": PoseControl(button: leftIndexIntermediateZbutton, bone: .leftIndexIntermediate, axis: .z),
            "leftIndexDistalX": PoseControl(button: leftIndexDistalXbutton, bone: .leftIndexDistal, axis: .x),
            "leftIndexDistalY": PoseControl(button: leftIndexDistalYbutton, bone: .leftIndexDistal, axis: .y),
            "leftIndexDistalZ": PoseControl(button: leftIndexDistalZbutton, bone: .leftIndexDistal, axis: .z),
            
            "leftMiddleProximalX": PoseControl(button: leftMiddleProximalXbutton, bone: .leftMiddleProximal, axis: .x),
            "leftMiddleProximalY": PoseControl(button: leftMiddleProximalYbutton, bone: .leftMiddleProximal, axis: .y),
            "leftMiddleProximalZ": PoseControl(button: leftMiddleProximalZbutton, bone: .leftMiddleProximal, axis: .z),
            "leftMiddleIntermediateX": PoseControl(button: leftMiddleIntermediateXbutton, bone: .leftMiddleIntermediate, axis: .x),
            "leftMiddleIntermediateY": PoseControl(button: leftMiddleIntermediateYbutton, bone: .leftMiddleIntermediate, axis: .y),
            "leftMiddleIntermediateZ": PoseControl(button: leftMiddleIntermediateZbutton, bone: .leftMiddleIntermediate, axis: .z),
            "leftMiddleDistalX": PoseControl(button: leftMiddleDistalXbutton, bone: .leftMiddleDistal, axis: .x),
            "leftMiddleDistalY": PoseControl(button: leftMiddleDistalYbutton, bone: .leftMiddleDistal, axis: .y),
            "leftMiddleDistalZ": PoseControl(button: leftMiddleDistalZbutton, bone: .leftMiddleDistal, axis: .z),
            
            "leftRingProximalX": PoseControl(button: leftRingProximalXbutton, bone: .leftRingProximal, axis: .x),
            "leftRingProximalY": PoseControl(button: leftRingProximalYbutton, bone: .leftRingProximal, axis: .y),
            "leftRingProximalZ": PoseControl(button: leftRingProximalZbutton, bone: .leftRingProximal, axis: .z),
            "leftRingIntermediateX": PoseControl(button: leftRingIntermediateXbutton, bone: .leftRingIntermediate, axis: .x),
            "leftRingIntermediateY": PoseControl(button: leftRingIntermediateYbutton, bone: .leftRingIntermediate, axis: .y),
            "leftRingIntermediateZ": PoseControl(button: leftRingIntermediateZbutton, bone: .leftRingIntermediate, axis: .z),
            "leftRingDistalX": PoseControl(button: leftRingDistalXbutton, bone: .leftRingDistal, axis: .x),
            "leftRingDistalY": PoseControl(button: leftRingDistalYbutton, bone: .leftRingDistal, axis: .y),
            "leftRingDistalZ": PoseControl(button: leftRingDistalZbutton, bone: .leftRingDistal, axis: .z),
            
            "leftLittleProximalX": PoseControl(button: leftLittleProximalXbutton, bone: .leftLittleProximal, axis: .x),
            "leftLittleProximalY": PoseControl(button: leftLittleProximalYbutton, bone: .leftLittleProximal, axis: .y),
            "leftLittleProximalZ": PoseControl(button: leftLittleProximalZbutton, bone: .leftLittleProximal, axis: .z),
            "leftLittleIntermediateX": PoseControl(button: leftLittleIntermediateXbutton, bone: .leftLittleIntermediate, axis: .x),
            "leftLittleIntermediateY": PoseControl(button: leftLittleIntermediateYbutton, bone: .leftLittleIntermediate, axis: .y),
            "leftLittleIntermediateZ": PoseControl(button: leftLittleIntermediateZbutton, bone: .leftLittleIntermediate, axis: .z),
            "leftLittleDistalX": PoseControl(button: leftLittleDistalXbutton, bone: .leftLittleDistal, axis: .x),
            "leftLittleDistalY": PoseControl(button: leftLittleDistalYbutton, bone: .leftLittleDistal, axis: .y),
            "leftLittleDistalZ": PoseControl(button: leftLittleDistalZbutton, bone: .leftLittleDistal, axis: .z),
            
            // 右手指
            "rightThumbProximalX": PoseControl(button: rightThumbProximalXbutton, bone: .rightThumbProximal, axis: .x),
            "rightThumbProximalY": PoseControl(button: rightThumbProximalYbutton, bone: .rightThumbProximal, axis: .y),
            "rightThumbProximalZ": PoseControl(button: rightThumbProximalZbutton, bone: .rightThumbProximal, axis: .z),
            "rightThumbIntermediateX": PoseControl(button: rightThumbIntermediateXbutton, bone: .rightThumbIntermediate, axis: .x),
            "rightThumbIntermediateY": PoseControl(button: rightThumbIntermediateYbutton, bone: .rightThumbIntermediate, axis: .y),
            "rightThumbIntermediateZ": PoseControl(button: rightThumbIntermediateZbutton, bone: .rightThumbIntermediate, axis: .z),
            "rightThumbDistalX": PoseControl(button: rightThumbDistalXbutton, bone: .rightThumbDistal, axis: .x),
            "rightThumbDistalY": PoseControl(button: rightThumbDistalYbutton, bone: .rightThumbDistal, axis: .y),
            "rightThumbDistalZ": PoseControl(button: rightThumbDistalZbutton, bone: .rightThumbDistal, axis: .z),
            
            "rightIndexProximalX": PoseControl(button: rightIndexProximalXbutton, bone: .rightIndexProximal, axis: .x),
            "rightIndexProximalY": PoseControl(button: rightIndexProximalYbutton, bone: .rightIndexProximal, axis: .y),
            "rightIndexProximalZ": PoseControl(button: rightIndexProximalZbutton, bone: .rightIndexProximal, axis: .z),
            "rightIndexIntermediateX": PoseControl(button: rightIndexIntermediateXbutton, bone: .rightIndexIntermediate, axis: .x),
            "rightIndexIntermediateY": PoseControl(button: rightIndexIntermediateYbutton, bone: .rightIndexIntermediate, axis: .y),
            "rightIndexIntermediateZ": PoseControl(button: rightIndexIntermediateZbutton, bone: .rightIndexIntermediate, axis: .z),
            "rightIndexDistalX": PoseControl(button: rightIndexDistalXbutton, bone: .rightIndexDistal, axis: .x),
            "rightIndexDistalY": PoseControl(button: rightIndexDistalYbutton, bone: .rightIndexDistal, axis: .y),
            "rightIndexDistalZ": PoseControl(button: rightIndexDistalZbutton, bone: .rightIndexDistal, axis: .z),
            
            "rightMiddleProximalX": PoseControl(button: rightMiddleProximalXbutton, bone: .rightMiddleProximal, axis: .x),
            "rightMiddleProximalY": PoseControl(button: rightMiddleProximalYbutton, bone: .rightMiddleProximal, axis: .y),
            "rightMiddleProximalZ": PoseControl(button: rightMiddleProximalZbutton, bone: .rightMiddleProximal, axis: .z),
            "rightMiddleIntermediateX": PoseControl(button: rightMiddleIntermediateXbutton, bone: .rightMiddleIntermediate, axis: .x),
            "rightMiddleIntermediateY": PoseControl(button: rightMiddleIntermediateYbutton, bone: .rightMiddleIntermediate, axis: .y),
            "rightMiddleIntermediateZ": PoseControl(button: rightMiddleIntermediateZbutton, bone: .rightMiddleIntermediate, axis: .z),
            "rightMiddleDistalX": PoseControl(button: rightMiddleDistalXbutton, bone: .rightMiddleDistal, axis: .x),
            "rightMiddleDistalY": PoseControl(button: rightMiddleDistalYbutton, bone: .rightMiddleDistal, axis: .y),
            "rightMiddleDistalZ": PoseControl(button: rightMiddleDistalZbutton, bone: .rightMiddleDistal, axis: .z),
            
            "rightRingProximalX": PoseControl(button: rightRingProximalXbutton, bone: .rightRingProximal, axis: .x),
            "rightRingProximalY": PoseControl(button: rightRingProximalYbutton, bone: .rightRingProximal, axis: .y),
            "rightRingProximalZ": PoseControl(button: rightRingProximalZbutton, bone: .rightRingProximal, axis: .z),
            "rightRingIntermediateX": PoseControl(button: rightRingIntermediateXbutton, bone: .rightRingIntermediate, axis: .x),
            "rightRingIntermediateY": PoseControl(button: rightRingIntermediateYbutton, bone: .rightRingIntermediate, axis: .y),
            "rightRingIntermediateZ": PoseControl(button: rightRingIntermediateZbutton, bone: .rightRingIntermediate, axis: .z),
            "rightRingDistalX": PoseControl(button: rightRingDistalXbutton, bone: .rightRingDistal, axis: .x),
            "rightRingDistalY": PoseControl(button: rightRingDistalYbutton, bone: .rightRingDistal, axis: .y),
            "rightRingDistalZ": PoseControl(button: rightRingDistalZbutton, bone: .rightRingDistal, axis: .z),
            
            "rightLittleProximalX": PoseControl(button: rightLittleProximalXbutton, bone: .rightLittleProximal, axis: .x),
            "rightLittleProximalY": PoseControl(button: rightLittleProximalYbutton, bone: .rightLittleProximal, axis: .y),
            "rightLittleProximalZ": PoseControl(button: rightLittleProximalZbutton, bone: .rightLittleProximal, axis: .z),
            "rightLittleIntermediateX": PoseControl(button: rightLittleIntermediateXbutton, bone: .rightLittleIntermediate, axis: .x),
            "rightLittleIntermediateY": PoseControl(button: rightLittleIntermediateYbutton, bone: .rightLittleIntermediate, axis: .y),
            "rightLittleIntermediateZ": PoseControl(button: rightLittleIntermediateZbutton, bone: .rightLittleIntermediate, axis: .z),
            "rightLittleDistalX": PoseControl(button: rightLittleDistalXbutton, bone: .rightLittleDistal, axis: .x),
            "rightLittleDistalY": PoseControl(button: rightLittleDistalYbutton, bone: .rightLittleDistal, axis: .y),
            "rightLittleDistalZ": PoseControl(button: rightLittleDistalZbutton, bone: .rightLittleDistal, axis: .z)
        ]
    }

    func countMove(_ ButtonName:UIButton,_ count:Int,_ bones:Humanoid.Bones,_ axis:Int ) -> Int {
        
        print("countMove()","count:",count,"bones:",bones,"axis:",axis)
        
        let avatar = avatarView.avatar
        var count2 = 0
        
        let axisSuffix: String
        switch axis {
        case 1: axisSuffix = "X"
        case 2: axisSuffix = "Y"
        case 3: axisSuffix = "Z"
        default: axisSuffix = ""
        }
        let axisKey = "\(bones)\(axisSuffix)"

        if replayMode == false{ //ボタンを押した回数のcountを加算する
            //------------------------------------ここはボタンを押した時に実行されるべき
            
            let currentCount = postureDictionary[axisKey] ?? 0
            count2 = currentCount + 1
            
            if count2 == 20{
                count2 = 0
            }
            
            //print("count2:",count2)
            
            switch axis{
            case 1 : postureDictionary["\(bones)"+"X"] = count2
                print("postureDictionary[bonesX]:",postureDictionary["\(bones)"+"X"] ?? -1)
            case 2 : postureDictionary["\(bones)"+"Y"] = count2
                print("postureDictionary[bonesY]:",postureDictionary["\(bones)"+"Y"] ?? -1)
            case 3 : postureDictionary["\(bones)"+"Z"] = count2
                print("postureDictionary[bonesZ]:",postureDictionary["\(bones)"+"Z"] ?? -1)
            default: print("axisError")
            }
            
            //-----------------------------------------
        }else{ //ボタンを押さずに実行された時 countは保存データから参照
            count2 = postureDictionary[axisKey] ?? -1
            //print("count2:",count2)
        }
        
        
        
        guard var xcount = postureDictionary["\(bones)"+"X"] else { return -1 }
        guard var ycount = postureDictionary["\(bones)"+"Y"] else { return -1 }
        guard var zcount = postureDictionary["\(bones)"+"Z"] else { return -1 }
        
        if resetMode == true {
            xcount = 0
            ycount = 0
            zcount = 0
        }
        
        //print("xcount:",xcount,"ycount:",ycount,"zcount",zcount)
        
        let range = motionRanges[bones] ?? MotionRange.zero
        let rangeOfMotionXMin = range.xMin
        let rangeOfMotionXMax = range.xMax
        let rangeOfMotionYMin = range.yMin
        let rangeOfMotionYMax = range.yMax
        let rangeOfMotionZMin = range.zMin
        let rangeOfMotionZMax = range.zMax
        
        let rxmin020 = Int(floor(0.20 * rangeOfMotionXMin))
        let rxmin040 = Int(floor(0.40 * rangeOfMotionXMin))
        let rxmin060 = Int(floor(0.60 * rangeOfMotionXMin))
        let rxmin080 = Int(floor(0.80 * rangeOfMotionXMin))
        let rxmin100 = Int(floor(1.00 * rangeOfMotionXMin))
        
        let rxmax020 = Int(floor(0.20 * rangeOfMotionXMax))
        let rxmax040 = Int(floor(0.40 * rangeOfMotionXMax))
        let rxmax060 = Int(floor(0.60 * rangeOfMotionXMax))
        let rxmax080 = Int(floor(0.80 * rangeOfMotionXMax))
        let rxmax100 = Int(floor(1.00 * rangeOfMotionXMax))
        
        let rangeXArray = [0,rxmin020,rxmin040,rxmin060,rxmin080,rxmin100,rxmin080,rxmin060,rxmin040,rxmin020,0,rxmax020,rxmax040,rxmax060,rxmax080,rxmax100,rxmax080,rxmax060,rxmax040,rxmax020,0]
        //print("rangeXArray",rangeXArray)
        
        let xpi = Float(rangeXArray[xcount]) * .pi / 180
        
        let rymin020 = Int(floor(0.20 * rangeOfMotionYMin))
        let rymin040 = Int(floor(0.40 * rangeOfMotionYMin))
        let rymin060 = Int(floor(0.60 * rangeOfMotionYMin))
        let rymin080 = Int(floor(0.80 * rangeOfMotionYMin))
        let rymin100 = Int(floor(1.00 * rangeOfMotionYMin))
        
        let rymax020 = Int(floor(0.20 * rangeOfMotionYMax))
        let rymax040 = Int(floor(0.40 * rangeOfMotionYMax))
        let rymax060 = Int(floor(0.60 * rangeOfMotionYMax))
        let rymax080 = Int(floor(0.80 * rangeOfMotionYMax))
        let rymax100 = Int(floor(1.00 * rangeOfMotionYMax))
        
        let rangeYArray = [0,rymin020,rymin040,rymin060,rymin080,rymin100,rymin080,rymin060,rymin040,rymin020,0,rymax020,rymax040,rymax060,rymax080,rymax100,rymax080,rymax060,rymax040,rymax020,0]
        //print("rangeYArray",rangeYArray)
        
        let ypi = Float(rangeYArray[ycount]) * .pi / 180
        
        let rzmin020 = Int(floor(0.20 * rangeOfMotionZMin))
        let rzmin040 = Int(floor(0.40 * rangeOfMotionZMin))
        let rzmin060 = Int(floor(0.60 * rangeOfMotionZMin))
        let rzmin080 = Int(floor(0.80 * rangeOfMotionZMin))
        let rzmin100 = Int(floor(1.00 * rangeOfMotionZMin))
        
        let rzmax020 = Int(floor(0.20 * rangeOfMotionZMax))
        let rzmax040 = Int(floor(0.40 * rangeOfMotionZMax))
        let rzmax060 = Int(floor(0.60 * rangeOfMotionZMax))
        let rzmax080 = Int(floor(0.80 * rangeOfMotionZMax))
        let rzmax100 = Int(floor(1.00 * rangeOfMotionZMax))
        
        let rangeZArray = [0,rzmin020,rzmin040,rzmin060,rzmin080,rzmin100,rzmin080,rzmin060,rzmin040,rzmin020,0,rzmax020,rzmax040,rzmax060,rzmax080,rzmax100,rzmax080,rzmax060,rzmax040,rzmax020,0]
        //print("rangeZArray",rangeZArray)
        
        let zpi = Float(rangeZArray[zcount]) * .pi / 180
        //print("xpi:",xpi,"ypi:",ypi,"zpi:",zpi)
        
        
        switch axis {
           case 1:
            ButtonName.setTitle(String(rangeXArray[xcount]), for: UIControl.State.normal)
            
           case 2:
            ButtonName.setTitle(String(rangeYArray[ycount]), for: UIControl.State.normal)
            
           case 3:
            ButtonName.setTitle(String(rangeZArray[zcount]), for: UIControl.State.normal)
            
           default:print("buttonTitleError")
        }
        
        avatar.humanoid.node(for: bones)?.eulerAngles = SCNVector3(xpi,ypi,zpi)
        
        return count2
    }
    
    /*可動域メモ　範囲の値を12等分？する 30.0のところを変数にしてCASEで場合分け？ 表示カウントも応じて修正
     case hips すべて
     case leftUpperLeg  ±150 ±90 ±30
     case rightUpperLeg
     case leftLowerLeg -150 0 0 (0はボタンを非表示にする）
     case rightLowerLeg
     case leftFoot ±30 ±30 0
     case rightFoot
     case spine -150~30 ±60 ±60
     case neck -30~60 ±60 ±30
     case head 0 0 0
     case leftShoulder ±30 ±30 ±30
     case rightShoulder
     case leftUpperArm ±30 ±30 ±90
     case rightUpperArm
     case leftLowerArm ±30 -150 150
     case rightLowerArm ±30 150 -150
     case leftHand 0 ±30 ±60
     case rightHand
     case leftToes ±30 0 0
     case rightToes
     case leftEye ±30 ±30 ±30
     case rightEye
     case jaw 0 0 0
     case leftThumbProximal 0 0 0
     case leftThumbIntermediate 0 60 0
     case leftThumbDistal 0 60 0
     case leftIndexProximal 0 0 90
     case leftIndexIntermediate 0 0 90
     case leftIndexDistal 0 0 60
     case leftMiddleProximal
     case leftMiddleIntermediate
     case leftMiddleDistal
     case leftRingProximal
     case leftRingIntermediate
     case leftRingDistal
     case leftLittleProximal
     case leftLittleIntermediate
     case leftLittleDistal
     case rightThumbProximal 0 0 0
     case rightThumbIntermediate 0 -60 0
     case rightThumbDistal 0 -60 0
     case rightIndexProximal
     case rightIndexIntermediate
     case rightIndexDistal
     case rightMiddleProximal
     case rightMiddleIntermediate
     case rightMiddleDistal
     case rightRingProximal
     case rightRingIntermediate
     case rightRingDistal
     case rightLittleProximal
     case rightLittleIntermediate
     case rightLittleDistal
     case upperChest ±30 ±30 ±30
     */
    
    
    
    @IBOutlet weak var hipsXbutton: UIButton!
    var hipsXcount = 0 
    @IBAction func hipsX(_ sender: Any) {
        hipsXcount = countMove(hipsXbutton,hipsXcount,.hips,1)
    }
    
    @IBOutlet weak var hipsYbutton: UIButton!
    var hipsYcount = 0
    @IBAction func hipsY(_ sender: Any) {
        hipsYcount = countMove(hipsYbutton,hipsYcount,.hips,2)
    }
    
    @IBOutlet weak var hipsZbutton: UIButton!
    var hipsZcount = 0
    @IBAction func hipsZ(_ sender: Any) {
        hipsZcount = countMove(hipsZbutton,hipsZcount,.hips,3)
    }
    
    @IBOutlet weak var leftUpperLegXbutton: UIButton!
    var leftUpperLegXcount = 0
    @IBAction func leftUpperLegX(_ sender: Any) {
        leftUpperLegXcount = countMove(leftUpperLegXbutton,leftUpperLegXcount,.leftUpperLeg,1)
    }
    
    @IBOutlet weak var leftUpperLegYbutton: UIButton!
    var leftUpperLegYcount = 0
    @IBAction func leftUpperLegY(_ sender: Any) {
        leftUpperLegYcount = countMove(leftUpperLegYbutton,leftUpperLegYcount,.leftUpperLeg,2)
    }
    
    @IBOutlet weak var leftUpperLegZbutton: UIButton!
    var leftUpperLegZcount = 0
    @IBAction func leftUpperLegZ(_ sender: Any) {
        leftUpperLegZcount = countMove(leftUpperLegZbutton,leftUpperLegZcount,.leftUpperLeg,3)
    }
    
    @IBOutlet weak var rightUpperLegXbutton: UIButton!
    var rightUpperLegXcount = 0
    @IBAction func rightUpperLegX(_ sender: Any) {
        rightUpperLegXcount = countMove(rightUpperLegXbutton,rightUpperLegXcount,.rightUpperLeg,1)
    }

    @IBOutlet weak var rightUpperLegYbutton: UIButton!
    var rightUpperLegYcount = 0
    @IBAction func rightUpperLegY(_ sender: Any) {
        rightUpperLegYcount = countMove(rightUpperLegYbutton,rightUpperLegYcount,.rightUpperLeg,2)
    }
        
    @IBOutlet weak var rightUpperLegZbutton: UIButton!
    var rightUpperLegZcount = 0
    @IBAction func rightUpperLegZ(_ sender: Any) {
        rightUpperLegZcount = countMove(rightUpperLegZbutton,rightUpperLegZcount,.rightUpperLeg,3)
    }
    
    @IBOutlet weak var leftLowerLegXbutton: UIButton!
    var leftLowerLegXcount = 0
    @IBAction func leftLowerLegX(_ sender: Any) {
        leftLowerLegXcount = countMove(leftLowerLegXbutton,leftLowerLegXcount,.leftLowerLeg,1)
    }

    @IBOutlet weak var leftLowerLegYbutton: UIButton!
    var leftLowerLegYcount = 0
    @IBAction func leftLowerLegY(_ sender: Any) {
        leftLowerLegYcount = countMove(leftLowerLegYbutton,leftLowerLegYcount,.leftLowerLeg,2)
    }
        
    @IBOutlet weak var leftLowerLegZbutton: UIButton!
    var leftLowerLegZcount = 0
    @IBAction func leftLowerLegZ(_ sender: Any) {
        leftLowerLegZcount = countMove(leftLowerLegZbutton,leftLowerLegZcount,.leftLowerLeg,3)
    }
    
    @IBOutlet weak var rightLowerLegXbutton: UIButton!
    var rightLowerLegXcount = 0
    @IBAction func rightLowerLegX(_ sender: Any) {
        rightLowerLegXcount = countMove(rightLowerLegXbutton,rightLowerLegXcount,.rightLowerLeg,1)
    }

    @IBOutlet weak var rightLowerLegYbutton: UIButton!
    var rightLowerLegYcount = 0
    @IBAction func rightLowerLegY(_ sender: Any) {
        rightLowerLegYcount = countMove(rightLowerLegYbutton,rightLowerLegYcount,.rightLowerLeg,2)
    }
        
    @IBOutlet weak var rightLowerLegZbutton: UIButton!
    var rightLowerLegZcount = 0
    @IBAction func rightLowerLegZ(_ sender: Any) {
        rightLowerLegZcount = countMove(rightLowerLegZbutton,rightLowerLegZcount,.rightLowerLeg,3)
    }
    
    @IBOutlet weak var leftFootXbutton: UIButton!
    var leftFootXcount = 0
    @IBAction func leftFootX(_ sender: Any) {
        leftFootXcount = countMove(leftFootXbutton,leftFootXcount,.leftFoot,1)
    }

    @IBOutlet weak var leftFootYbutton: UIButton!
    var leftFootYcount = 0
    @IBAction func leftFootY(_ sender: Any) {
        leftFootYcount = countMove(leftFootYbutton,leftFootYcount,.leftFoot,2)
    }
        
    @IBOutlet weak var leftFootZbutton: UIButton!
    var leftFootZcount = 0
    @IBAction func leftFootZ(_ sender: Any) {
        leftFootZcount = countMove(leftFootZbutton,leftFootZcount,.leftFoot,3)
    }
    
    @IBOutlet weak var rightFootXbutton: UIButton!
    var rightFootXcount = 0
    @IBAction func rightFootX(_ sender: Any) {
        rightFootXcount = countMove(rightFootXbutton,rightFootXcount,.rightFoot,1)
    }

    @IBOutlet weak var rightFootYbutton: UIButton!
    var rightFootYcount = 0
    @IBAction func rightFootY(_ sender: Any) {
        rightFootYcount = countMove(rightFootYbutton,rightFootYcount,.rightFoot,2)
    }
        
    @IBOutlet weak var rightFootZbutton: UIButton!
    var rightFootZcount = 0
    @IBAction func rightFootZ(_ sender: Any) {
        rightFootZcount = countMove(rightFootZbutton,rightFootZcount,.rightFoot,3)
    }
    
    @IBOutlet weak var spineXbutton: UIButton!
    var spineXcount = 0
    @IBAction func spineX(_ sender: Any) {
        spineXcount = countMove(spineXbutton,spineXcount,.spine,1)
    }

    @IBOutlet weak var spineYbutton: UIButton!
    var spineYcount = 0
    @IBAction func spineY(_ sender: Any) {
        spineYcount = countMove(spineYbutton,spineYcount,.spine,2)
    }
        
    @IBOutlet weak var spineZbutton: UIButton!
    var spineZcount = 0
    @IBAction func spineZ(_ sender: Any) {
        spineZcount = countMove(spineZbutton,spineZcount,.spine,3)
    }
    
    @IBOutlet weak var neckXbutton: UIButton!
    var neckXcount = 0
    @IBAction func neckX(_ sender: Any) {
        neckXcount = countMove(neckXbutton,neckXcount,.neck,1)
    }

    @IBOutlet weak var neckYbutton: UIButton!
    var neckYcount = 0
    @IBAction func neckY(_ sender: Any) {
        neckYcount = countMove(neckYbutton,neckYcount,.neck,2)
    }
        
    @IBOutlet weak var neckZbutton: UIButton!
    var neckZcount = 0
    @IBAction func neckZ(_ sender: Any) {
        neckZcount = countMove(neckZbutton,neckZcount,.neck,3)
    }
    
    @IBOutlet weak var headXbutton: UIButton!
    var headXcount = 0
    @IBAction func headX(_ sender: Any) {
        headXcount = countMove(headXbutton,headXcount,.head,1)
    }

    @IBOutlet weak var headYbutton: UIButton!
    var headYcount = 0
    @IBAction func headY(_ sender: Any) {
        headYcount = countMove(headYbutton,headYcount,.head,2)
    }
        
    @IBOutlet weak var headZbutton: UIButton!
    var headZcount = 0
    @IBAction func headZ(_ sender: Any) {
        headZcount = countMove(headZbutton,headZcount,.head,3)
    }
    
    @IBOutlet weak var leftShoulderXbutton: UIButton!
    var leftShoulderXcount = 0
    @IBAction func leftShoulderX(_ sender: Any) {
        leftShoulderXcount = countMove(leftShoulderXbutton,leftShoulderXcount,.leftShoulder,1)
    }

    @IBOutlet weak var leftShoulderYbutton: UIButton!
    var leftShoulderYcount = 0
    @IBAction func leftShoulderY(_ sender: Any) {
        leftShoulderYcount = countMove(leftShoulderYbutton,leftShoulderYcount,.leftShoulder,2)
    }
        
    @IBOutlet weak var leftShoulderZbutton: UIButton!
    var leftShoulderZcount = 0
    @IBAction func leftShoulderZ(_ sender: Any) {
        leftShoulderZcount = countMove(leftShoulderZbutton,leftShoulderZcount,.leftShoulder,3)
    }
    
    @IBOutlet weak var rightShoulderXbutton: UIButton!
    var rightShoulderXcount = 0
    @IBAction func rightShoulderX(_ sender: Any) {
        rightShoulderXcount = countMove(rightShoulderXbutton,rightShoulderXcount,.rightShoulder,1)
    }

    @IBOutlet weak var rightShoulderYbutton: UIButton!
    var rightShoulderYcount = 0
    @IBAction func rightShoulderY(_ sender: Any) {
        rightShoulderYcount = countMove(rightShoulderYbutton,rightShoulderYcount,.rightShoulder,2)
    }
        
    @IBOutlet weak var rightShoulderZbutton: UIButton!
    var rightShoulderZcount = 0
    @IBAction func rightShoulderZ(_ sender: Any) {
        rightShoulderZcount = countMove(rightShoulderZbutton,rightShoulderZcount,.rightShoulder,3)
    }
    
    @IBOutlet weak var leftUpperArmXbutton: UIButton!
    var leftUpperArmXcount = 0
    @IBAction func leftUpperArmX(_ sender: Any) {
        leftUpperArmXcount = countMove(leftUpperArmXbutton,leftUpperArmXcount,.leftUpperArm,1)
    }

    @IBOutlet weak var leftUpperArmYbutton: UIButton!
    var leftUpperArmYcount = 0
    @IBAction func leftUpperArmY(_ sender: Any) {
        leftUpperArmYcount = countMove(leftUpperArmYbutton,leftUpperArmYcount,.leftUpperArm,2)
    }
        
    @IBOutlet weak var leftUpperArmZbutton: UIButton!
    var leftUpperArmZcount = 0
    @IBAction func leftUpperArmZ(_ sender: Any) {
        leftUpperArmZcount = countMove(leftUpperArmZbutton,leftUpperArmZcount,.leftUpperArm,3)
    }
    
    @IBOutlet weak var rightUpperArmXbutton: UIButton!
    var rightUpperArmXcount = 0 
    @IBAction func rightUpperArmX(_ sender: Any) {
        rightUpperArmXcount = countMove(rightUpperArmXbutton,rightUpperArmXcount,.rightUpperArm,1)
    }

    @IBOutlet weak var rightUpperArmYbutton: UIButton!
    var rightUpperArmYcount = 0
    @IBAction func rightUpperArmY(_ sender: Any) {
        rightUpperArmYcount = countMove(rightUpperArmYbutton,rightUpperArmYcount,.rightUpperArm,2)
    }
        
    @IBOutlet weak var rightUpperArmZbutton: UIButton!
    var rightUpperArmZcount = 0
    @IBAction func rightUpperArmZ(_ sender: Any) {
        rightUpperArmZcount = countMove(rightUpperArmZbutton,rightUpperArmZcount,.rightUpperArm,3)
    }
    
    @IBOutlet weak var leftLowerArmXbutton: UIButton!
    var leftLowerArmXcount = 0 
    @IBAction func leftLowerArmX(_ sender: Any) {
        leftLowerArmXcount = countMove(leftLowerArmXbutton,leftLowerArmXcount,.leftLowerArm,1)
    }

    @IBOutlet weak var leftLowerArmYbutton: UIButton!
    var leftLowerArmYcount = 0
    @IBAction func leftLowerArmY(_ sender: Any) {
        leftLowerArmYcount = countMove(leftLowerArmYbutton,leftLowerArmYcount,.leftLowerArm,2)
    }
        
    @IBOutlet weak var leftLowerArmZbutton: UIButton!
    var leftLowerArmZcount = 0
    @IBAction func leftLowerArmZ(_ sender: Any) {
        leftLowerArmZcount = countMove(leftLowerArmZbutton,leftLowerArmZcount,.leftLowerArm,3)
    }
    
    @IBOutlet weak var rightLowerArmXbutton: UIButton!
    var rightLowerArmXcount = 0 
    @IBAction func rightLowerArmX(_ sender: Any) {
        rightLowerArmXcount = countMove(rightLowerArmXbutton,rightLowerArmXcount,.rightLowerArm,1)
    }

    @IBOutlet weak var rightLowerArmYbutton: UIButton!
    var rightLowerArmYcount = 0
    @IBAction func rightLowerArmY(_ sender: Any) {
        rightLowerArmYcount = countMove(rightLowerArmYbutton,rightLowerArmYcount,.rightLowerArm,2)
    }
        
    @IBOutlet weak var rightLowerArmZbutton: UIButton!
    var rightLowerArmZcount = 0
    @IBAction func rightLowerArmZ(_ sender: Any) {
        rightLowerArmZcount = countMove(rightLowerArmZbutton,rightLowerArmZcount,.rightLowerArm,3)
    }
    
    @IBOutlet weak var leftHandXbutton: UIButton!
    var leftHandXcount = 0 
    @IBAction func leftHandX(_ sender: Any) {
        leftHandXcount = countMove(leftHandXbutton,leftHandXcount,.leftHand,1)
    }

    @IBOutlet weak var leftHandYbutton: UIButton!
    var leftHandYcount = 0
    @IBAction func leftHandY(_ sender: Any) {
        leftHandYcount = countMove(leftHandYbutton,leftHandYcount,.leftHand,2)
    }
        
    @IBOutlet weak var leftHandZbutton: UIButton!
    var leftHandZcount = 0
    @IBAction func leftHandZ(_ sender: Any) {
        leftHandZcount = countMove(leftHandZbutton,leftHandZcount,.leftHand,3)
    }
    
    @IBOutlet weak var rightHandXbutton: UIButton!
    var rightHandXcount = 0 
    @IBAction func rightHandX(_ sender: Any) {
        rightHandXcount = countMove(rightHandXbutton,rightHandXcount,.rightHand,1)
    }

    @IBOutlet weak var rightHandYbutton: UIButton!
    var rightHandYcount = 0
    @IBAction func rightHandY(_ sender: Any) {
        rightHandYcount = countMove(rightHandYbutton,rightHandYcount,.rightHand,2)
    }
        
    @IBOutlet weak var rightHandZbutton: UIButton!
    var rightHandZcount = 0
    @IBAction func rightHandZ(_ sender: Any) {
        rightHandZcount = countMove(rightHandZbutton,rightHandZcount,.rightHand,3)
    }
    
    @IBOutlet weak var leftToesXbutton: UIButton!
    var leftToesXcount = 0 
    @IBAction func leftToesX(_ sender: Any) {
        leftToesXcount = countMove(leftToesXbutton,leftToesXcount,.leftToes,1)
    }

    @IBOutlet weak var leftToesYbutton: UIButton!
    var leftToesYcount = 0
    @IBAction func leftToesY(_ sender: Any) {
        leftToesYcount = countMove(leftToesYbutton,leftToesYcount,.leftToes,2)
    }
        
    @IBOutlet weak var leftToesZbutton: UIButton!
    var leftToesZcount = 0
    @IBAction func leftToesZ(_ sender: Any) {
        leftToesZcount = countMove(leftToesZbutton,leftToesZcount,.leftToes,3)
    }
    
    @IBOutlet weak var rightToesXbutton: UIButton!
    var rightToesXcount = 0 
    @IBAction func rightToesX(_ sender: Any) {
        rightToesXcount = countMove(rightToesXbutton,rightToesXcount,.rightToes,1)
    }

    @IBOutlet weak var rightToesYbutton: UIButton!
    var rightToesYcount = 0
    @IBAction func rightToesY(_ sender: Any) {
        rightToesYcount = countMove(rightToesYbutton,rightToesYcount,.rightToes,2)
    }
        
    @IBOutlet weak var rightToesZbutton: UIButton!
    var rightToesZcount = 0
    @IBAction func rightToesZ(_ sender: Any) {
        rightToesZcount = countMove(rightToesZbutton,rightToesZcount,.rightToes,3)
    }
    
    @IBOutlet weak var leftEyeXbutton: UIButton!
    var leftEyeXcount = 0 
    @IBAction func leftEyeX(_ sender: Any) {
        leftEyeXcount = countMove(leftEyeXbutton,leftEyeXcount,.leftEye,1)
    }

    @IBOutlet weak var leftEyeYbutton: UIButton!
    var leftEyeYcount = 0
    @IBAction func leftEyeY(_ sender: Any) {
        leftEyeYcount = countMove(leftEyeYbutton,leftEyeYcount,.leftEye,2)
    }
        
    @IBOutlet weak var leftEyeZbutton: UIButton!
    var leftEyeZcount = 0
    @IBAction func leftEyeZ(_ sender: Any) {
        leftEyeZcount = countMove(leftEyeZbutton,leftEyeZcount,.leftEye,3)
    }
    
    @IBOutlet weak var rightEyeXbutton: UIButton!
    var rightEyeXcount = 0 
    @IBAction func rightEyeX(_ sender: Any) {
        rightEyeXcount = countMove(rightEyeXbutton,rightEyeXcount,.rightEye,1)
    }

    @IBOutlet weak var rightEyeYbutton: UIButton!
    var rightEyeYcount = 0
    @IBAction func rightEyeY(_ sender: Any) {
        rightEyeYcount = countMove(rightEyeYbutton,rightEyeYcount,.rightEye,2)
    }
        
    @IBOutlet weak var rightEyeZbutton: UIButton!
    var rightEyeZcount = 0
    @IBAction func rightEyeZ(_ sender: Any) {
        rightEyeZcount = countMove(rightEyeZbutton,rightEyeZcount,.rightEye,3)
    }
    
    @IBOutlet weak var jawXbutton: UIButton!
    var jawXcount = 0 
    @IBAction func jawX(_ sender: Any) {
        jawXcount = countMove(jawXbutton,jawXcount,.jaw,1)
    }

    @IBOutlet weak var jawYbutton: UIButton!
    var jawYcount = 0
    @IBAction func jawY(_ sender: Any) {
        jawYcount = countMove(jawYbutton,jawYcount,.jaw,2)
    }
        
    @IBOutlet weak var jawZbutton: UIButton!
    var jawZcount = 0
    @IBAction func jawZ(_ sender: Any) {
        jawZcount = countMove(jawZbutton,jawZcount,.jaw,3)
    }
    
    @IBOutlet weak var leftThumbProximalXbutton: UIButton!
    var leftThumbProximalXcount = 0 
    @IBAction func leftThumbProximalX(_ sender: Any) {
        leftThumbProximalXcount = countMove(leftThumbProximalXbutton,leftThumbProximalXcount,.leftThumbProximal,1)
    }

    @IBOutlet weak var leftThumbProximalYbutton: UIButton!
    var leftThumbProximalYcount = 0
    @IBAction func leftThumbProximalY(_ sender: Any) {
        leftThumbProximalYcount = countMove(leftThumbProximalYbutton,leftThumbProximalYcount,.leftThumbProximal,2)
    }
        
    @IBOutlet weak var leftThumbProximalZbutton: UIButton!
    var leftThumbProximalZcount = 0
    @IBAction func leftThumbProximalZ(_ sender: Any) {
        leftThumbProximalZcount = countMove(leftThumbProximalZbutton,leftThumbProximalZcount,.leftThumbProximal,3)
    }
    
    @IBOutlet weak var leftThumbIntermediateXbutton: UIButton!
    var leftThumbIntermediateXcount = 0 
    @IBAction func leftThumbIntermediateX(_ sender: Any) {
        leftThumbIntermediateXcount = countMove(leftThumbIntermediateXbutton,leftThumbIntermediateXcount,.leftThumbIntermediate,1)
    }

    @IBOutlet weak var leftThumbIntermediateYbutton: UIButton!
    var leftThumbIntermediateYcount = 0
    @IBAction func leftThumbIntermediateY(_ sender: Any) {
        leftThumbIntermediateYcount = countMove(leftThumbIntermediateYbutton,leftThumbIntermediateYcount,.leftThumbIntermediate,2)
    }
        
    @IBOutlet weak var leftThumbIntermediateZbutton: UIButton!
    var leftThumbIntermediateZcount = 0
    @IBAction func leftThumbIntermediateZ(_ sender: Any) {
        leftThumbIntermediateZcount = countMove(leftThumbIntermediateZbutton,leftThumbIntermediateZcount,.leftThumbIntermediate,3)
    }
    
    @IBOutlet weak var leftThumbDistalXbutton: UIButton!
    var leftThumbDistalXcount = 0 
    @IBAction func leftThumbDistalX(_ sender: Any) {
        leftThumbDistalXcount = countMove(leftThumbDistalXbutton,leftThumbDistalXcount,.leftThumbDistal,1)
    }

    @IBOutlet weak var leftThumbDistalYbutton: UIButton!
    var leftThumbDistalYcount = 0
    @IBAction func leftThumbDistalY(_ sender: Any) {
        leftThumbDistalYcount = countMove(leftThumbDistalYbutton,leftThumbDistalYcount,.leftThumbDistal,2)
    }
        
    @IBOutlet weak var leftThumbDistalZbutton: UIButton!
    var leftThumbDistalZcount = 0
    @IBAction func leftThumbDistalZ(_ sender: Any) {
        leftThumbDistalZcount = countMove(leftThumbDistalZbutton,leftThumbDistalZcount,.leftThumbDistal,3)
    }
    
    @IBOutlet weak var leftIndexProximalXbutton: UIButton!
    var leftIndexProximalXcount = 0 
    @IBAction func leftIndexProximalX(_ sender: Any) {
        leftIndexProximalXcount = countMove(leftIndexProximalXbutton,leftIndexProximalXcount,.leftIndexProximal,1)
    }

    @IBOutlet weak var leftIndexProximalYbutton: UIButton!
    var leftIndexProximalYcount = 0
    @IBAction func leftIndexProximalY(_ sender: Any) {
        leftIndexProximalYcount = countMove(leftIndexProximalYbutton,leftIndexProximalYcount,.leftIndexProximal,2)
    }
        
    @IBOutlet weak var leftIndexProximalZbutton: UIButton!
    var leftIndexProximalZcount = 0
    @IBAction func leftIndexProximalZ(_ sender: Any) {
        leftIndexProximalZcount = countMove(leftIndexProximalZbutton,leftIndexProximalZcount,.leftIndexProximal,3)
    }
    
    @IBOutlet weak var leftIndexIntermediateXbutton: UIButton!
    var leftIndexIntermediateXcount = 0 
    @IBAction func leftIndexIntermediateX(_ sender: Any) {
        leftIndexIntermediateXcount = countMove(leftIndexIntermediateXbutton,leftIndexIntermediateXcount,.leftIndexIntermediate,1)
    }

    @IBOutlet weak var leftIndexIntermediateYbutton: UIButton!
    var leftIndexIntermediateYcount = 0
    @IBAction func leftIndexIntermediateY(_ sender: Any) {
        leftIndexIntermediateYcount = countMove(leftIndexIntermediateYbutton,leftIndexIntermediateYcount,.leftIndexIntermediate,2)
    }
        
    @IBOutlet weak var leftIndexIntermediateZbutton: UIButton!
    var leftIndexIntermediateZcount = 0
    @IBAction func leftIndexIntermediateZ(_ sender: Any) {
        leftIndexIntermediateZcount = countMove(leftIndexIntermediateZbutton,leftIndexIntermediateZcount,.leftIndexIntermediate,3)
    }
    
    @IBOutlet weak var leftIndexDistalXbutton: UIButton!
    var leftIndexDistalXcount = 0 
    @IBAction func leftIndexDistalX(_ sender: Any) {
        leftIndexDistalXcount = countMove(leftIndexDistalXbutton,leftIndexDistalXcount,.leftIndexDistal,1)
    }

    @IBOutlet weak var leftIndexDistalYbutton: UIButton!
    var leftIndexDistalYcount = 0
    @IBAction func leftIndexDistalY(_ sender: Any) {
        leftIndexDistalYcount = countMove(leftIndexDistalYbutton,leftIndexDistalYcount,.leftIndexDistal,2)
    }
        
    @IBOutlet weak var leftIndexDistalZbutton: UIButton!
    var leftIndexDistalZcount = 0
    @IBAction func leftIndexDistalZ(_ sender: Any) {
        leftIndexDistalZcount = countMove(leftIndexDistalZbutton,leftIndexDistalZcount,.leftIndexDistal,3)
    }
    
    @IBOutlet weak var leftMiddleProximalXbutton: UIButton!
    var leftMiddleProximalXcount = 0 
    @IBAction func leftMiddleProximalX(_ sender: Any) {
        leftMiddleProximalXcount = countMove(leftMiddleProximalXbutton,leftMiddleProximalXcount,.leftMiddleProximal,1)
    }

    @IBOutlet weak var leftMiddleProximalYbutton: UIButton!
    var leftMiddleProximalYcount = 0
    @IBAction func leftMiddleProximalY(_ sender: Any) {
        leftMiddleProximalYcount = countMove(leftMiddleProximalYbutton,leftMiddleProximalYcount,.leftMiddleProximal,2)
    }
        
    @IBOutlet weak var leftMiddleProximalZbutton: UIButton!
    var leftMiddleProximalZcount = 0
    @IBAction func leftMiddleProximalZ(_ sender: Any) {
        leftMiddleProximalZcount = countMove(leftMiddleProximalZbutton,leftMiddleProximalZcount,.leftMiddleProximal,3)
    }
    
    @IBOutlet weak var leftMiddleIntermediateXbutton: UIButton!
    var leftMiddleIntermediateXcount = 0 
    @IBAction func leftMiddleIntermediateX(_ sender: Any) {
        leftMiddleIntermediateXcount = countMove(leftMiddleIntermediateXbutton,leftMiddleIntermediateXcount,.leftMiddleIntermediate,1)
    }

    @IBOutlet weak var leftMiddleIntermediateYbutton: UIButton!
    var leftMiddleIntermediateYcount = 0
    @IBAction func leftMiddleIntermediateY(_ sender: Any) {
        leftMiddleIntermediateYcount = countMove(leftMiddleIntermediateYbutton,leftMiddleIntermediateYcount,.leftMiddleIntermediate,2)
    }
        
    @IBOutlet weak var leftMiddleIntermediateZbutton: UIButton!
    var leftMiddleIntermediateZcount = 0
    @IBAction func leftMiddleIntermediateZ(_ sender: Any) {
        leftMiddleIntermediateZcount = countMove(leftMiddleIntermediateZbutton,leftMiddleIntermediateZcount,.leftMiddleIntermediate,3)
    }
    
    @IBOutlet weak var leftMiddleDistalXbutton: UIButton!
    var leftMiddleDistalXcount = 0 
    @IBAction func leftMiddleDistalX(_ sender: Any) {
        leftMiddleDistalXcount = countMove(leftMiddleDistalXbutton,leftMiddleDistalXcount,.leftMiddleDistal,1)
    }

    @IBOutlet weak var leftMiddleDistalYbutton: UIButton!
    var leftMiddleDistalYcount = 0
    @IBAction func leftMiddleDistalY(_ sender: Any) {
        leftMiddleDistalYcount = countMove(leftMiddleDistalYbutton,leftMiddleDistalYcount,.leftMiddleDistal,2)
    }
        
    @IBOutlet weak var leftMiddleDistalZbutton: UIButton!
    var leftMiddleDistalZcount = 0
    @IBAction func leftMiddleDistalZ(_ sender: Any) {
        leftMiddleDistalZcount = countMove(leftMiddleDistalZbutton,leftMiddleDistalZcount,.leftMiddleDistal,3)
    }
    
    @IBOutlet weak var leftRingProximalXbutton: UIButton!
    var leftRingProximalXcount = 0 
    @IBAction func leftRingProximalX(_ sender: Any) {
        leftRingProximalXcount = countMove(leftRingProximalXbutton,leftRingProximalXcount,.leftRingProximal,1)
    }

    @IBOutlet weak var leftRingProximalYbutton: UIButton!
    var leftRingProximalYcount = 0
    @IBAction func leftRingProximalY(_ sender: Any) {
        leftRingProximalYcount = countMove(leftRingProximalYbutton,leftRingProximalYcount,.leftRingProximal,2)
    }
        
    @IBOutlet weak var leftRingProximalZbutton: UIButton!
    var leftRingProximalZcount = 0
    @IBAction func leftRingProximalZ(_ sender: Any) {
        leftRingProximalZcount = countMove(leftRingProximalZbutton,leftRingProximalZcount,.leftRingProximal,3)
    }
    
    @IBOutlet weak var leftRingIntermediateXbutton: UIButton!
    var leftRingIntermediateXcount = 0 
    @IBAction func leftRingIntermediateX(_ sender: Any) {
        leftRingIntermediateXcount = countMove(leftRingIntermediateXbutton,leftRingIntermediateXcount,.leftRingIntermediate,1)
    }

    @IBOutlet weak var leftRingIntermediateYbutton: UIButton!
    var leftRingIntermediateYcount = 0
    @IBAction func leftRingIntermediateY(_ sender: Any) {
        leftRingIntermediateYcount = countMove(leftRingIntermediateYbutton,leftRingIntermediateYcount,.leftRingIntermediate,2)
    }
        
    @IBOutlet weak var leftRingIntermediateZbutton: UIButton!
    var leftRingIntermediateZcount = 0
    @IBAction func leftRingIntermediateZ(_ sender: Any) {
        leftRingIntermediateZcount = countMove(leftRingIntermediateZbutton,leftRingIntermediateZcount,.leftRingIntermediate,3)
    }
    
    @IBOutlet weak var leftRingDistalXbutton: UIButton!
    var leftRingDistalXcount = 0 
    @IBAction func leftRingDistalX(_ sender: Any) {
        leftRingDistalXcount = countMove(leftRingDistalXbutton,leftRingDistalXcount,.leftRingDistal,1)
    }

    @IBOutlet weak var leftRingDistalYbutton: UIButton!
    var leftRingDistalYcount = 0
    @IBAction func leftRingDistalY(_ sender: Any) {
        leftRingDistalYcount = countMove(leftRingDistalYbutton,leftRingDistalYcount,.leftRingDistal,2)
    }
        
    @IBOutlet weak var leftRingDistalZbutton: UIButton!
    var leftRingDistalZcount = 0
    @IBAction func leftRingDistalZ(_ sender: Any) {
        leftRingDistalZcount = countMove(leftRingDistalZbutton,leftRingDistalZcount,.leftRingDistal,3)
    }
    
    @IBOutlet weak var leftLittleProximalXbutton: UIButton!
    var leftLittleProximalXcount = 0 
    @IBAction func leftLittleProximalX(_ sender: Any) {
        leftLittleProximalXcount = countMove(leftLittleProximalXbutton,leftLittleProximalXcount,.leftLittleProximal,1)
    }

    @IBOutlet weak var leftLittleProximalYbutton: UIButton!
    var leftLittleProximalYcount = 0
    @IBAction func leftLittleProximalY(_ sender: Any) {
        leftLittleProximalYcount = countMove(leftLittleProximalYbutton,leftLittleProximalYcount,.leftLittleProximal,2)
    }
        
    @IBOutlet weak var leftLittleProximalZbutton: UIButton!
    var leftLittleProximalZcount = 0
    @IBAction func leftLittleProximalZ(_ sender: Any) {
        leftLittleProximalZcount = countMove(leftLittleProximalZbutton,leftLittleProximalZcount,.leftLittleProximal,3)
    }
    
    @IBOutlet weak var leftLittleIntermediateXbutton: UIButton!
    var leftLittleIntermediateXcount = 0 
    @IBAction func leftLittleIntermediateX(_ sender: Any) {
        leftLittleIntermediateXcount = countMove(leftLittleIntermediateXbutton,leftLittleIntermediateXcount,.leftLittleIntermediate,1)
    }

    @IBOutlet weak var leftLittleIntermediateYbutton: UIButton!
    var leftLittleIntermediateYcount = 0
    @IBAction func leftLittleIntermediateY(_ sender: Any) {
        leftLittleIntermediateYcount = countMove(leftLittleIntermediateYbutton,leftLittleIntermediateYcount,.leftLittleIntermediate,2)
    }
        
    @IBOutlet weak var leftLittleIntermediateZbutton: UIButton!
    var leftLittleIntermediateZcount = 0
    @IBAction func leftLittleIntermediateZ(_ sender: Any) {
        leftLittleIntermediateZcount = countMove(leftLittleIntermediateZbutton,leftLittleIntermediateZcount,.leftLittleIntermediate,3)
    }
    
    @IBOutlet weak var leftLittleDistalXbutton: UIButton!
    var leftLittleDistalXcount = 0 
    @IBAction func leftLittleDistalX(_ sender: Any) {
        leftLittleDistalXcount = countMove(leftLittleDistalXbutton,leftLittleDistalXcount,.leftLittleDistal,1)
    }

    @IBOutlet weak var leftLittleDistalYbutton: UIButton!
    var leftLittleDistalYcount = 0
    @IBAction func leftLittleDistalY(_ sender: Any) {
        leftLittleDistalYcount = countMove(leftLittleDistalYbutton,leftLittleDistalYcount,.leftLittleDistal,2)
    }
        
    @IBOutlet weak var leftLittleDistalZbutton: UIButton!
    var leftLittleDistalZcount = 0
    @IBAction func leftLittleDistalZ(_ sender: Any) {
        leftLittleDistalZcount = countMove(leftLittleDistalZbutton,leftLittleDistalZcount,.leftLittleDistal,3)
    }
    
    @IBOutlet weak var rightThumbProximalXbutton: UIButton!
    var rightThumbProximalXcount = 0 
    @IBAction func rightThumbProximalX(_ sender: Any) {
        rightThumbProximalXcount = countMove(rightThumbProximalXbutton,rightThumbProximalXcount,.rightThumbProximal,1)
    }

    @IBOutlet weak var rightThumbProximalYbutton: UIButton!
    var rightThumbProximalYcount = 0
    @IBAction func rightThumbProximalY(_ sender: Any) {
        rightThumbProximalYcount = countMove(rightThumbProximalYbutton,rightThumbProximalYcount,.rightThumbProximal,2)
    }
        
    @IBOutlet weak var rightThumbProximalZbutton: UIButton!
    var rightThumbProximalZcount = 0
    @IBAction func rightThumbProximalZ(_ sender: Any) {
        rightThumbProximalZcount = countMove(rightThumbProximalZbutton,rightThumbProximalZcount,.rightThumbProximal,3)
    }
    
    @IBOutlet weak var rightThumbIntermediateXbutton: UIButton!
    var rightThumbIntermediateXcount = 0 
    @IBAction func rightThumbIntermediateX(_ sender: Any) {
        rightThumbIntermediateXcount = countMove(rightThumbIntermediateXbutton,rightThumbIntermediateXcount,.rightThumbIntermediate,1)
    }

    @IBOutlet weak var rightThumbIntermediateYbutton: UIButton!
    var rightThumbIntermediateYcount = 0
    @IBAction func rightThumbIntermediateY(_ sender: Any) {
        rightThumbIntermediateYcount = countMove(rightThumbIntermediateYbutton,rightThumbIntermediateYcount,.rightThumbIntermediate,2)
    }
        
    @IBOutlet weak var rightThumbIntermediateZbutton: UIButton!
    var rightThumbIntermediateZcount = 0
    @IBAction func rightThumbIntermediateZ(_ sender: Any) {
        rightThumbIntermediateZcount = countMove(rightThumbIntermediateZbutton,rightThumbIntermediateZcount,.rightThumbIntermediate,3)
    }
    
    @IBOutlet weak var rightThumbDistalXbutton: UIButton!
    var rightThumbDistalXcount = 0 
    @IBAction func rightThumbDistalX(_ sender: Any) {
        rightThumbDistalXcount = countMove(rightThumbDistalXbutton,rightThumbDistalXcount,.rightThumbDistal,1)
    }

    @IBOutlet weak var rightThumbDistalYbutton: UIButton!
    var rightThumbDistalYcount = 0
    @IBAction func rightThumbDistalY(_ sender: Any) {
        rightThumbDistalYcount = countMove(rightThumbDistalYbutton,rightThumbDistalYcount,.rightThumbDistal,2)
    }
        
    @IBOutlet weak var rightThumbDistalZbutton: UIButton!
    var rightThumbDistalZcount = 0
    @IBAction func rightThumbDistalZ(_ sender: Any) {
        rightThumbDistalZcount = countMove(rightThumbDistalZbutton,rightThumbDistalZcount,.rightThumbDistal,3)
    }
    
    @IBOutlet weak var rightIndexProximalXbutton: UIButton!
    var rightIndexProximalXcount = 0 
    @IBAction func rightIndexProximalX(_ sender: Any) {
        rightIndexProximalXcount = countMove(rightIndexProximalXbutton,rightIndexProximalXcount,.rightIndexProximal,1)
    }

    @IBOutlet weak var rightIndexProximalYbutton: UIButton!
    var rightIndexProximalYcount = 0
    @IBAction func rightIndexProximalY(_ sender: Any) {
        rightIndexProximalYcount = countMove(rightIndexProximalYbutton,rightIndexProximalYcount,.rightIndexProximal,2)
    }
        
    @IBOutlet weak var rightIndexProximalZbutton: UIButton!
    var rightIndexProximalZcount = 0
    @IBAction func rightIndexProximalZ(_ sender: Any) {
        rightIndexProximalZcount = countMove(rightIndexProximalZbutton,rightIndexProximalZcount,.rightIndexProximal,3)
    }
    
    @IBOutlet weak var rightIndexIntermediateXbutton: UIButton!
    var rightIndexIntermediateXcount = 0 
    @IBAction func rightIndexIntermediateX(_ sender: Any) {
        rightIndexIntermediateXcount = countMove(rightIndexIntermediateXbutton,rightIndexIntermediateXcount,.rightIndexIntermediate,1)
    }

    @IBOutlet weak var rightIndexIntermediateYbutton: UIButton!
    var rightIndexIntermediateYcount = 0
    @IBAction func rightIndexIntermediateY(_ sender: Any) {
        rightIndexIntermediateYcount = countMove(rightIndexIntermediateYbutton,rightIndexIntermediateYcount,.rightIndexIntermediate,2)
    }
        
    @IBOutlet weak var rightIndexIntermediateZbutton: UIButton!
    var rightIndexIntermediateZcount = 0
    @IBAction func rightIndexIntermediateZ(_ sender: Any) {
        rightIndexIntermediateZcount = countMove(rightIndexIntermediateZbutton,rightIndexIntermediateZcount,.rightIndexIntermediate,3)
    }
    
    @IBOutlet weak var rightIndexDistalXbutton: UIButton!
    var rightIndexDistalXcount = 0 
    @IBAction func rightIndexDistalX(_ sender: Any) {
        rightIndexDistalXcount = countMove(rightIndexDistalXbutton,rightIndexDistalXcount,.rightIndexDistal,1)
    }

    @IBOutlet weak var rightIndexDistalYbutton: UIButton!
    var rightIndexDistalYcount = 0
    @IBAction func rightIndexDistalY(_ sender: Any) {
        rightIndexDistalYcount = countMove(rightIndexDistalYbutton,rightIndexDistalYcount,.rightIndexDistal,2)
    }
        
    @IBOutlet weak var rightIndexDistalZbutton: UIButton!
    var rightIndexDistalZcount = 0
    @IBAction func rightIndexDistalZ(_ sender: Any) {
        rightIndexDistalZcount = countMove(rightIndexDistalZbutton,rightIndexDistalZcount,.rightIndexDistal,3)
    }
    
    @IBOutlet weak var rightMiddleProximalXbutton: UIButton!
    var rightMiddleProximalXcount = 0 
    @IBAction func rightMiddleProximalX(_ sender: Any) {
        rightMiddleProximalXcount = countMove(rightMiddleProximalXbutton,rightMiddleProximalXcount,.rightMiddleProximal,1)
    }

    @IBOutlet weak var rightMiddleProximalYbutton: UIButton!
    var rightMiddleProximalYcount = 0
    @IBAction func rightMiddleProximalY(_ sender: Any) {
        rightMiddleProximalYcount = countMove(rightMiddleProximalYbutton,rightMiddleProximalYcount,.rightMiddleProximal,2)
    }
        
    @IBOutlet weak var rightMiddleProximalZbutton: UIButton!
    var rightMiddleProximalZcount = 0
    @IBAction func rightMiddleProximalZ(_ sender: Any) {
        rightMiddleProximalZcount = countMove(rightMiddleProximalZbutton,rightMiddleProximalZcount,.rightMiddleProximal,3)
    }
    
    @IBOutlet weak var rightMiddleIntermediateXbutton: UIButton!
    var rightMiddleIntermediateXcount = 0 
    @IBAction func rightMiddleIntermediateX(_ sender: Any) {
        rightMiddleIntermediateXcount = countMove(rightMiddleIntermediateXbutton,rightMiddleIntermediateXcount,.rightMiddleIntermediate,1)
    }

    @IBOutlet weak var rightMiddleIntermediateYbutton: UIButton!
    var rightMiddleIntermediateYcount = 0
    @IBAction func rightMiddleIntermediateY(_ sender: Any) {
        rightMiddleIntermediateYcount = countMove(rightMiddleIntermediateYbutton,rightMiddleIntermediateYcount,.rightMiddleIntermediate,2)
    }
        
    @IBOutlet weak var rightMiddleIntermediateZbutton: UIButton!
    var rightMiddleIntermediateZcount = 0
    @IBAction func rightMiddleIntermediateZ(_ sender: Any) {
        rightMiddleIntermediateZcount = countMove(rightMiddleIntermediateZbutton,rightMiddleIntermediateZcount,.rightMiddleIntermediate,3)
    }
    
    @IBOutlet weak var rightMiddleDistalXbutton: UIButton!
    var rightMiddleDistalXcount = 0 
    @IBAction func rightMiddleDistalX(_ sender: Any) {
        rightMiddleDistalXcount = countMove(rightMiddleDistalXbutton,rightMiddleDistalXcount,.rightMiddleDistal,1)
    }

    @IBOutlet weak var rightMiddleDistalYbutton: UIButton!
    var rightMiddleDistalYcount = 0
    @IBAction func rightMiddleDistalY(_ sender: Any) {
        rightMiddleDistalYcount = countMove(rightMiddleDistalYbutton,rightMiddleDistalYcount,.rightMiddleDistal,2)
    }
        
    @IBOutlet weak var rightMiddleDistalZbutton: UIButton!
    var rightMiddleDistalZcount = 0
    @IBAction func rightMiddleDistalZ(_ sender: Any) {
        rightMiddleDistalZcount = countMove(rightMiddleDistalZbutton,rightMiddleDistalZcount,.rightMiddleDistal,3)
    }
    
    @IBOutlet weak var rightRingProximalXbutton: UIButton!
    var rightRingProximalXcount = 0 
    @IBAction func rightRingProximalX(_ sender: Any) {
        rightRingProximalXcount = countMove(rightRingProximalXbutton,rightRingProximalXcount,.rightRingProximal,1)
    }

    @IBOutlet weak var rightRingProximalYbutton: UIButton!
    var rightRingProximalYcount = 0
    @IBAction func rightRingProximalY(_ sender: Any) {
        rightRingProximalYcount = countMove(rightRingProximalYbutton,rightRingProximalYcount,.rightRingProximal,2)
    }
        
    @IBOutlet weak var rightRingProximalZbutton: UIButton!
    var rightRingProximalZcount = 0
    @IBAction func rightRingProximalZ(_ sender: Any) {
        rightRingProximalZcount = countMove(rightRingProximalZbutton,rightRingProximalZcount,.rightRingProximal,3)
    }
    
    @IBOutlet weak var rightRingIntermediateXbutton: UIButton!
    var rightRingIntermediateXcount = 0 
    @IBAction func rightRingIntermediateX(_ sender: Any) {
        rightRingIntermediateXcount = countMove(rightRingIntermediateXbutton,rightRingIntermediateXcount,.rightRingIntermediate,1)
    }

    @IBOutlet weak var rightRingIntermediateYbutton: UIButton!
    var rightRingIntermediateYcount = 0
    @IBAction func rightRingIntermediateY(_ sender: Any) {
        rightRingIntermediateYcount = countMove(rightRingIntermediateYbutton,rightRingIntermediateYcount,.rightRingIntermediate,2)
    }
        
    @IBOutlet weak var rightRingIntermediateZbutton: UIButton!
    var rightRingIntermediateZcount = 0
    @IBAction func rightRingIntermediateZ(_ sender: Any) {
        rightRingIntermediateZcount = countMove(rightRingIntermediateZbutton,rightRingIntermediateZcount,.rightRingIntermediate,3)
    }
    
    @IBOutlet weak var rightRingDistalXbutton: UIButton!
    var rightRingDistalXcount = 0 
    @IBAction func rightRingDistalX(_ sender: Any) {
        rightRingDistalXcount = countMove(rightRingDistalXbutton,rightRingDistalXcount,.rightRingDistal,1)
    }

    @IBOutlet weak var rightRingDistalYbutton: UIButton!
    var rightRingDistalYcount = 0
    @IBAction func rightRingDistalY(_ sender: Any) {
        rightRingDistalYcount = countMove(rightRingDistalYbutton,rightRingDistalYcount,.rightRingDistal,2)
    }
        
    @IBOutlet weak var rightRingDistalZbutton: UIButton!
    var rightRingDistalZcount = 0
    @IBAction func rightRingDistalZ(_ sender: Any) {
        rightRingDistalZcount = countMove(rightRingDistalZbutton,rightRingDistalZcount,.rightRingDistal,3)
    }
    
    @IBOutlet weak var rightLittleProximalXbutton: UIButton!
    var rightLittleProximalXcount = 0 
    @IBAction func rightLittleProximalX(_ sender: Any) {
        rightLittleProximalXcount = countMove(rightLittleProximalXbutton,rightLittleProximalXcount,.rightLittleProximal,1)
    }

    @IBOutlet weak var rightLittleProximalYbutton: UIButton!
    var rightLittleProximalYcount = 0
    @IBAction func rightLittleProximalY(_ sender: Any) {
        rightLittleProximalYcount = countMove(rightLittleProximalYbutton,rightLittleProximalYcount,.rightLittleProximal,2)
    }
        
    @IBOutlet weak var rightLittleProximalZbutton: UIButton!
    var rightLittleProximalZcount = 0
    @IBAction func rightLittleProximalZ(_ sender: Any) {
        rightLittleProximalZcount = countMove(rightLittleProximalZbutton,rightLittleProximalZcount,.rightLittleProximal,3)
    }
    
    @IBOutlet weak var rightLittleIntermediateXbutton: UIButton!
    var rightLittleIntermediateXcount = 0 
    @IBAction func rightLittleIntermediateX(_ sender: Any) {
        rightLittleIntermediateXcount = countMove(rightLittleIntermediateXbutton,rightLittleIntermediateXcount,.rightLittleIntermediate,1)
    }

    @IBOutlet weak var rightLittleIntermediateYbutton: UIButton!
    var rightLittleIntermediateYcount = 0
    @IBAction func rightLittleIntermediateY(_ sender: Any) {
        rightLittleIntermediateYcount = countMove(rightLittleIntermediateYbutton,rightLittleIntermediateYcount,.rightLittleIntermediate,2)
    }
        
    @IBOutlet weak var rightLittleIntermediateZbutton: UIButton!
    var rightLittleIntermediateZcount = 0
    @IBAction func rightLittleIntermediateZ(_ sender: Any) {
        rightLittleIntermediateZcount = countMove(rightLittleIntermediateZbutton,rightLittleIntermediateZcount,.rightLittleIntermediate,3)
    }
    
    @IBOutlet weak var rightLittleDistalXbutton: UIButton!
    var rightLittleDistalXcount = 0 
    @IBAction func rightLittleDistalX(_ sender: Any) {
        rightLittleDistalXcount = countMove(rightLittleDistalXbutton,rightLittleDistalXcount,.rightLittleDistal,1)
    }

    @IBOutlet weak var rightLittleDistalYbutton: UIButton!
    var rightLittleDistalYcount = 0
    @IBAction func rightLittleDistalY(_ sender: Any) {
        rightLittleDistalYcount = countMove(rightLittleDistalYbutton,rightLittleDistalYcount,.rightLittleDistal,2)
    }
        
    @IBOutlet weak var rightLittleDistalZbutton: UIButton!
    var rightLittleDistalZcount = 0
    @IBAction func rightLittleDistalZ(_ sender: Any) {
        rightLittleDistalZcount = countMove(rightLittleDistalZbutton,rightLittleDistalZcount,.rightLittleDistal,3)
    }
    
    @IBOutlet weak var upperChestXbutton: UIButton!
    var upperChestXcount = 0 
    @IBAction func upperChestX(_ sender: Any) {
        upperChestXcount = countMove(upperChestXbutton,upperChestXcount,.upperChest,1)
    }

    @IBOutlet weak var upperChestYbutton: UIButton!
    var upperChestYcount = 0
    @IBAction func upperChestY(_ sender: Any) {
        upperChestYcount = countMove(upperChestYbutton,upperChestYcount,.upperChest,2)
    }
        
    @IBOutlet weak var upperChestZbutton: UIButton!
    var upperChestZcount = 0
    @IBAction func upperChestZ(_ sender: Any) {
        upperChestZcount = countMove(upperChestZbutton,upperChestZcount,.upperChest,3)
    }
    
    //姿勢をDictionary型で管理する（保存はCOREDATEの予定）
    //キー(key)と値(value)の組みで格納
    
    private let postureDefaultsKey = "postureDictionaryKey"
    let userDefaults = UserDefaults.standard
    var resetMode = false
    
    
    @IBAction func reset(_ sender: Any) {
        print("reset")
        resetMode = true
        dataReset()
        resetMode = false
    }
    
    func dataReset(){
        resetPostureState()
        resetAvatarTranslation()
        resetCameraState()
        resetBlendShapes()
    }
    
    private func resetPostureState() {
        postureDictionary = defaultPostureDictionary
        postureDictionary["hipsY"] = 15
        print("postureDictionary reset to default")
        postureStorage.save(postureDictionary)
        let wasResetMode = resetMode
        resetMode = false
        applyPosture(postureDictionary)
        resetMode = wasResetMode
    }
    
    private func resetAvatarTranslation() {
        xMoveCount = 0
        yMoveCount = 0
        zMoveCount = 0
        let avatar = avatarView.avatar
        avatar.position = SCNVector3(0,0,0)
        xMoveButton.setTitle("0", for: UIControl.State.normal)
        yMoveButton.setTitle("0", for: UIControl.State.normal)
        zMoveButton.setTitle("0", for: UIControl.State.normal)
    }
    
    private func resetCameraState() {
        cFOVcount = 0
        cameraFieldOfView = 60
        cPosXcount = 0
        cameraPositionaryX = 0
        cPosYcount = 2
        cameraPositionaryY = Float(countArray[cPosYcount])
        cPosZcount = 3
        cameraPositionaryZ = Float(countArray[cPosZcount])
        cEulXcount = 0
        cameraEulerAnglesX = 0
        cEulYcount = 0
        cameraEulerAnglesY = 0
        cEulZcount = 0
        cameraEulerAnglesZ = 0
        
        let camera = avatarView.cameraNode
        
        camera.camera?.fieldOfView = cameraFieldOfView
        camera.position = SCNVector3(cameraPositionaryX,cameraPositionaryY,cameraPositionaryZ)
        camera.eulerAngles = SCNVector3(0,0,0)
        camera.rotation = SCNVector4(0,0,0,Float.pi / 180)
        
        updateCameraButtonTitles()
    }

    private func resetBlendShapes() {
        let avatar = avatarView.avatar
        BlendShapeHelper.resetPresets(for: avatar)
    }
    
    private func updateCameraButtonTitles() {
        cFOVbutton.setTitle("\(floor(cameraFieldOfView))", for: UIControl.State.normal)
        
        let cpx = cameraPositionaryX * 10
        cPosXbutton.setTitle("\(floor(cpx)/10)", for: UIControl.State.normal)
        let cpy = cameraPositionaryY * 10
        cPosYbutton.setTitle("\(floor(cpy)/10)", for: UIControl.State.normal)
        let cpz = cameraPositionaryZ * 10
        cPosZbutton.setTitle("\(floor(cpz)/10)", for: UIControl.State.normal)
        
        cEulXbutton.setTitle("0", for: UIControl.State.normal)
        cEulYbutton.setTitle("0", for: UIControl.State.normal)
        cEulZbutton.setTitle("0", for: UIControl.State.normal)
    }
    
    //count2が保存されている
    private let defaultPostureDictionary:[String:Int] = ["hipsX":0,"hipsY":15,"hipsZ":0,
    "leftUpperLegX":0,"leftUpperLegY":0,"leftUpperLegZ":0,
    "rightUpperLegX":0,"rightUpperLegY":0,"rightUpperLegZ":0,
    "leftLowerLegX":0,"leftLowerLegY":0,"leftLowerLegZ":0,
    "rightLowerLegX":0,"rightLowerLegY":0,"rightLowerLegZ":0,
    "leftFootX":0,"leftFootY":0,"leftFootZ":0,
    "rightFootX":0,"rightFootY":0,"rightFootZ":0,
    "spineX":0,"spineY":0,"spineZ":0,
    "neckX":0,"neckY":0,"neckZ":0,
    "headX":0,"headY":0,"headZ":0,
    "leftShoulderX":0,"leftShoulderY":0,"leftShoulderZ":0,
    "rightShoulderX":0,"rightShoulderY":0,"rightShoulderZ":0,
    "leftUpperArmX":0,"leftUpperArmY":0,"leftUpperArmZ":0,
    "rightUpperArmX":0,"rightUpperArmY":0,"rightUpperArmZ":0,
    "leftLowerArmX":0,"leftLowerArmY":0,"leftLowerArmZ":0,
    "rightLowerArmX":0,"rightLowerArmY":0,"rightLowerArmZ":0,
    "leftHandX":0,"leftHandY":0,"leftHandZ":0,
    "rightHandX":0,"rightHandY":0,"rightHandZ":0,
    "leftToesX":0,"leftToesY":0,"leftToesZ":0,
    "rightToesX":0,"rightToesY":0,"rightToesZ":0,
    "leftEyeX":0,"leftEyeY":0,"leftEyeZ":0,
    "rightEyeX":0,"rightEyeY":0,"rightEyeZ":0,
    "jawX":0,"jawY":0,"jawZ":0,
    "leftThumbProximalX":0,"leftThumbProximalY":0,"leftThumbProximalZ":0,
    "leftThumbIntermediateX":0,"leftThumbIntermediateY":0,"leftThumbIntermediateZ":0,
    "leftThumbDistalX":0,"leftThumbDistalY":0,"leftThumbDistalZ":0,
    "leftIndexProximalX":0,"leftIndexProximalY":0,"leftIndexProximalZ":0,
    "leftIndexIntermediateX":0,"leftIndexIntermediateY":0,"leftIndexIntermediateZ":0,
    "leftIndexDistalX":0,"leftIndexDistalY":0,"leftIndexDistalZ":0,
    "leftMiddleProximalX":0,"leftMiddleProximalY":0,"leftMiddleProximalZ":0,
    "leftMiddleIntermediateX":0,"leftMiddleIntermediateY":0,"leftMiddleIntermediateZ":0,
    "leftMiddleDistalX":0,"leftMiddleDistalY":0,"leftMiddleDistalZ":0,
    "leftRingProximalX":0,"leftRingProximalY":0,"leftRingProximalZ":0,
    "leftRingIntermediateX":0,"leftRingIntermediateY":0,"leftRingIntermediateZ":0,
    "leftRingDistalX":0,"leftRingDistalY":0,"leftRingDistalZ":0,
    "leftLittleProximalX":0,"leftLittleProximalY":0,"leftLittleProximalZ":0,
    "leftLittleIntermediateX":0,"leftLittleIntermediateY":0,"leftLittleIntermediateZ":0,
    "leftLittleDistalX":0,"leftLittleDistalY":0,"leftLittleDistalZ":0,
    "rightThumbProximalX":0,"rightThumbProximalY":0,"rightThumbProximalZ":0,
    "rightThumbIntermediateX":0,"rightThumbIntermediateY":0,"rightThumbIntermediateZ":0,
    "rightThumbDistalX":0,"rightThumbDistalY":0,"rightThumbDistalZ":0,
    "rightIndexProximalX":0,"rightIndexProximalY":0,"rightIndexProximalZ":0,
    "rightIndexIntermediateX":0,"rightIndexIntermediateY":0,"rightIndexIntermediateZ":0,
    "rightIndexDistalX":0,"rightIndexDistalY":0,"rightIndexDistalZ":0,
    "rightMiddleProximalX":0,"rightMiddleProximalY":0,"rightMiddleProximalZ":0,
    "rightMiddleIntermediateX":0,"rightMiddleIntermediateY":0,"rightMiddleIntermediateZ":0,
    "rightMiddleDistalX":0,"rightMiddleDistalY":0,"rightMiddleDistalZ":0,
    "rightRingProximalX":0,"rightRingProximalY":0,"rightRingProximalZ":0,
    "rightRingIntermediateX":0,"rightRingIntermediateY":0,"rightRingIntermediateZ":0,
    "rightRingDistalX":0,"rightRingDistalY":0,"rightRingDistalZ":0,
    "rightLittleProximalX":0,"rightLittleProximalY":0,"rightLittleProximalZ":0,
    "rightLittleIntermediateX":0,"rightLittleIntermediateY":0,"rightLittleIntermediateZ":0,
    "rightLittleDistalX":0,"rightLittleDistalY":0,"rightLittleDistalZ":0,
    "upperChestX":0,"upperChestY":0,"upperChestZ":0]
    
    var postureDictionary:[String:Int] = [:]
    private lazy var postureStorage = PostureStorage(defaultsKey: postureDefaultsKey, defaultPosture: defaultPostureDictionary, userDefaults: userDefaults)
    
    var buttonNameArray:[UIButton] = []
    var boneNameArray:[Humanoid.Bones] = [.hips,.leftUpperLeg,.rightUpperLeg,.leftLowerLeg,.rightLowerLeg,.leftFoot,.rightFoot,.spine,.neck,.head,.leftShoulder,.rightShoulder,.leftUpperArm,.rightUpperArm,.leftLowerArm,.rightLowerArm,.leftHand,.rightHand,.leftToes,.rightToes,.leftEye,.rightEye,.jaw,.leftThumbProximal,.leftThumbIntermediate,.leftThumbDistal,.leftIndexProximal,.leftIndexIntermediate,.leftIndexDistal,.leftMiddleProximal,.leftMiddleIntermediate,.leftMiddleDistal,.leftRingProximal,.leftRingIntermediate,.leftRingDistal,.leftLittleProximal,.leftLittleIntermediate,.leftLittleDistal,.rightThumbProximal,.rightThumbIntermediate,.rightThumbDistal,.rightIndexProximal,.rightIndexIntermediate,.rightIndexDistal,.rightMiddleProximal,.rightMiddleIntermediate,.rightMiddleDistal,.rightRingProximal,.rightRingIntermediate,.rightRingDistal,.rightLittleProximal,.rightLittleIntermediate,.rightLittleDistal,.upperChest] //53
    
    @IBAction func save(_ sender: Any) {  //データを保存する
        print("save")
        postureStorage.save(postureDictionary)
        print("postureDictionary",postureDictionary)
        exportTextFile()
    }
    
    func movePosture(){
        print("movePosture")
        applyPosture(postureStorage.load())
    }

    private func applyPosture(_ posture: [String:Int]) {
        replayMode = true
        postureDictionary = posture

        //for文で各xyzのcount2を呼び出し、繰り返し姿勢関数を実行する
        for i in postureDictionary.keys { //ランダムにキーがとりだされる　hipsY,neckX,,,
            guard let control = poseControlMap[i] else {
                print("i default", i)
                continue
            }
            let count = postureDictionary[i] ?? -1
            _ = countMove(control.button, count, control.bone, control.axis.rawValue)//返り値は使用しない
        }
        replayMode = false
    }
    
    @IBAction func replay(_ sender: Any) { //初期姿勢から保存先姿勢に変更
        print("replay")
        
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        SCNTransaction.completionBlock = completion
        //avatar.setBlendShape(value: 1, for: .preset(.angry))
        movePosture()
        SCNTransaction.commit()
    }
    
    //データを出力して保存する
    //var messageLabel = UILabel() //処理状態を表示
    var textView = UITextView() //保存するテキストを入力する欄
    
    //保存先を指定
    private var fileUrl: URL {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent("sample.txt")
    }
    
    // 入力されたテキストをファイルに保存する。
    func exportTextFile() {
        
        let postureDictionary00 = postureStorage.load()
        
        let text = postureDictionary00.description //現在の姿勢ArrayをString型にして定義
        
        if FileManager.default.fileExists(atPath: fileUrl.path) {
            // ファイルに書き込み
            do {
                try text.write(to: fileUrl, atomically: false, encoding: .utf8)
                print("ファイルに書き込みました")
                print("fileUrl",fileUrl)
                //messageLabel.text = "ファイルに保存しました。"
            } catch {
                print("Error: \(error)")
            }
        } else {
            // ファイルが存在しないため、新規に作成する。
            if FileManager.default.createFile(
                atPath: fileUrl.path,
                contents: text.data(using: .utf8),
                attributes: nil
                ) {
                //messageLabel.text = "ファイルを新規作成しました。"
                print("ファイルを新規作成しました")
            } else {
                //messageLabel.text = "ファイルの新規作成に失敗しました。"
                print("ファイルの新規作成に失敗しました")
            }
        }
    }

}
