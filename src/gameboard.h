#ifndef GAMEBOARD_H
#define GAMEBOARD_H

#include <QObject>
#include <QBasicTimer>
#include <QList>
#include <QQmlListProperty>
#include <QPoint>

#include "snake.h"
#include "apple.h"

const int BoardWidth = 10;
const int BoardHeight = 20;

class QmlPiece: public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool active READ active NOTIFY activeChanged)

public:
    explicit QmlPiece(bool value);

    bool active() { return m_active; }

signals:
    void activeChanged();

private:
    bool m_active;
};

class GameBoard : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool started READ started NOTIFY startedChanged)
    Q_PROPERTY(bool paused READ paused NOTIFY pausedChanged)
    Q_PROPERTY(bool muted READ muted NOTIFY mutedChanged)
    Q_PROPERTY(QString score READ score NOTIFY scoreChanged)
    Q_PROPERTY(int level READ level NOTIFY levelChanged)
    Q_PROPERTY(int apples READ apples NOTIFY applesChanged)
    Q_PROPERTY(QQmlListProperty<QmlPiece> gameBoard READ gameBoard NOTIFY gameBoardChanged)

public:

    enum SnakeDirection {
        Undefined = 0,
        Up,
        Left,
        Right,
        Down
    };
    Q_ENUM(SnakeDirection)

public:
    explicit GameBoard(QObject *parent = nullptr);

    QQmlListProperty<QmlPiece> gameBoard() { return QQmlListProperty<QmlPiece>(this, m_gameBoard); }
    QString score() { return QString::number(m_score); }
    int apples() { return m_apples; }
    int level() { return m_level; }
    bool started() { return m_started; }
    bool paused() { return m_paused; }
    bool muted() { return m_muted; }

    Q_INVOKABLE void start();
    Q_INVOKABLE void pause(bool pause);
    Q_INVOKABLE void reset();
    Q_INVOKABLE void mute();

    Q_INVOKABLE void moveSnake(SnakeDirection direction);
    Q_INVOKABLE void moveForward();


protected:
    void timerEvent(QTimerEvent *event) override;

signals:
    void gameOver();
    void gameBoardChanged(QList<QmlPiece *> data);
    void scoreChanged(int score);
    void levelChanged(int level);
    void applesChanged(int apples);
    void startedChanged(bool started);
    void pausedChanged(bool paused);
    void mutedChanged(bool muted);
    void snakeMove();
    void eatApple();

public slots:

private:
    QList<QmlPiece *> m_gameBoard;
    Snake m_snake;
    Apple m_apple;
    QBasicTimer m_timer;

    int m_currentDirection;
    int m_score;
    int m_level;
    int m_apples;

    bool m_started;
    bool m_paused;
    bool m_muted;

private:    
    void moveLeft();
    void moveRight();
    void moveDown();
    void moveUp();
    void clearBoard();
    void updateBoard();
    void moveSnake();
    bool tryMove(QPoint &point);
    void randomApple();
    inline int getShapeIndex(int x, int y) { return (y * BoardWidth) + x; }

    inline int timeoutTime() { return 1000 - ((m_level - 1) * 100); }

};

#endif // GAMEBOARD_H
