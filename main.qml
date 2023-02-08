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
            initialItem: "qml/developer_setup_1.qml"
//            anchors.fill: parent
        }
}
