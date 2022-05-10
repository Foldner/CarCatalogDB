import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.2


Window {
    visible: true
    width: 800
    height: 550
    title: qsTr("Каталог машин")

    SystemPalette {
          id: palette;
          colorGroup: SystemPalette.Active
       }

    Rectangle{
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: btnAdd.top
        anchors.bottomMargin: 8
        border.color: "gray"
    ScrollView {
        anchors.fill: parent
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        Text {
            anchors.fill: parent
            text: "Could not connect to SQL"
            color: "red"
            font.pointSize: 20
            font.bold: true
            visible: IsConnectionOpen === false
        }
        ListView {
            id: carList
            anchors.fill: parent
            model: carModel
            delegate: DelegateForCar{}
            clip: true
            activeFocusOnTab: true
            focus: true
        }
    }
   }

    Button {
        id: btnAdd
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.rightMargin: 8
        anchors.right:btnEdit.left
        text: "Добавить"
        width: 100

        onClicked: {
            windowAddEdit.currentIndex = -1
            windowAddEdit.show()
        }
    }

    Button {
        id: btnEdit
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right: btnDel.left
        anchors.rightMargin: 8
        text: "Редактировать"
        width: 100
        onClicked: {
            var brandCar = carList.currentItem.carData.brandOfCar
            var modelCar = carList.currentItem.carData.modelOfCar
            var horsepowerCar = carList.currentItem.carData.horsepowerOfCar
            var maxTorqueCar = carList.currentItem.carData.maxTorqueOfCar
            var accelerationTimeCar = carList.currentItem.carData.accelerationTimeOfCar
            var rID = carList.currentItem.carData.Id_car

            windowAddEdit.execute(brandCar, modelCar, horsepowerCar, maxTorqueCar, accelerationTimeCar, rID)
        }
    }

    Button {
        id: btnDel
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right:parent.right
        anchors.rightMargin: 8
        text: "Удалить"
        width: 100
        enabled: {
            if (carList.currentItem==null || carList.currentItem.carData == null)
            {false}
            else
            {carList.currentItem.carData.Id_car >= 0} }
        onClicked: del(carList.currentItem.carData.Id_car)
    }

    DialogForAddorEdit {
        id: windowAddEdit
    }
}
