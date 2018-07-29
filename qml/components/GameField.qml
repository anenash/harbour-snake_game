import QtQuick 2.6
import Sailfish.Silica 1.0


Rectangle {
    id: gameField

    anchors.left: parent.left
    anchors.top: parent.top

    border.width: 1

    width: 220 * Theme.pixelRatio
    height: 440 * Theme.pixelRatio

    color: "#a5ddb5"
    GridView {
        anchors.fill: parent
        cellHeight: 22 * Theme.pixelRatio
        cellWidth: cellHeight
        enabled: false
        model: snakeGame.gameBoard

        delegate: Image {
            width: 21 * Theme.pixelRatio
            height: width
            source: "../pages/cell.png"
            opacity: active?1.0:0.3
        }
    }
}
