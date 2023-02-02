import QtQuick
import QtQuick.Window
import QtQuick.Controls

Item {
    id: optimisationWorkspceItem
    width: 500
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

        Menu {
            title: qsTr("File")
        }

        Menu {
            title: qsTr("Mode")
            Action {
                text: qsTr("Quick Prediction")
                onTriggered: mainStack.replace("prediction_workspace.qml")
            }
            Action {
                text: qsTr("Optimisation")
                enabled: false
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
        id: bestrunContent
        height: 200
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: menubar.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        clip: false

        Text {
            id: bestrunTitle
            text: qsTr("Best Run")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }

        Button {
            id: viewallrunsButton
            text: qsTr("View all runs")
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 10
            anchors.topMargin: 5
            Component.onCompleted: {
                var component = Qt.createComponent("optimisation_workspace_allruns.qml")
                var new_window    = component.createObject(window)
                new_window.show()
            }

            onClicked: {
                var component = Qt.createComponent("optimisation_workspace_allruns.qml")
                var new_window    = component.createObject(window)
                new_window.show()
            }
        }

        ListView {
            id: bestrunList
            orientation: ListView.Horizontal
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: bestrunTitle.bottom
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            model: backend.get_final_bestrun
            delegate: Rectangle {
                implicitWidth: 80
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                Text {
                    id: varname
                    text: model.modelData[0]
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pixelSize: 12
                }

                Text {
                    id: varvalue
                    text: model.modelData[1].toFixed(2)
                    anchors.left: parent.left
                    anchors.top: varname.bottom
                    font.pixelSize: 12
                }
            }
        }
    }

    Connections {
        target: backend

    }

}
