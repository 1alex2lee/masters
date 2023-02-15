import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick3D



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

//Window {
//    id: window
//    width: 800; height: 800
//    title: "User-Centirc Software to Assist Design for Forming"
//    visible: true

    MenuBar {
        id: menubar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        Menu {
            title: qsTr("File")
            Action {
                text: qsTr("Import Mesh")
                onTriggered: {
                    mainstack.replace("prediction_setup_1_readd.qml")
//                    window.close()
//                    var component = Qt.createComponent("main.qml")
//                    var new_window = component.createObject(window)
//                    new_window.show()
//                    new_window.x = window.x + window.width/2 - new_window.width/2
//                    new_window.y = window.y + window.height/2 - new_window.height/2
                }
            }
        }

        Menu {
            title: qsTr("Mode")
            Action {
                text: qsTr("Quick Prediction")
                enabled: false
            }
            Action {
                text: qsTr("Optimisation")
//                onTriggered: mainStack.replace("optimisation_workspace.qml")
            }
            Action {
                text: qsTr("Sensitivity")
//                onTriggered: mainStack.replace("sensitivity_workspace.qml")
            }
        }

        Menu {
            title: qsTr("Exit")
        }
    }

    Rectangle {
        id: parametersContent
        x: 10
        y: 20
        width: 250
        color: "#ffffff"
        border.width: 1
        anchors.left: parent.left
        anchors.top: menubar.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        ListView {
            id: parameterList
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parametersLabel.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 20
            anchors.bottomMargin: 20
            //            height:250
            model: backend.get_pred_inputs()
            //                   ["Force (kN)","Velocity (mm/s)","Blank Thickness (mm)","Temperature (°C)"]

            delegate: Rectangle {
                implicitHeight: 50
                visible: true
                color: "#00ffffff"
                border.color: "#00ffffff"
                border.width: 0
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                anchors.topMargin: 10

                Text {
                    id: parameterName
                    y: 10
                    text: model.modelData
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pixelSize: 12
                    anchors.leftMargin: 0
                    anchors.topMargin: 5
                }

                Text {
                    id: parameterValue
                    anchors.right: parent.right
                    anchors.verticalCenter: parameterName.verticalCenter
                    anchors.leftMargin: 10
                    text: slider.value.toFixed(backend.get_pred_parameter_decimals(parameterName.text)) +" "+ backend.get_pred_parameter_units(parameterName.text)
                }

                Slider {
                    id: slider
                    x: 5
                    y: 30
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parameterName.bottom
                    anchors.rightMargin: 0
                    live: true
                    anchors.leftMargin: 0
                    anchors.topMargin: 5
                    from: backend.get_pred_parameter_lowerbound(parameterName.text)
                    to: backend.get_pred_parameter_upperbound(parameterName.text)
                    value: (from + (to-from)/2).toFixed(backend.get_pred_parameter_decimals(parameterName.text))
                    enabled: {from !== to}
                    onMoved: {
                        backend.send_pred_inputvalue(slider.value, parameterName.text)
                    }
                }
            }
        }

        Text {
            id: parametersLabel
            x: 0
            y: -35
            height: 25
            text: qsTr("Parameters")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.topMargin: 10
            anchors.leftMargin: 10
        }
    }

    Rectangle {
        id: resultsContent
        color: "#ffffff"
        border.width: 1
        anchors.left: parametersContent.right
        anchors.right: parent.right
        anchors.top: imageHolder.bottom
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Text {
            id: resultsLabel
            x: 10
            text: qsTr("Results")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.topMargin: 10
            anchors.leftMargin: 10
        }

        ListView {
            id: resultsList
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: resultsLabel.bottom
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            orientation: ListView.Horizontal

            model: backend.get_pred_metrics(modelType.checkedButton.text)

            delegate: Rectangle {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 10
                anchors.bottomMargin: 0
                implicitWidth: 80

                Text {
                    id: resultLabel
                    text: model.modelData
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pixelSize: 12
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                }

                Text {
                    id: resultValue
                    text: backend.get_pred_result(resultLabel.text)
                    anchors.verticalCenter: resultLabel.verticalCenter
                    anchors.left: resultLabel.left
                    font.pixelSize: 12
                    anchors.topMargin: 0
                    anchors.rightMargin: 0
                }
            }
        }


    }

    ButtonGroup {
        id: modelType
        exclusive: true
    }

    ListView {
        id: modelTypeBar
        height: 20
        anchors.left: parametersContent.right
        anchors.right: parent.right
        anchors.top: menubar.bottom
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: 10
        orientation: ListView.Horizontal

        model: backend.load_modeltypes()

        delegate: RadioButton {
            id: modelTypeButton
            text: model.modelData
            anchors.verticalCenter: parent.verticalCenter
            ButtonGroup.group: modelType
            checked: true
            onClicked: backend.changemodelType(text)
            Component.onCompleted: backend.changemodelType(text)
        }
    }

