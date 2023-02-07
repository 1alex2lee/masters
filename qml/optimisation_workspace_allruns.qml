import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    id: allrunswindow
    width: bestrunsTable.contentWidth+20; height: 500
    title: "User-Centirc Software to Assist Design for Forming"
    visible: true

    MenuBar {
        id: menubar
        anchors.left: parent.left
        anchors.right: parent.right

        Menu {
            title: "File"
        }

        Menu {
            title: "Exit"
            Action {
                text: "Exit"
                onTriggered: allrunswindow.close()
            }
        }
    }

    Text {
        id: title
        text: qsTr("All runs")
        anchors.left: parent.left
        anchors.top: menubar.bottom
        anchors.leftMargin: 10
        anchors.topMargin: 10
    }

    ListView {
        id: header
        height: 30
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: title.bottom
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 10
        orientation: ListView.Horizontal
        model: backend.get_final_vars

        delegate: Button {
            text: model.modelData
            onClicked: {
//                console.log(bestrunsTable.model.rowCount())
                console.log(bestrunsTable.model.sort(text, AscendingOrder))
            }
        }
    }

    TableView {
        id: bestrunsTable
        anchors.top: header.bottom
        anchors.bottom:parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        model: bestruntable_model
        columnSpacing: 1
        rowSpacing: 1
        clip: true
//        pointerNavigationEnabled : true
//            setSortingEnabled: true
//            alternatingRows: True
//            selectionBehavior: TableView.SelectRows
//        onActivated: {console.log(bestrunsTable.columnCount)}
        Component.onCompleted: (
            console.log(bestrunsTable.columnCount))
        delegate: Rectangle {
            implicitHeight: 30
            implicitWidth: 100
            Text {
                text: display
            }
        }
    }

//    ScrollView {
//        id: scrollView
//        anchors.left: parent.left
//        anchors.right: parent.right
//        anchors.top: header.bottom
//        anchors.bottom: parent.bottom
//        anchors.topMargin: 10
//        anchors.rightMargin: 10
//        anchors.leftMargin: 10
//        anchors.bottomMargin: 10

//        TableView {
//            id: bestrunsTable
//            anchors.fill: parent
//            model: bestruntable_model
//            pointerNavigationEnabled : true
////            setSortingEnabled: true
////            alternatingRows: True
////            selectionBehavior: TableView.SelectRows
//            Component.onCompleted: (
//                console.log(bestrunsTable.columnCount))
//            delegate: Rectangle {
//                implicitHeight: 30
//                implicitWidth: 100
//                Text {
//                    text: display
//                }
//            }
//        }
//    }

    Connections {
        target: backend
    }

}
