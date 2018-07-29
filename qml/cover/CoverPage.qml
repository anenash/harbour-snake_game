import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    Column {
        anchors.centerIn: parent
        width: parent.width
        height: level.height + score.height + lines.height
    Label {
        id: level

        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        text: qsTr("Level: ") + app.coverLevel
    }
    Label {
        id: score

        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        text: qsTr("Score: ") + app.coverScore
    }
    Label {
        id: lines

        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        text: qsTr("Apples: ") + app.applesCount
    }
    }
}
