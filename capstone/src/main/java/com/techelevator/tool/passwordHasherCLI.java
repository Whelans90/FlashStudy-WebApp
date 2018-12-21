package com.techelevator.tool;

import javax.sql.DataSource;

import org.bouncycastle.util.encoders.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import com.techelevator.model.JDBCUserDAO;
import com.techelevator.security.PasswordHasher;

public class passwordHasherCLI {


		
		
		static PasswordHasher hashMaster;
		
		
		public static void hashPassword(String password) {
			
			byte[] salt = hashMaster.generateRandomSalt();
			String hashedPassword = hashMaster.computeHash(password, salt);
			String saltString = new String(Base64.encode(salt));
			
			System.out.println("Password: " + password + "\n HashedPassword: " + hashedPassword + "\n Salt: " + saltString);
			System.out.println();
		}
		public static void main(String[] args) {
			hashMaster = new PasswordHasher();
			hashPassword("PasswordForFakeAccounts1");
		}

}// END OF CLASS
