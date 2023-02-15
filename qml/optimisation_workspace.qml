import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtCharts

Item {
    id: optimisationWorkspceItem
    width: 500
    height: 600

    Component.onCompleted: {
        window.x = window.x + window.width/2 - width/2
        window.y = window.y + window.height/2 - height/2
        window.width = width
        window.height = height
    }

//Window {
//    id: window
//    width: 500; height: 600
//    title: "User-Centirc Software to Assist Design for Forming"
//    visible: true

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
                onTriggered: {
                    mainStack.replace("prediction_workspace.qml")
//                    window.close()
//                    var component = Qt.createComponent("prediction_workspace.qml")
//                    var new_window = component.createObject(window)
//                    new_window.show()
//                    new_window.x = window.x + window.width/2 - new_window.width/2
//                    new_window.y = window.y + window.height/2 - new_window.height/2
                }

            }
            Action {
                text: qsTr("Optimisation")
                enabled: false
            }
            Action {
                text: qsTr("Sensitivity")
                onTriggered: {
                    mainStack.replace("sensitivity_workspace.qml")
//                    window.close()
//                    var component = Qt.createComponent("sensitivity_workspace.qml")
//                    var new_window = component.createObject(window)
//                    new_window.show()
//                    new_window.x = window.x + window.width/2 - new_window.width/2
//                    new_window.y = window.y + window.height/2 - new_window.height/2
                }

            }
        }

        Menu {
            title: qsTr("Exit")
        }
    }

    Rectangle {
        id: bestrunContent
        height: 100
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
//            Component.onCompleted: {
//                var component = Qt.createComponent("optimisation_workspace_allruns.qml")
//                var new_window = component.createObject(window)
//                new_window.show()
//            }

            onClicked: {
                var component = Qt.createComponent("optimisation_workspace_allruns.qml")
                var new_window = component.createObject(window)
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
//        function onOpti_result_updated (idx, x, y) {
//            progressLine.insert(idx, x, y)
//        }
    }

    Rectangle {
        id: chartContent
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: bestrunContent.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 0

        ChartView {
            anchors.fill: parent
            title: "Goal Value over Runs"
            antialiasing: true

            LineSeries {
                id: goaloverrunsline
                axisX: ValueAxis {
                    id: x_axis
                    tickInterval: 2
                    tickType: ValueAxis.TicksDynamic
                }
                axisY: ValueAxis { id: y_axis }
            }

            Component.onCompleted: {
                var goaloverruns = backend.get_opti_final_graph()
//                console.log(goaloverruns)
                for (var run in goaloverruns) {
                    console.log(goaloverruns[run][1])
                    goaloverrunsline.append(goaloverruns[run][0],goaloverruns[run][1])

                    x_axis.max = goaloverruns[run][0]

                    if (goaloverruns[run][1] > y_axis.max) {
                        y_axis.max = goaloverruns[run][1]*1.1
                    }
                }
            }
        }
    }

//    Timer {
//        interval: 1000; running: true; repeat: true
//        onTriggered: {
//            backend.update_opti_graph()
//        }
//    }

}
