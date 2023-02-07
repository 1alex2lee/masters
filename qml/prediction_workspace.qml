import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick3D

Item {
    id: predictionWorkspceItem
    width: 800
    height: 600

    Component.onCompleted: {
        window.width = width
        window.height = height
        window.x = Screen.width / 2 - width / 2
        window.y = Screen.height / 2 - height / 2
    }

    MenuBar {
        id: menubar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        Menu {
            title: qsTr("File")
        }

        Menu {
            title: qsTr("Mode")
            Action {
                text: qsTr("Quick Prediction")
                enabled: false
            }
            Action {
                text: qsTr("Optimisation")
                onTriggered: mainStack.replace("optimisation_workspace.qml")
            }
            Action {
                text: qsTr("Sensitivity")
                onTriggered: mainStack.replace("sensitivity_workspace.qml")
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
        width: 200
        height: parent.height/2
        color: "#00ffffff"
        border.width: 1
        anchors.left: parent.left
        anchors.top: menubar.bottom
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
            model: backend.get_pred_parameters(modelType.checkedButton.text)
            //                   ["Force (kN)","Velocity (mm/s)","Blank Thickness (mm)","Temperature (°C)"]

            delegate: Rectangle {
                implicitHeight: 75
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

                SpinBox {
                    id: spinbox
                    x: 150
                    y: 30
                    width: 80
                    value: slider.value
                    anchors.left: parent.left
                    anchors.top: parameterName.bottom
                    font.pixelSize: 12
                    anchors.leftMargin: 0
                    anchors.topMargin: 5
                    editable: true
                    onValueModified: {
                        if (slider.value !== value) {
                            slider.value = value
                            backend.updateParameters(slider.value, parameterName.text)
                        }
                    }
                }

                Text {
                    id: parameterUnits
                    anchors.left: spinbox.right
                    anchors.verticalCenter: spinbox.verticalCenter
                    anchors.leftMargin: 10
                    text: backend.get_pred_parameter_units(modelType.checkedButton.text, parameterName.text)
                }

                Slider {
                    id: slider
                    x: 5
                    y: 30
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: spinbox.bottom
                    anchors.rightMargin: 0
                    live: true
                    anchors.leftMargin: 0
                    anchors.topMargin: 5
                    value: 50
                    to: 100
                    onMoved: {
                        backend.updateParameters(slider.value, parameterName.text)
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
        anchors.left: parent.left
        anchors.right: imageHolder.left
        anchors.top: parametersContent.bottom
        anchors.bottom: parent.bottom

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

            model: backend.get_pred_metrics(modelType.checkedButton.text)

            delegate: Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                implicitHeight: 40

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
                    anchors.right: parent.right
                    anchors.top: resultLabel.bottom
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
//            onClicked: backend.changemodelType(text)
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
//                ButtonGroup.group: modelType
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
        color: "#ffffff"
        anchors.left: parametersContent.right
        anchors.right: parent.right
        anchors.top: modelTypeLabel.bottom
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0

        //        View3D {
        //            anchors.fill: parent

        //        }

        Image {
            id: resultImage
            width: 400
            height: 400
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            cache: false
            source: "../temp/outputfield1.png"
            property bool counter: false

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

    Connections {
        target: backend

        function onUpdate (manufacturbility) {
            manufacturbilityValue.text = (manufacturbility).toFixed(2) + qsTr(" %")
            resultImage.reload()
        }

    }

    Item {
        id: __materialLibrary__
    }







}
