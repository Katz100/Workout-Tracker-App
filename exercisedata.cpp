#include "exercisedata.h"

ExerciseData::ExerciseData(QObject *parent)
    : QObject{parent}
{
    m_request.setRawHeader("X-Api-Key", m_key);
    qDebug() << "Device supports OpenSSL: " << QSslSocket::supportsSsl();

}



QVariantList ExerciseData::muscleGroup(const QString& muscle,
                                       const QString& type,
                                       const QString& name,
                                       const QString& difficulty)
{
    QVariantList exercises;
    QString path = m_apiPath + muscle
        + m_type + type
        + m_name + name
        + m_difficulty + difficulty;

    qDebug() << "path: " << path;
    m_request.setUrl(QUrl(path));
    QNetworkReply* reply = m_manager.get(m_request);

    //wait for request to finish before continuing
    QEventLoop loop;
    QObject::connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
    loop.exec();

    if (reply->error() == QNetworkReply::NoError)
    {
        QByteArray Response = reply->readAll();
        QJsonDocument jsonDoc = QJsonDocument::fromJson(Response);
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
