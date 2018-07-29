import QtQuick 2.6
import QtMultimedia 5.6
import Sailfish.Silica 1.0

import snake.Game 1.0

import "../components"

Page {
    id: root

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    property variant activeApp: Qt.application.state
    property variant appVersion: Qt.application.version

    property string hightScore: database.record
    property bool gameOver: false
    property bool settingsEnabled: false


    FontLoader {
        id: lcdFont

        source: "../pages/ds-digital-bold.ttf"
    }

    SoundEffect {
        id: soundStart

        source: "../sounds/select.wav"
        muted: snakeGame.muted
    }

    SoundEffect {
        id: soundLineRemoved

        source: "../sounds/remove_line.wav"
        muted: snakeGame.muted
    }

    SoundEffect {
        id: soundMoved

        source: "../sounds/move.wav"
        muted: snakeGame.muted
    }

    SoundEffect {
        id: soundRotate

        source: "../sounds/turn.wav"
        muted: snakeGame.muted
    }

    SoundEffect {
        id: soundGameOver

        source: "../sounds/gameOver.wav"
        muted: snakeGame.muted
    }

    Database {
        id: database
    }

    Game {
        id: snakeGame

        onScoreChanged: {
            if(score > parseInt(hightScore)) {
                database.storeData("snakeGame", score)
            }
            database.readRecord("snakeGame")
        }

        onMutedChanged: {
            if(!soundStart.playing && !snakeGame.muted) {
                soundStart.play()
            }
        }

        onStartedChanged: {
            if(!soundStart.playing && snakeGame.started) {
                root.gameOver = false
                soundStart.play()
            }
        }

        onPausedChanged: {
            if(!soundStart.playing) {
                soundStart.play()
            }
        }

        onGameOver: {
            root.gameOver = true
            if(!soundGameOver.playing) {
                soundGameOver.play()
            }
        }

        onSnakeMove: {
            if(!soundMoved.playing && snakeGame.started) {
                soundMoved.play()
            }
        }

        onEatApple: {
            if(!soundLineRemoved.playing && snakeGame.started) {
                soundLineRemoved.play()
            }
        }
    }

    onActiveAppChanged: {
        if (activeApp !== Qt.ApplicationActive) {
            app.coverLevel = snakeGame.level
            app.coverScore = snakeGame.score
            app.applesCount = snakeGame.apples
            if (snakeGame.started)
            {
                snakeGame.pause(true)
            }
        }
    }

    onOrientationChanged: {
        if (orientation === Orientation.Portrait || orientation === Orientation.PortraitInverted ) {
            gameBoard.source = "GamePortrait.qml"
        } else if (orientation === Orientation.Landscape || orientation === Orientation.LandscapeInverted) {
            gameBoard.source = "GameLandscape.qml"
        }
    }

    Component.onCompleted: {
        console.log("App version", Qt.application.version)
        database.initDatabase()
        database.readRecord("snakeGame")
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: root.height

        PageHeader {
            title: "Main"
        }

        Loader {
            id: gameBoard

            anchors.fill: parent
            source: "GamePortrait.qml"
        }
    }
}
