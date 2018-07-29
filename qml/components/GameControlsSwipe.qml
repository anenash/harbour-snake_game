import QtQuick 2.6
import Sailfish.Silica 1.0

Item {
    id: root

    QtObject {
        id: internal

        property real positivePI: Math.sqrt(Math.PI) * 0.5
        property real negativePI: positivePI * -1
    }

    Item {
        anchors.fill: parent

        Label {
            id: upLabel

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.verticalCenter
            anchors.bottomMargin: Theme.horizontalPageMargin * 2

            text: "Rotate"
        }
        Label {
            id: leftLabel

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: Theme.horizontalPageMargin * 2

            text: "Left"
        }
        Label {
            id: rightLabel

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: Theme.horizontalPageMargin * 2

            text: "Right"
        }
        Label {
            id: downLabel

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter
            anchors.topMargin: Theme.horizontalPageMargin * 2

            text: "Down"
        }
    }

    Rectangle {
        id: fingerPoint

        color: "yellow"
        width: Theme.buttonWidthSmall * 0.35
        height: width
        radius: width

        x: parent.width * 0.5 - width * 0.5
        y: parent.height * 0.5 - height * 0.5
    }

    MultiPointTouchArea {
        anchors.fill: parent

        minimumTouchPoints: 1
        maximumTouchPoints: 2

        onGestureStarted: {
            var width1 = gesture.touchPoints[0].x - gesture.touchPoints[0].startX
            var heght1 = gesture.touchPoints[0].y - gesture.touchPoints[0].startY
            fingerPoint.x = gesture.touchPoints[0].x - fingerPoint.width * 0.5
            fingerPoint.y = gesture.touchPoints[0].y - fingerPoint.width * 0.5
            if (Math.abs(width1) > 50 || Math.abs(heght1) > 50) {
                var t = Math.pow(width1, 2) + Math.pow(heght1, 2)
                var g = Math.sqrt(t)
                var cos = width1/g
                var sin = heght1/g
                console.log("Gesture", width1, heght1)
                if((cos > internal.positivePI && cos <= 1) &&
                        ((sin > internal.negativePI && sin <= 0) || (sin < internal.positivePI && sin >= 0))) {
                    snakeGame.moveRight()
                } else if (((cos < internal.positivePI && cos > 0) || (cos > internal.negativePI && cos < 0)) &&
                           (sin >= internal.positivePI && sin <= 1)) {
                    snakeGame.moveDown()
                } else if (((cos < internal.positivePI && cos > 0) || (cos > internal.negativePI && cos < 0)) &&
                           (sin <= internal.negativePI && sin >= -1)) {
                    snakeGame.moveUp()
                } else if ((cos < internal.negativePI && cos > -1) &&
                           ((sin > internal.negativePI && sin < 0) || (sin < internal.positivePI && sin > 0))) {
                    snakeGame.moveLeft()
                }
            }
        }

        onUpdated: {
            if (touchPoints.length > 1) {
                snakeGame.moveForward()
            }
        }

        onReleased: {
            if (touchPoints.length === 1) {
                fingerPoint.x = root.width * 0.5 - fingerPoint.width * 0.5
                fingerPoint.y = root.height * 0.5 - fingerPoint.width * 0.5
            }
        }
    }
}
