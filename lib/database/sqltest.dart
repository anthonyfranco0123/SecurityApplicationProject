import 'mysql.dart';
//test

class SQLTest {
  Future<List<String>> getmySQLData() async {
    var db = Mysql();
    String sql = 'select * from user_compliances_test limit 100';
    final List<String> myList = [];

    await db.getConnection().then((conn) async {
      await conn.query(sql).then((results) {
        for (var res in results) {
          print(res);
          myList.add('');
        }
      }).onError((error, stackTrace) {
        print(error);
        return null;
      });
      conn.close();
    });
    return myList;
  }
  Future<void> setMySQLData(String deviceName,
      String macAddress,
      String timestamp,
      String password,
      int passwordRestriction,
      int passwordExpiration,
      int autoUpdates,
      String systemPrivilege,
      int firewall,) async {
    var db = Mysql();
    String sql = 'select * from user_compliances_test limit 100';

    await db.getConnection().then((conn) async {
      // await conn.query(sql).then((results) {
      //   for (var res in results) {
      //     print(res);
      //     myList.add('');
      //   }
      // }).onError((error, stackTrace) {
      //   print(error);
      //   return null;
      // });
      // await conn.query(
      //   '''
      // INSERT INTO user_compliances_test (device_name, mac_address, timestamp, password, password_restriction, password_expiration, auto_updates, system_privilege, firewall)
      // VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
      // ''',
      //   [
      //     device_name,
      //     mac_address,
      //     timestamp,
      //     password,
      //     password_restriction,
      //     password_expiration,
      //     auto_updates,
      //     system_privilege,
      //     firewall,
      //   ],
      // );
      await conn.query('insert into user_compliances_test (device_name, mac_address, timestamp, password, password_restriction, password_expiration, auto_updates, system_privilege, firewall) values (?, ?, ?, ?, ?, ?, ?, ?, ?)',   [
      deviceName,
      macAddress,
      timestamp,
      password,
      passwordRestriction,
      passwordExpiration,
      autoUpdates,
      systemPrivilege,
      firewall,
      ],);
      conn.close();
    });
    // var result = await conn.query('insert into users (name, email, age) values (?, ?, ?)', ['Bob', 'bob@bob.com', 25]);
  }
}
