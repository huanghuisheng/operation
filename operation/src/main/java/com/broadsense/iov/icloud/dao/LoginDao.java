package com.broadsense.iov.icloud.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.broadsense.iov.icloud.dao.LoginDao;
import com.tonetime.commons.database.DataSourceBuilder;
import com.tonetime.commons.database.helper.DbHelper;
import com.tonetime.commons.database.helper.JdbcCallback;
import com.tonetime.commons.util.DateUtils;
import com.tonetime.commons.util.StringUtils;
@Repository("loginDao")
public class LoginDao   extends BasicDao {

	//查询用户与密码验证；
	   @SuppressWarnings("unchecked")
	public List<Map<String, Object>> loginValidation( final String userName,final String userPassword) throws Exception {
        return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
            public Object doInJdbc(Connection connect) throws SQLException, Exception {
         	  String sql=null;
              sql="select * from iov_system_administrator where c_name=? and c_password=?";
              return DbHelper.queryForList(connect, sql,userName,userPassword);
           }
        });
    } 	   


	

	   
	   
	
	
		


	   

}
