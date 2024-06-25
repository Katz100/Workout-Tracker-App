#include "exercisedata.h"

ExerciseData::ExerciseData(QObject *parent)
    : QObject{parent}
{
    m_request.setRawHeader("X-Api-Key", m_key);
}

QVariantList ExerciseData::muscleGroup(const QString &muscle)
{
    QVariantList exercises;
    QString path = m_apiPath + muscle;
    m_request.setUrl(QUrl(path));
    QNetworkReply* reply = m_manager.get(m_request);

    QEventLoop loop;
    QObject::connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
    loop.exec();

    if (reply->error() == QNetworkReply::NoError)
    {
        QString Response = reply->readAll();
        QJsonDocument jsonDoc = QJsonDocument::fromJson(Response.toUtf8());
        if (jsonDoc.isArray()) {
            QJsonArray jsonArray = jsonDoc.array();
            exercises = jsonArray.toVariantList();
        }

    }
    else
    {
        qDebug() << "Error: " << reply->errorString();
    }

    return exercises;
}
