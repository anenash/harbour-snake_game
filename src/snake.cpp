#include "snake.h"

Snake::Snake(QObject *parent) : QObject(parent)
{

}

bool Snake::isEmpty()
{
    return m_snake.isEmpty();
}

void Snake::move(QPoint next)
{
    m_snake.insert(0, next);
    if(!m_snake.isEmpty())
    {
        m_snake.pop_back();
    }
}

void Snake::add(QPoint newPoint)
{
    if (m_snake.isEmpty())
    {
        m_snake.append(newPoint);
    }
    QPoint t = m_snake.last();
    move(newPoint);
    m_snake.append(t);
}

QPoint Snake::getFirst()
{
    return m_snake.first();
}

bool Snake::freePoint(QPoint check)
{
    return !m_snake.contains(check);
}

void Snake::reset()
{
    m_snake.clear();
}
