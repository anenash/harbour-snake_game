#ifndef SNAKE_H
#define SNAKE_H

#include <QObject>
#include <QVector>
#include <QPoint>

class Snake : public QObject
{
    Q_OBJECT
public:
    explicit Snake(QObject *parent = nullptr);
    void add(QPoint newPoint);
    void move(QPoint next);
    void reset();
    QPoint getFirst();
    bool freePoint(QPoint check);
    bool isEmpty();

signals:
    bool collision();

public slots:

private:
    QVector<QPoint> m_snake;
};

#endif // SNAKE_H
