#ifndef CARLISTSQL_H
#define CARLISTSQL_H

#include <QtSql>

class carListSQL: public QSqlQueryModel
{
    Q_OBJECT

    Q_PROPERTY(QSqlQueryModel* carModel READ getModel CONSTANT)
    Q_PROPERTY(bool IsConnectionOpen READ isConnectionOpen CONSTANT)

public:
    explicit carListSQL(QObject *parent);
    void refresh();
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const override;



    Q_INVOKABLE void add(const QString& brand, const QString& model, const QString& horsepower, const QString& maxTorque, const QString& accelerationTime);
    Q_INVOKABLE void del(const int index);
    Q_INVOKABLE void edit(const QString& brand, const QString& model, const QString& horsepower, const QString& maxTorque, const QString& accelerationTime, const int index);
signals:

public slots:

private:
    const static char* SQL_SELECT;
    QSqlDatabase db;
    QSqlQueryModel *getModel();
    bool _isConnectionOpen;
    bool isConnectionOpen();
};

#endif
