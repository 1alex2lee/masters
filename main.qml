import QtQuick
import QtQuick.Window
import QtQuick.Controls


Window {
    id: window
    width: 800
    height: 600
    color: "#eeeeee"
    visible: true
    title: qsTr("User-Centirc Software to Assist Design for Forming")
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2

    StackView {
        id: mainStack
//            initialItem: "qml/start_screen.qml"
//            initialItem: "qml/prediction_setup_3.qml"
        initialItem: "qml/prediction_workspace_3d.qml"
//            anchors.fill: parent
    }

    Component.onCompleted: {
        console.log(GraphicsInfo.api)
    }
}


//Window {
//    id: window
//    width: 0
//    height: 0
//    color: "#eeeeee"
//    visible: false
//    title: qsTr("User-Centirc Software to Assist Design for Forming")

//    Component.onCompleted: {
////        var component = Qt.createComponent("qml/start_screen.qml")
////        var component = Qt.createComponent("qml/prediction_setup_1.qml")
//        var component = Qt.createComponent("qml/prediction_workspace.qml")
//        var new_window = component.createObject(window)
//        new_window.show()
//    }
//}
