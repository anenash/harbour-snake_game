import QtQuick 2.6
import Sailfish.Silica 1.0

import snake.Game 1.0

Item {
    id: root

    Timer {
        id: repeatTimer

        interval: 100
        repeat: true
        onTriggered: {
            if (snakeGame.started) {
                snakeGame.moveForward()
            }
        }
    }

    GameButton {
        id: buttonUp

        anchors.bottom: buttonLeft.top
        anchors.bottomMargin: Theme.horizontalPageMargin
        anchors.left: buttonLeft.right
        anchors.leftMargin: Theme.horizontalPageMargin
        width: Theme.buttonWidthSmall * 0.3
        height: width
        buttonWidth: Theme.buttonWidthSmall * 0.29
        title: "Up"

        onPressed: {
            snakeGame.moveSnake(Game.Up)
        }
    }
    GameButton {
        id: buttonLeft

        anchors.left: parent.left
        anchors.leftMargin: Theme.horizontalPageMargin
        anchors.verticalCenter: parent.verticalCenter
        width: Theme.buttonWidthSmall * 0.3
        height: width
        buttonWidth: Theme.buttonWidthSmall * 0.29
        title: "Left"

        onPressed: {
            snakeGame.moveSnake(Game.Left)
        }
    }
    GameButton {
        id: buttonRight

        anchors.top: buttonLeft.top
        anchors.left: buttonUp.right
        anchors.leftMargin: Theme.horizontalPageMargin
        width: Theme.buttonWidthSmall * 0.3
        height: width
        buttonWidth: Theme.buttonWidthSmall * 0.29
        title: "Right"

        onPressed: {
            snakeGame.moveSnake(Game.Right)
        }
    }
    GameButton {
        id: buttonDown

        anchors.left: buttonUp.left
        anchors.top: buttonLeft.bottom
        anchors.topMargin: Theme.horizontalPageMargin
        width: Theme.buttonWidthSmall * 0.3
        height: width
        buttonWidth: Theme.buttonWidthSmall * 0.29
        title: "Down"

        onPressed: {
            snakeGame.moveSnake(Game.Down)
        }
    }

    GameButton {
//        id: buttonRotate

        anchors.right: root.right
        anchors.rightMargin: Theme.horizontalPageMargin
        anchors.verticalCenter: root.verticalCenter
        width: Theme.buttonWidthSmall * 0.5
        height: width
        buttonWidth: Theme.buttonWidthSmall * 0.45
        title: "Rotate"

        onPressed: {
            repeatTimer.start()
        }

        onReleased: {
            repeatTimer.stop()
        }
    }
}
