//#ifdef QT_QML_DEBUG
#include <QtQuick>
//#endif

#include <QTime>

#include <sailfishapp.h>
#include "gameboard.h"

int main(int argc, char *argv[])
{
    qsrand(QTime(0,0,0).secsTo(QTime::currentTime()));
    // SailfishApp::main() will display "qml/harbour-snake.qml", if you need more
    // control over initialization, you can use:
    //
    //   - SailfishApp::application(int, char *[]) to get the QGuiApplication *
    //   - SailfishApp::createView() to get a new QQuickView * instance
    //   - SailfishApp::pathTo(QString) to get a QUrl to a resource file
    //   - SailfishApp::pathToMainQml() to get a QUrl to the main QML file
    //
    // To display the view, call "show()" (will show fullscreen on device).
    qmlRegisterType<QmlPiece>();
    qmlRegisterType<GameBoard>("snake.Game", 1, 0, "Game");

    return SailfishApp::main(argc, argv);
}