//    TabBar {
//        id: modelTypeBar
//        anchors.left: parametersContent.right
//        anchors.right: parent.right
//        anchors.top: menubar.bottom
//        anchors.rightMargin: 0
//        anchors.leftMargin: 0
//        anchors.topMargin: 0

//        ListView {
//            anchors.fill: parent
//            orientation: ListView.Horizontal
//            model: ["model1","model2"]

//            delegate: Button {
//                id: thinningButton
//                text: model.modelData
//                anchors.top: parent.top
//                anchors.bottom: parent.bottom
//                ButtonGroup.group : modelType
//                onClicked: backend.changemodelType(thinningButton.text)
//            }
//        }
//    }



//        TabButton {
//            id: springbackButton
//            text: qsTr("Springback")
//            anchors.left: thinningButton.right
//            anchors.top: parent.top
//            anchors.leftMargin: 0
//            ButtonGroup.group: modelType
//            onClicked: backend.changemodelType(text)
//            anchors.topMargin: 0
//        }

//        TabButton {
//            id: strainButton
//            text: qsTr("Strain")
//            anchors.left: springbackButton.right
//            anchors.top: parent.top
//            anchors.leftMargin: 0
//            ButtonGroup.group: modelType
//            onClicked: backend.changemodelType(text)
//            anchors.topMargin: 0
//        }

    Text {
        id: modelTypeLabel
        text: (modelTypeBar.currentItem === null) ? qsTr("No result type selected") : qsTr("Current result type: ") + modelType.checkedButton.text
        anchors.left: parametersContent.right
        anchors.right: parent.right
        anchors.top: modelTypeBar.bottom
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
    }


    Rectangle {
        id: imageHolder
        height: parent.height*4/5
        color: "#ffffff"
        anchors.left: parametersContent.right
        anchors.right: parent.right
        anchors.top: modelTypeLabel.bottom
        z: -1
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        //        View3D {
        //            anchors.fill: parent

        //        }

        ScrollView {
            id: resultImageScroll
            anchors.fill: parent
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOn
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            ScrollBar.horizontal.interactive: true
            ScrollBar.vertical.interactive: true

            Image {
                id: resultImage
                fillMode: Image.PreserveAspectFit
                cache: false
                source: "../temp/outputfield1.png"
                property bool counter: false
                anchors.left: parent.left
                anchors.right: parent.right
                scale: 1
                clip: true

                function reload () {
                    counter = !counter
                    if (counter) {
                        source = "../temp/outputfield1.png"
                    }
                    else {
                        source = "../temp/outputfield2.png"
                    }
                }
            }
        }

        Button {
            id: zoominButton
            text: qsTr("+")
            anchors.right: zoomoutButton.left
            anchors.top: parent.top
            anchors.rightMargin: 0
            anchors.topMargin: 10
            onClicked: resultImage.scale = resultImage.scale + 0.1
        }

        Button {
            id: zoomoutButton
            text: qsTr("-")
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.rightMargin: 10
            onClicked: resultImage.scale = resultImage.scale - 0.1
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
