#ifndef APPLE_H
#define APPLE_H

#include <QObject>
#include <QPoint>

class Apple : public QObject
{
    Q_OBJECT
public:
    explicit Apple(QObject *parent = nullptr);

    void addApple(QPoint point);
    bool compare(QPoint &point);

signals:
    void newApple();

public slots:

private:
    QPoint m_apple;
};

#endif // APPLE_H
