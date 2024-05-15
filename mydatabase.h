#ifndef MYDATABASE_H
#define MYDATABASE_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>

class MyDatabase : public QObject
{
    Q_OBJECT
public:
    explicit MyDatabase(QObject *parent = nullptr);

signals:
    void workoutsChanged();
public slots:
    QVariantList getWorkouts(const QString& day);
    void deleteWorkouts();
    int addWorkout(const QString& day, const QString& workout_name, int sets, int rest);
    void deleteWorkoutAt(int id);
    void printTable();
    void editWorkout(int id, const QString& day, const QString& workout_name, int sets, int rest);
private:
    QSqlDatabase db_connection;
};

#endif // MYDATABASE_H
