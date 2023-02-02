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

    StackView {
            id: mainStack
            initialItem: "qml/optimisation_setup_3.qml"
//            anchors.fill: parent
        }
}
