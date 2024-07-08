#ifndef MYDATABASE_H
#define MYDATABASE_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>

class MyDatabase : public QObject
{
    Q_OBJECT
public:
    explicit MyDatabase(QObject *parent = nullptr);

signals:
    void workoutsChanged();
public slots:
    QVariantList getWorkouts(const QString& day);
    QVariantMap findWorkout(int id);
    int findRest(int id);
    void deleteWorkouts();
    int addWorkout(const QString& day, const QString& workout_name, int sets, int rest);
    bool deleteWorkoutAt(int id);
    bool deleteWorkoutsOnDay(const QString& day);
    void printTable();
    bool editWorkout(int id, const QString& day, const QString& workout_name, int sets, int rest);
    int countSets(const QString& day);
    int countRest(const QString& day);
    int findAverage(const QString& day);

    void printWeightsTable();
    void deleteAllWeights();
    int addWeight(int workout_id, int weight_used, int set_number);
    QVariantMap getWeightById(int id);
    QVariantList getWeightsByWorkoutId(int workout_id);
    QVariantList getWeightsByDate(const QString& date);
    QVariantList getWeightsAndWorkout(int workout_id);
private:
    QSqlDatabase db_connection;
};

#endif // MYDATABASE_H
