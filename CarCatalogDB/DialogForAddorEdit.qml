import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.2


Window {
    id: root
    modality: Qt.ApplicationModal
    title: qsTr("Добавление информации о машине")
    minimumWidth: 400
    maximumWidth: 400
    minimumHeight: 200
    maximumHeight: 200

    property bool isEdit: false
    property int currentIndex: -1

    GridLayout {
        anchors { left: parent.left; top: parent.top; right: parent.right; bottom: buttonCancel.top; margins: 10 }
        columns: 2

        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Марка:")
        }
        TextField {
            id: textBrand
            Layout.fillWidth: true
            placeholderText: qsTr("Введите марку")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Модель:")
        }
        TextField {
            id: textModel
            Layout.fillWidth: true
            placeholderText: qsTr("Введите модель")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Макс. мощность:")
        }
        TextField {
            id: textHorsepower
            Layout.fillWidth: true
            placeholderText: qsTr("Введите макс. мощность")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Макс. крутящий момент:")
        }
        TextField {
            id: textMaxTorque
            Layout.fillWidth: true
            placeholderText: qsTr("Введите макс. крутящий момент")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Время разгона от 0 до 100:")
        }
        TextField {
            id: textAccelerationTime
            Layout.fillWidth: true
            placeholderText: qsTr("Введите время разгона от 0 до 100")
        }
    }

    Button {
        anchors { right: buttonCancel.left; verticalCenter: buttonCancel.verticalCenter; rightMargin: 10 }
        text: qsTr("ОК")
        width: 100
        onClicked: {
            root.hide()
            if (currentIndex<0)
            {
                add(textBrand.text, textModel.text, textHorsepower.text, textMaxTorque.text, textAccelerationTime.text)
            }
            else
            {
                edit(textBrand.text, textModel.text, textHorsepower.text, textMaxTorque.text, textAccelerationTime.text, root.currentIndex)
            }

        }
    }

    Button {
        id: buttonCancel
        anchors { right: parent.right; bottom: parent.bottom; rightMargin: 10; bottomMargin: 10 }
        text: qsTr("Отменить")
        width: 100
        onClicked: {
             root.hide()
        }
    }

    onVisibleChanged: {
      if (visible && currentIndex < 0) {
          textBrand.text = ""
          textModel.text = ""
          textHorsepower.text = ""
          textMaxTorque.text = ""
          textAccelerationTime.text = ""
      }
    }

    function execute(brand, model, horsepower, maxTorque, accelerationTime, index){
            textBrand.text = brand
            textModel.text = model
            textHorsepower.text = horsepower
            textMaxTorque.text = maxTorque
            textAccelerationTime.text = accelerationTime
            root.currentIndex = index

            root.show()
        }
 }
