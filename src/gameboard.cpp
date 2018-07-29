#include <QTimerEvent>
#include "gameboard.h"

QmlPiece::QmlPiece(bool value): m_active(value)
{

}

GameBoard::GameBoard(QObject *parent) : QObject(parent)
{
    m_currentDirection = GameBoard::Undefined;
    m_score = 0;
    m_level = 1;
    m_started = false;
    m_paused = false;
    m_muted = false;
    m_apples = 0;

    emit startedChanged(m_started);
    emit pausedChanged(m_paused);
    emit mutedChanged(m_muted);

    emit levelChanged(m_level);
    emit scoreChanged(m_score);
    emit applesChanged(m_apples);


    clearBoard();

//    connect(&m_apple, Apple::newApple(), [this]() {
//        randomApple();
//    });
}

void GameBoard::clearBoard()
{
    m_snake.reset();
    m_gameBoard.clear();
    for (int i = 0; i < BoardHeight * BoardWidth; ++i)
    {
        m_gameBoard.append(new QmlPiece(false));
    }
    emit gameBoardChanged(m_gameBoard);
}

void GameBoard::start()
{
    m_currentDirection = GameBoard::Up;
    QPoint startPoint;
    int x = BoardWidth / 2;
    int y = BoardHeight / 2;
    for (int i = 2; i >= 0; i--)
    {
        startPoint.setX(x);
        startPoint.setY(y + i);
        m_snake.add(startPoint);
    }
    randomApple();
    m_timer.start(timeoutTime(), this);
    m_started = true;
    emit startedChanged(m_started);
    emit pausedChanged(m_paused);
}

void GameBoard::pause(bool pause)
{
    m_paused = pause;
    if (m_paused)
    {
        m_timer.stop();
    }
    else
    {
        m_timer.start(timeoutTime(), this);
    }
    emit pausedChanged(m_paused);
}

void GameBoard::reset()
{
    m_score = 0;
    m_level = 1;
    m_apples = 0;
    emit scoreChanged(m_score);
    emit levelChanged(m_level);
    emit applesChanged(m_apples);

    clearBoard();
    start();
}

void GameBoard::mute()
{
    m_muted = !m_muted;
    emit mutedChanged(m_muted);
}

void GameBoard::timerEvent(QTimerEvent *event)
{
    if (event->timerId() == m_timer.timerId())
    {
        moveSnake();
    }
}

void GameBoard::moveSnake()
{
    QPoint currPoint = m_snake.getFirst();
    switch (m_currentDirection) {
    case GameBoard::Up:
        currPoint.setY(currPoint.y() - 1);
        break;
    case GameBoard::Down:
        currPoint.setY(currPoint.y() + 1);
        break;
    case GameBoard::Left:
        currPoint.setX(currPoint.x() - 1);
        break;
    case GameBoard::Right:
        currPoint.setX(currPoint.x() + 1);
        break;
    default:
        break;
    }
    if (tryMove(currPoint))
    {
        if (m_apple.compare(currPoint))
        {
            m_score += 100;
            m_snake.add(currPoint);
            randomApple();
            m_apples++;
            emit eatApple();
            emit applesChanged(m_apples);
            if ((9 >= m_level) && (m_score - (m_level * 1000) >= 0))
            {
                m_level++;
                emit levelChanged(m_level);
            }
        }
        else
        {
            m_snake.move(currPoint);
        }
        emit snakeMove();
        updateBoard();
        emit scoreChanged(m_score);
    }
    else {
        m_timer.stop();
        m_started = false;
        emit startedChanged(m_started);
        emit gameOver();
    }
}

void GameBoard::moveSnake(SnakeDirection direction)
{
    if (m_started && !m_paused)
    {
        switch (direction)
        {
        case GameBoard::Up:
            moveUp();
            break;
        case GameBoard::Down:
            moveDown();
            break;
        case GameBoard::Left:
            moveLeft();
            break;
        case GameBoard::Right:
            moveRight();
            break;
        default:
            break;
        }
    }
}

void GameBoard::moveDown()
{
    if (m_currentDirection != GameBoard::Up)
    {
        m_currentDirection = GameBoard::Down;
    }
    m_timer.start(timeoutTime(), this);
    moveSnake();
}

void GameBoard::moveUp()
{
    if (m_currentDirection != GameBoard::Down)
    {
        m_currentDirection = GameBoard::Up;
    }
    m_timer.start(timeoutTime(), this);
    moveSnake();
}

void GameBoard::moveLeft()
{
    if (m_currentDirection != GameBoard::Right)
    {
        m_currentDirection = GameBoard::Left;
    }
    m_timer.start(timeoutTime(), this);
    moveSnake();
}

void GameBoard::moveRight()
{
    if (m_currentDirection != GameBoard::Left)
    {
        m_currentDirection = GameBoard::Right;
    }
    m_timer.start(timeoutTime(), this);
    moveSnake();
}

void GameBoard::moveForward()
{
    if (m_started && !m_paused)
    {
        moveSnake();
    }
}

bool GameBoard::tryMove(QPoint &point)
{
    if (!m_snake.freePoint(point))
    {
        return false;
    }
    if (point.x() < 0
            || point.x() > BoardWidth - 1
            || point.y() < 0
            || point.y() > BoardHeight - 1)
    {
        return false;
    }
    return true;
}

void GameBoard::updateBoard()
{
    QPoint point;
    for (int x = 0; x < BoardWidth; x++)
    {
        for (int y = 0; y < BoardHeight; y++)
        {
            int pos = getShapeIndex(x, y);
            point.setX(x);
            point.setY(y);
            bool res = !m_snake.freePoint(point) || m_apple.compare(point);
            m_gameBoard.replace(pos, new QmlPiece(res));
        }
    }

    emit gameBoardChanged(m_gameBoard);
}

void GameBoard::randomApple()
{
    QPoint point;
    point.setX(qrand() % BoardWidth);
    point.setY(qrand() % BoardHeight);
    while (!m_snake.freePoint(point)) {
        point.setX(qrand() % BoardWidth);
        point.setY(qrand() % BoardHeight);
    }
    m_apple.addApple(point);
}
