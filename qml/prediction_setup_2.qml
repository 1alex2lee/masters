import QtQuick
import QtQuick.Dialogs
import QtQuick.Window
import QtQuick.Controls

Item {
    id: predictionsetup2item
    width: 300
    height: 700
    Component.onCompleted: {
        window.x = window.x + window.width/2 - width/2
        window.y = window.y + window.height/2 - height/2
        window.width = width
        window.height = height
//        window.x = Screen.width / 2 - width / 2
//        window.y = Screen.height / 2 - height / 2
    }

//Window {
//    id: window
//    width: 300; height: 700
//    title: "User-Centirc Software to Assist Design for Forming"
//    visible: true

    Rectangle {
        id: titleBar
        height: 40
        color: "#e3e3e3"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Text {
            id: titleLabel
            text: qsTr("Quick Prediction Mode")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            font.pixelSize: 16
            verticalAlignment: Text.AlignVCenter
            anchors.bottomMargin: 0
            anchors.leftMargin: 10
            anchors.topMargin: 0
        }
    }

    Rectangle {
        id: diePreview
        height: (parent.height-titleBar.height-bottomNavBar.height)/3
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: titleBar.bottom
        anchors.rightMargin: 0
        anchors.topMargin: 0

        Image {
            id: diePreviewImage
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: diePreviewTitle.bottom
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.topMargin: 10
            fillMode: Image.PreserveAspectFit
            visible: false
        }

        Text {
            id: diePreviewTitle
            text: qsTr("Die Mesh Preview")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }

        ProgressBar {
            id: diePreviewProgress
            anchors.fill: parent
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            value: 0
        }
    }

    Rectangle {
        id: zoomPreview
        height: diePreview.height
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: diePreview.bottom
        anchors.topMargin: 0
        anchors.rightMargin: 0
        Image {
            id: zoomPreviewImage
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: zoomPreviewTitle.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 10
            anchors.rightMargin: 10
            anchors.bottomMargin: 10
            anchors.leftMargin: 10
            fillMode: Image.PreserveAspectFit
        }

        Text {
            id: zoomPreviewTitle
            text: qsTr("Die Mesh Zoomed Preview")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.topMargin: 10
            anchors.leftMargin: 10
        }

        ProgressBar {
            id: zoomPreviewProgress
            anchors.fill: parent
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            value: 0
        }
    }

    Rectangle {
        id: blankPreview
        height: diePreview.height
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: zoomPreview.bottom
        anchors.topMargin: 0
        anchors.rightMargin: 0
        visible: backend.is_blank_loaded()
        Image {
            id: blankPreviewImage
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: blankPreviewTitle.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 10
            anchors.rightMargin: 10
            anchors.bottomMargin: 10
            anchors.leftMargin: 10
            fillMode: Image.PreserveAspectFit
        }

        Text {
            id: blankPreviewTitle
            text: qsTr("Blank Mesh Preview")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.topMargin: 10
            anchors.leftMargin: 10
        }

        ProgressBar {
            id: blankPreviewProgress
            anchors.fill: parent
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            value: 0
        }
    }

    Rectangle {
        id: bottomNavBar
        height: 30
        color: "#e3e3e3"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0

        Button {
            id: nextButton
            x: 398
            text: qsTr("Next")
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            onClicked: mainStack.replace("prediction_setup_3.qml")
//            onClicked: {
//                window.close()
//                var component = Qt.createComponent("prediction_setup_3.qml")
//                var new_window = component.createObject(window)
//                new_window.show()
//                new_window.x = window.x + window.width/2 - new_window.width/2
//                new_window.y = window.y + window.height/2 - new_window.height/2
//            }
        }

        Button {
            id: backButton
            x: 10
            text: qsTr("Back")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            onClicked: mainStack.replace("prediction_setup_1.qml")
//            onClicked: {
//                window.close()
//                var component = Qt.createComponent("prediction_setup_1.qml")
//                var new_window = component.createObject(window)
//                new_window.show()
//                new_window.x = window.x + window.width/2 - new_window.width/2
//                new_window.y = window.y + window.height/2 - new_window.height/2
//            }
        }
    }

    Connections {
        target: backend

        function onLoad_pred_mesh_progress (name, progress) {
            if (name === "non zoom") {
                diePreviewProgress.value = progress
            }
            if (name === "zoom") {
                zoomPreviewProgress.value = progress
            }
            if (name === "blank") {
                blankPreviewProgress.value = progress
            }
        }

        function onLoad_pred_mesh_complete (name) {
            if (name === "non zoom") {
                diePreviewProgress.visible = false
                diePreviewImage.visible = true
                diePreviewImage.source = "../temp/input_0.png"
            }
            if (name === "zoom") {
                zoomPreviewProgress.visible = false
                zoomPreviewImage.visible = true
                zoomPreviewImage.source = "../temp/input_1.png"
            }
            if (name === "blank") {
                blankPreviewProgress.visible = false
                blankPreviewImage.visible = true
                blankPreviewImage.source = "../temp/input_4.png"
            }
        }
    }

}


