import java.sql.*;

public class App {
    public static void main(String[] args) throws Exception {
       Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/college", //url
        "root", //user
        "Sam4213#" //password
       );
       System.out.println(con);
       System.out.println("connection created");
       con.close();


    }
}
