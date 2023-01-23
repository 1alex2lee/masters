import QtQuick
import QtQuick.Window
import QtQuick.Controls
import Qt.labs.qmlmodels

Item {
    id: item1
    //    id: window
    //    width: 800
    //    height: 600
    //    color: "#eeeeee"
    //    visible: true
    //    title: qsTr("Hello World")

    Rectangle {
        id: topBar
        height: 20
        color: "#ffffff"
        border.color: "#000000"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Text {
            id: appName
            text: qsTr("Deep Learning based User-Centric Software to Assist Design for Forming")
            anchors.left: icon.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            font.pixelSize: 12
            verticalAlignment: Text.AlignVCenter
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
        }

        Button {
            id: closeButton
            width: 20
            height: 20
            anchors.right: parent.right
            anchors.top: parent.top
            rightPadding: 0
            bottomPadding: 0
            leftPadding: 0
            topPadding: 0
            display: AbstractButton.IconOnly
            anchors.topMargin: 0
            anchors.rightMargin: 0

            Image {
                id: closeButtonImage
                anchors.fill: parent
                source: "assets/closeButton.svg"
                anchors.rightMargin: 3
                anchors.leftMargin: 3
                anchors.bottomMargin: 3
                anchors.topMargin: 3
                fillMode: Image.PreserveAspectFit
            }
        }

        Button {
            id: minimiseButton
            width: 20
            height: 20
            text: qsTr("Button")
            anchors.right: closeButton.left
            anchors.top: parent.top
            anchors.rightMargin: 0
            anchors.topMargin: 0

            Image {
                id: minimiseButtonImage
                anchors.fill: parent
                source: "assets/minimiseButton.svg"
                anchors.rightMargin: 3
                anchors.leftMargin: 3
                anchors.bottomMargin: 3
                anchors.topMargin: 3
                fillMode: Image.PreserveAspectFit
            }
        }

        Button {
            id: fullscreenButton
            width: 20
            height: 20
            text: qsTr("Button")
            anchors.right: minimiseButton.left
            anchors.top: parent.top
            icon.source: "/Users/alexlee/OneDrive - Imperial College London/Year 4/Masters/Qt/PyQt4/assets/fullscreenButton.svg"
            anchors.rightMargin: 0
            anchors.topMargin: 0

            Image {
                id: fullscreenButtonImage
                anchors.fill: parent
                source: "assets/fullscreenButton.svg"
                anchors.rightMargin: 3
                anchors.leftMargin: 3
                anchors.bottomMargin: 3
                anchors.topMargin: 3
                fillMode: Image.PreserveAspectFit
            }
        }

        Image {
            id: icon
            width: 25
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            source: "qrc:/qtquickplugin/images/template_image.png"
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            fillMode: Image.PreserveAspectFit
        }
    }

    Rectangle {
        id: fileBar
        height: 20
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: topBar.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0


        Button {
            id: fileButton
            width: 50
            text: qsTr("Button")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0

            Text {
                id: fileButtonLabel
                text: qsTr("File")
                anchors.fill: parent
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Button {
            id: modeButton
            width: 50
            text: qsTr("Button")
            anchors.left: fileButton.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            onClicked: (modeMenu.visible == false) ? modeMenu.visible = true : modeMenu.visible = false

            Text {
                id: modeButtonLabel
                text: qsTr("Mode")
                anchors.fill: parent
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Button {
            id: exitButton
            width: 50
            text: qsTr("Button")
            anchors.left: modeButton.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0

            Text {
                id: exitButtonLabel
                text: qsTr("Exit")
                anchors.fill: parent
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

    }

    Rectangle {
        id: modeMenu
        x: 0
        width: 110
        height: 150
        color: "#ffffff"
        border.width: 1
        anchors.left: fileBar.left
        anchors.top: fileBar.bottom
        focus: true
        z: 1
        anchors.leftMargin: fileButton.width
        anchors.topMargin: 0
        visible: true

        Text {
            id: modeLabel
            text: qsTr("Mode")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            font.bold: true
            anchors.leftMargin: 5
            anchors.topMargin: 0
        }

        Button {
            id: predictionModeButton
            text: qsTr("Button")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: modeLabel.bottom
            icon.color: "#ffffff"
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            onClicked: mainStack.replace("prediction_workspace.qml")
            Text {
                id: predictionModeLabel
                text: qsTr("Quick Prediction")
                anchors.fill: parent
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 5
            }
        }

        Button {
            id: optimisationModeButton
            text: qsTr("Button")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: predictionModeButton.bottom
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            Text {
                id: optimisationModeLabel
                text: qsTr("Optimisation")
                anchors.fill: parent
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 5
            }
            anchors.topMargin: 0
        }

        Button {
            id: sensitivityModeButton
            text: qsTr("Button")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: optimisationModeButton.bottom
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            onClicked: mainStack.replace("sensitivity_workspace.qml")
            Text {
                id: sensitivityModeLabel
                text: qsTr("Sensitivity")
                anchors.fill: parent
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 5
            }
            anchors.topMargin: 0
        }

        Button {
            id: developerModeButton
            text: qsTr("Button")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: sensitivityModeButton.bottom
            anchors.leftMargin: 0
            onClicked: mainStack.replace("developer_workspace.qml")
            Text {
                id: developerModeLabel
                text: qsTr("Developer")
                anchors.fill: parent
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 5
            }
            anchors.topMargin: 0
            anchors.rightMargin: 0
        }
    }

    ScrollView {
        id: scrollView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: fileBar.bottom
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0

        Rectangle {
            id: bestrunContainer
            height: 100
            color: "#ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0

            Text {
                id: bestrunLabel
                text: qsTr("Best Run")
                anchors.left: parent.left
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.leftMargin: 5
                anchors.topMargin: 5
            }

            Button {
                id: viewallrunsButton
                width: 80
                text: qsTr("Button")
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 5
                anchors.topMargin: 5
                onClicked: backend.updateBestruntable()

                Text {
                    id: viewallrunsLabel
                    text: qsTr("View All Runs")
                    anchors.fill: parent
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            TableView{
                id: bestrunTable
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: bestrunLabel.bottom
                anchors.bottom: parent.bottom
                anchors.rightMargin: 5
                anchors.leftMargin: 5
                anchors.topMargin: 5
                anchors.bottomMargin: 5
                columnSpacing: 1
                rowSpacing: 1
                boundsBehavior: Flickable.StopAtBounds

//                model: TableModel {
//                    TableModelColumn { display: "run_no" }
//                    TableModelColumn { display: "force" }
//                    TableModelColumn { display: "velocity" }
//                    TableModelColumn { display: "manufacturibility" }

//                    rows: [
//                        {
//                            run_no: "Run #",
//                            force: "Force",
//                            velocity: "Velocity",
//                            manufacturibility: "Manufacturibility"
//                        },
//                        {
//                            run_no: 12,
//                            force: 45,
//                            velocity: 1.50,
//                            manufacturibility: 89
//                        }
//                    ]
//                }
//                delegate:  Text {
//                            text: model.display
//                            padding: 12

//                            Rectangle {
//                                anchors.fill: parent
//                                color: "#efefef"
//                                z: -1
//                            }
//                        }

            }

            Text {
                id: tablemodelpreview
                x: 0
                y: 440
                text: qsTr("Text")
                anchors.left: parent.left
                anchors.top: bestrunLabel.bottom
                anchors.bottom: parent.bottom
                font.pixelSize: 12
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
            }
        }
    }

    Connections {
        target: backend

        function onBestruntable (tablemodel) {
            console.log(tablemodel)
//            tablemodelpreview.text = qsTr(tablemodel)
//            bestrunTable.model.setData(12,45,1.50,89)
//            console.log(bestrunTable.model.data())
//            bestrunTable.model = tablemodel
//            bestrunTable.model.dataChanged()
//            var ix = bestrunTable.model.index(0, 0);
//                if (bestrunTable.model.setData(ix, "display", "cat2"))
//                    console.log("success");
//                else
//                    console.log("failed");
        }
    }
}
