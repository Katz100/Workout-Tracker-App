#ifndef EXERCISEDATA_H
#define EXERCISEDATA_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QCoreApplication>

class ExerciseData : public QObject
{
    Q_OBJECT
public:
    explicit ExerciseData(QObject *parent = nullptr);

signals:

public slots:
    QVariantList muscleGroup(const QString& muscle);
private:
    QNetworkAccessManager m_manager;
    QString m_apiPath = "https://api.api-ninjas.com/v1/exercises?muscle=";
    const QByteArray m_key = "3Vu57OOgJ/cKr7ZXmJ+3gw==7slralJ58jR54C76";
    QNetworkRequest m_request;
};

#endif // EXERCISEDATA_H
