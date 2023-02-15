import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick3D
import Qt3D.Core
import Qt3D.Render
import Qt3D.Input
import Qt3D.Extras
import QtQuick.Scene3D


Item {
    id: predictionWorkspceItem
    width: 800
    height: 800

    Component.onCompleted: {
        window.x = window.x + window.width/2 - width/2
        window.y = window.y + window.height/2 - height/2
        window.width = width
        window.height = height
//        window.x = Screen.width / 2 - width / 2
//        window.y = Screen.height / 2 - height / 2
    }

    Rectangle {
        id: imageHolder
        anchors.fill: parent

        Scene3D {
            anchors.fill: parent
            id: modelscene
            aspects: ["input", "logic"]
            cameraAspectRatioMode: Scene3D.AutomaticAspectRatio

            Entity {
                id: sceneRoot
                Camera {
                    id: camera
                    projectionType: CameraLens.PerspectiveProjection
                    fieldOfView: 30
                    aspectRatio: 16/9
                    nearPlane: 0.1
                    farPlane: 1000
                    position: Qt.vector3d(10, 0, 0)
                    upVector: Qt.vector3d(0, 1, 0)
                    viewCenter: Qt.vector3d(0, 0, 0)
                }
                OrbitCameraController {
                    camera: camera
                }
                components: [
                    RenderSettings {
                        activeFrameGraph: ForwardRenderer {
                            clearColor: Qt.rgba(0, 0.5, 1, 1)
                            camera: camera
                        }
                    }, InputSettings {
                    }
                ]

                Entity {
                    id: monkeyEntity
                    components: [
                        SceneLoader {
                            id: sceneLoader
                            source: "/temp/b_pillar.obj"
                        }

                    ]
                }
            }
        }
    }

    Connections {
        target: backend

        function onPred_updated () {
            resultImage.reload()
        }

        function onPred_close_workspace (){
            window.close()
        }
    }

    Item {
        id: __materialLibrary__
    }
}
