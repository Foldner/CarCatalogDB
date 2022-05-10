import QtQuick 6.0
import QtQuick.Controls 6.0
import QtQuick.Layouts 6.0

Rectangle {
    id: apItem
    readonly property color evenBackgroundColor: "#98FB98"
    readonly property color oddBackgroundColor: "#BDECB6"
    readonly property color selectedBackgroundColor: "#34C924"

    property bool isCurrent: apItem.ListView.view.currentIndex === index
    property bool selected: apItemMouseArea.containsMouse || isCurrent

    property variant carData: model

    width: parent ? parent.width : apList.width
    height: 160

    states: [
        State {
            when: selected
            PropertyChanges { target: apItem;
                color: isCurrent ? palette.highlight : selectedBackgroundColor
            }
        },
        State {
            when: !selected
            PropertyChanges { target: apItem;  color: isCurrent ? palette.highlight : index % 2 == 0 ? evenBackgroundColor : oddBackgroundColor }
        }
    ]

    MouseArea {
        id: apItemMouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            apItem.ListView.view.currentIndex = index
            apItem.forceActiveFocus()
        }
    }
    Item {
        id: itemOfCars
        width: parent.width
        height: 160
        Column{
            id: t2
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 240
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: t0
                anchors.horizontalCenter: parent.horizontalCenter
                text: "ID:"
                color: "Black"
                font.pointSize: 12
                 }
            Text {
                id: textid
                anchors.horizontalCenter: parent.horizontalCenter
                text: Id_car
                color: "Black"
                font.pointSize: 18
                font.bold: true
                 }
            Text {
                id: t1
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Марка:"
                color: "Black"
                font.pointSize: 12
            }
            Text {
                id: textBrand
                anchors.horizontalCenter: parent.horizontalCenter
                text: brandOfCar
                color: "Black"
                font.pointSize: 18
                font.bold: true
            }
        }
        Column{
            anchors.left: t2.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            Text {
                text: "Модель:"
                color: "Black"
                font.pointSize: 10
            }
            Text {
                id: textModel
                text: modelOfCar
                color: "Black"
                font.pointSize: 12
                font.bold: true
            }
            Text {
                text: "Макс. мощность:"
                color: "Black"
                font.pointSize: 10
            }
            Text {
                id: textHorsepower
                color: "Black"
                text: horsepowerOfCar
                font.pointSize: 12
                font.bold: true
            }
            Text {
                text: "Макс. крутящий момент:"
                color: "Black"
                font.pointSize: 10
            }
            Text {
                id: textMaxTorque
                text: maxTorqueOfCar
                color: "Black"
                font.pointSize: 12
                font.bold: true
            }
            Text {
                text: "Время разгона от 0 до 100:"
                color: "Black"
                font.pointSize: 10
            }
            Text {
                id: textAccelerationTime
                color: "Black"
                text: accelerationTimeOfCar
                font.pointSize: 12
                font.bold: true
            }
        }

    }
}
