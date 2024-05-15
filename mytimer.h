#ifndef MYTIMER_H
#define MYTIMER_H

#include <QObject>
#include <QTimer>

class MyTimer : public QObject
{
    Q_OBJECT
public:
    explicit MyTimer(QObject *parent = nullptr);
    Q_PROPERTY(int seconds READ seconds WRITE setSeconds NOTIFY secondsChanged)
    Q_PROPERTY(bool pause_timer READ pause_timer WRITE setPause_timer NOTIFY pause_timerChanged)

    int seconds() const;
    void setSeconds(int newSeconds);

    bool pause_timer() const;
    void setPause_timer(bool newPause_timer);

    bool isRunning() const;
    void setIsRunning(bool newIsRunning);

signals:
    void secondsChanged();

    void pause_timerChanged();



public slots:
    void resetTimer();
    void setTimer(int seconds);
    void pauseStartTimer();
    void updateTimer();


private:
    int m_seconds = 5;
    bool m_pause_timer = false;
    QTimer m_timer;

};

#endif // MYTIMER_H
