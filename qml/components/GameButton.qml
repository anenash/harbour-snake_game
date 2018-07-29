import QtQuick 2.6
import Sailfish.Silica 1.0

BackgroundItem {

    property alias title: label.text
    property alias buttonWidth: buttonBody.width
    property alias buttonColor: buttonBody.color

    signal event()

    highlightedColor: "transparent"

    Timer {
        id: eventTimer

        interval: 100
        repeat: true

        onTriggered: {
            event()
        }
    }

//    onPressed: {
//        event()
////        eventTimer.start()
//    }

//    onReleased: {
//        eventTimer.stop()
//    }

    Rectangle {
        id: buttonBody

        anchors.centerIn: parent
        width: Theme.buttonWidthSmall * 0.1
        height: width
        color: "yellow"
        radius: 180
    }
    Label {
        id: label

        anchors.top: buttonBody.bottom
        anchors.horizontalCenter: buttonBody.horizontalCenter
        font.pixelSize: Theme.fontSizeTiny
    }
}
