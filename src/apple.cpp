#include "apple.h"

Apple::Apple(QObject *parent) : QObject(parent)
{

}

void Apple::addApple(QPoint point)
{
    m_apple.setX(point.x());
    m_apple.setY(point.y());
}

bool Apple::compare(QPoint &point)
{
    if (m_apple == point)
    {
//        emit newApple();
        return true;
    }
    return false;
}
