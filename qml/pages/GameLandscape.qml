import QtQuick 2.6
import Sailfish.Silica 1.0

import "../components"

Item {
    id: root

    Rectangle {
        anchors.fill: parent
        color: "#36aa45"

        Label {
            anchors.right: parent.right
            anchors.rightMargin: Theme.horizontalPageMargin
            anchors.bottom: parent.bottom
            anchors.bottomMargin: Theme.horizontalPageMargin
            rotation: -45
            text: "E21"
            font.bold: true
            font.pointSize: Theme.fontSizeExtraLarge
        }
    }

    Item {
        id: game

        anchors.horizontalCenter: root.horizontalCenter
        anchors.top: root.top
        anchors.topMargin: Theme.paddingMedium

        width: gameField.width + gameInfo.width
        height: gameField.height

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
                model: snakeGame.gameBoard

                delegate: Image {
                    width: 21 * Theme.pixelRatio
                    height: width
                    source: "cell.png"
                    opacity: active?1.0:0.3
                }
            }
        }

        GameInfo {
            id: gameInfo

            anchors.top: gameField.top
            anchors.left: gameField.right
            height: gameField.height

            gameHightScore: hightScore
        }
    }

    Loader {
        anchors.top: root.top
        anchors.left: root.left
        anchors.right: root.right
        anchors.bottom: root.bottom
        source: "../components/GameControls.qml"
    }

    Row {
        id: gameButtonsRow

        anchors.top: root.top
        anchors.right: root.right
        anchors.rightMargin: Theme.horizontalPageMargin

        spacing: Theme.paddingLarge

        GameButton {
            width: Theme.buttonWidthSmall * 0.2
            title: "Start/\nPause"

            onClicked: {
                if (settingsEnabled) {
                    return
                }

                if (!snakeGame.started) {
                    snakeGame.start()
                } else {
                    if (snakeGame.paused) {
                        snakeGame.pause(false)
                    } else {
                        snakeGame.pause(true)
                    }
                }
            }
        }
        GameButton {
            width: Theme.buttonWidthSmall * 0.2
            title: "Reset"

            onClicked: {
                snakeGame.reset()
            }
        }
        GameButton {
            width: Theme.buttonWidthSmall * 0.2
            title: "Mute"

            onClicked: {
                snakeGame.mute()
            }
        }
    }

    /*
    GameButton {
        id: up

        anchors.top: root.horizontalCenter
        anchors.topMargin: Theme.horizontalPageMargin
        anchors.left: left.right

        width: Theme.buttonWidthSmall * 0.3
        buttonWidth: Theme.buttonWidthSmall * 0.23
        buttonColor: "yellow"
        title: "Up"

        onEvent: {
            ttrs.rotateRight()
        }
    }
    GameButton {
        id: left

        anchors.top: up.bottom
        anchors.left: root.left
        anchors.leftMargin: Theme.horizontalPageMargin
        width: Theme.buttonWidthSmall * 0.3
        buttonWidth: Theme.buttonWidthSmall * 0.23
        buttonColor: "yellow"
        title: "Left"

        onEvent: {
            ttrs.moveLeft()
        }
    }
    GameButton {
        id: right


        anchors.top: up.bottom
        anchors.left: up.right
        width: Theme.buttonWidthSmall * 0.3
        buttonWidth: Theme.buttonWidthSmall * 0.23
        buttonColor: "yellow"
        title: "Right"

        onEvent: {
            ttrs.moveRight()
        }
    }
    GameButton {
        id: down

        anchors.top: left.bottom
        anchors.left: left.right
        width: Theme.buttonWidthSmall * 0.3
        buttonWidth: Theme.buttonWidthSmall * 0.23
        buttonColor: "yellow"
        title: "Down"

        onEvent: {
            ttrs.moveDown()
        }
    }

    GameButton {
        id: rotate

        anchors.top: right.bottom
        anchors.right: parent.right
        anchors.rightMargin: Theme.horizontalPageMargin

        width: Theme.buttonWidthSmall * 0.5
        buttonWidth: Theme.buttonWidthSmall * 0.4
        buttonColor: "yellow"
        title: "Rotate"

        onEvent: {
            ttrs.rotateLeft()
        }
    }
    */

}
