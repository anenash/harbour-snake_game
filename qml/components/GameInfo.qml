import QtQuick 2.6
import Sailfish.Silica 1.0

Rectangle {

    property string gameHightScore

    FontLoader {
        id: lcdFont

        source: "../pages/ds-digital-bold.ttf"
    }

    border.width: 1

    width: 110 * Theme.pixelRatio

    color: "#a5ddb5"
    Column {
        anchors.fill: parent
        anchors.margins: Theme.paddingSmall
        Text {
            text: "Hi-Score"            
            font.family: lcdFont.name
            font.pixelSize: Theme.fontSizeTiny
        }
        Text {
            text: gameHightScore
            font.family: lcdFont.name
            font.pixelSize: Theme.fontSizeTiny
        }
        Text {
            text: "Score"
            font.family: lcdFont.name
            font.pixelSize: Theme.fontSizeTiny
        }
        Text {
            text: snakeGame.score
            font.family: lcdFont.name
            font.pixelSize: Theme.fontSizeTiny
        }
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 88 * Theme.pixelRatio
            height: 88 * Theme.pixelRatio
            color: "#a5ddb5"
            GridView {
                anchors.fill: parent
                cellHeight: 22 * Theme.pixelRatio
                cellWidth: 22 * Theme.pixelRatio
                enabled: false
                model: 16

                delegate: Image {
                    width: 21 * Theme.pixelRatio
                    height: 21 * Theme.pixelRatio
                    source: "../pages/cell.png"
                    opacity: 0.3
                }
            }
        }
        Text {
            text: "Level"
            font.family: lcdFont.name
            font.pixelSize: Theme.fontSizeTiny
        }
        Text {
            text: snakeGame.level
            font.family: lcdFont.name
            font.pixelSize: Theme.fontSizeTiny
        }
        Text {
            text: "Pause"
            font.family: lcdFont.name
            font.pixelSize: Theme.fontSizeTiny
            opacity: snakeGame.started ? snakeGame.paused ? 1.0 : 0.3 : 0.3
        }
        Text {
            text: "Mute"
            font.family: lcdFont.name
            font.pixelSize: Theme.fontSizeTiny
            opacity: snakeGame.muted ? 1.0 : 0.3
        }
        Text {
            text: "Game over"
            font.family: lcdFont.name
            font.pixelSize: Theme.fontSizeTiny
            opacity: gameOver ? 1.0 : 0.3
        }
    }
}
