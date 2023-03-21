import 'package:mysql1/mysql1.dart';
//test

class Mysql{
      static String host = 'ipro-497-308-db.crhoiczd7use.us-east-1.rds.amazonaws.com',
                    user = 'frontGoose',
                    password = 'i-am-AFr0nty',
                    db = 'cybergoose';
      static int port = 3306;

      Mysql();

      Future<MySqlConnection> getConnection() async {
        var settings = ConnectionSettings(
            host: host,
            port: port,
            user: user,
            password: password,
            db: db
        );
        return await MySqlConnection.connect(settings);
      }
}
