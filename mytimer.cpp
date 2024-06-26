#include "mytimer.h"

MyTimer::MyTimer(QObject *parent)
    : QObject{parent}
{
    connect(&m_timer, &QTimer::timeout, this, &MyTimer::updateTimer);
    m_timer.setInterval(1000);

}

void MyTimer::resetTimer()
{
    m_timer.stop();
    m_seconds = 0;
    emit secondsChanged();
}

void MyTimer::setTimer(int seconds)
{
    m_seconds = seconds;
    emit secondsChanged();
    m_timer.start();
}

void MyTimer::pauseStartTimer()
{
    m_pause_timer = !m_pause_timer;
    emit pause_timerChanged();
    if (m_pause_timer)
    {
        m_timer.stop();
    }
    else
    {
        m_timer.start();
    }
}

void MyTimer::updateTimer()
{
    --m_seconds;
    emit secondsChanged();
    if (m_seconds <= 0)
    {
        m_timer.stop();
        emit timerFinished();
        m_seconds = 0;
        emit secondsChanged();
    }
}



int MyTimer::seconds() const
{
    return m_seconds;
}

void MyTimer::setSeconds(int newSeconds)
{
    if (m_seconds == newSeconds)
        return;
    m_seconds = newSeconds;
    emit secondsChanged();
}

bool MyTimer::pause_timer() const
{
    return m_pause_timer;
}

void MyTimer::setPause_timer(bool newPause_timer)
{
    if (m_pause_timer == newPause_timer)
        return;
    m_pause_timer = newPause_timer;
    emit pause_timerChanged();
}
