#ifndef EXERCISEDATA_H
#define EXERCISEDATA_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QCoreApplication>
#include <QSslSocket>

class ExerciseData : public QObject
{
    Q_OBJECT
public:
    explicit ExerciseData(QObject *parent = nullptr);

signals:

public slots:
    QVariantList muscleGroup(const QString& muscle,
                             const QString& type = QString(),
                             const QString& name = QString(),
                             const QString& difficulty = QString());
private:
    QNetworkAccessManager m_manager;
    QString m_apiPath = "https://api.api-ninjas.com/v1/exercises?muscle=";
    QString m_type = "&type=";
    QString m_name = "&name=";
    QString m_difficulty = "&difficulty=";
    const QByteArray m_key = "secret_key";
    QNetworkRequest m_request;
};

#endif // EXERCISEDATA_H
