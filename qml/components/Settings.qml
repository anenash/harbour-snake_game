import QtQuick 2.6
import Sailfish.Silica 1.0

Rectangle {
    id: settingsView

    anchors.left: parent.left
    anchors.top: parent.top

    border.width: 1

    width: 220 * Theme.pixelRatio
    height: 440 * Theme.pixelRatio

    color: "#a5ddb5"

    ListModel {
        id: settingsModel

        ListElement {
            title: "Rotation"
            action: ""
        }
        ListElement {
            title: "Next level"
            action: ""
        }
        ListElement {
            title: "Reset Hi-score"
            action: ""
        }
        ListElement {
            title: "Say 'Thank you'"
            action: ""
        }
    }

    FontLoader {
        id: lcdFont

        source: "../pages/ds-digital-bold.ttf"
    }

    ListView {
        anchors.fill: parent
        clip: true
        enabled: false
        model: settingsModel

        delegate: Item {
            width: parent.width
            height: Theme.itemSizeSmall
            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: Theme.paddingSmall
                width: parent.width
                text: title
                font.family: lcdFont.name
                height: Theme.itemSizeSmall
            }
            Text {
                anchors.bottom: parent.bottom
                anchors.leftMargin: Theme.paddingSmall
                width: parent.width
                text: title
                font.family: lcdFont.name
                height: Theme.itemSizeSmall
                horizontalAlignment: Text.AlignRight
            }
        }
    }
}
