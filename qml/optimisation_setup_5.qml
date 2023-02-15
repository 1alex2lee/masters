import QtQuick
import QtQuick.Dialogs
import QtQuick.Window
import QtQuick.Controls
import QtCharts

Item {
    id: item1
    width: 500
    height: 500
    Component.onCompleted: {
        window.x = window.x + window.width/2 - width/2
        window.y = window.y + window.height/2 - height/2
        window.width = width
        window.height = height
    }

//Window {
//    id: window
//    width: 500; height: 500
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
            text: "Optimisation Mode"
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

    Text {
        id: progressLabel
        text: "Currently on run 0/0"
        anchors.left: parent.left
        anchors.top: titleBar.bottom
        anchors.leftMargin: 10
        anchors.topMargin: 10

    }

    ProgressBar {
        id: progressBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: progressLabel.bottom
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 10
        value: 0
    }

    Rectangle {
        id: chartContent
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: progressBar.bottom
        anchors.bottom: bottomNavBar.top
        anchors.bottomMargin: 0
        anchors.topMargin: 0

        ChartView {
            anchors.fill: parent
            title: "Goal Value over Runs"
            antialiasing: true

            LineSeries {
                id: progressLine
                axisX: ValueAxis {
                    id: x_axis
                    tickInterval: 1
                    tickType: ValueAxis.TicksDynamic
                }
                axisY: ValueAxis { id: y_axis }
            }
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
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            visible: false
            anchors.rightMargin: 10
            text: qsTr("Show Results")
            onClicked: {
                mainStack.replace("optimisation_workspace.qml")
//                window.close()
//                var component = Qt.createComponent("optimisation_workspace.qml")
//                var new_window = component.createObject(window)
//                new_window.show()
//                new_window.x = window.x + window.width/2 - new_window.width/2
//                new_window.y = window.y + window.height/2 - new_window.height/2
            }
        }

        Button {
            id: earlystopButton
            x: 398
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            visible: true
            anchors.rightMargin: 10
            text: qsTr("Stop Early")
            onClicked: {
                backend.stop_optimisation()
                earlystopButton.visible = false
                nextButton.visible = true
            }
        }

        Button {
            id: backButton
            x: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            text: qsTr("Cancel")
            onClicked: {
                backend.stop_optimisation()
                mainStack.replace("optimisation_setup_3.qml")
//                window.close()
//                var component = Qt.createComponent("optimisation_setup_3.qml")
//                var new_window = component.createObject(window)
//                new_window.show()
//                new_window.x = window.x + window.width/2 - new_window.width/2
//                new_window.y = window.y + window.height/2 - new_window.height/2
            }
        }
    }

    Connections {
        target: backend
        function onOpti_result_updated (x, runsno, y) {

            if (x/runsno <= 1) {
                progressBar.value = x/runsno

                progressLine.append(x-1, y)
                x_axis.max = x
                if (y > y_axis.max*1.1) {
                    y_axis.max = y*1.1
                }
            } else {
                earlystopButton.visible = false
                nextButton.visible = true
                backButton.visible = false
                progressLabel.text = "Done!"
            }
        }
    }
}


