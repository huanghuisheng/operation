package com.broadsense.iov.icloud.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.tonetime.commons.database.helper.DbHelper;
import com.tonetime.commons.database.helper.JdbcCallback;

@Repository("groupDao")
public class GroupDao extends BasicDao {
	// 查询所有的操作日志；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> queryOperationSum() throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "select  count(*) as number from iov_operation_log";
				return DbHelper.queryForList(connect, sql);
			}
		});
	}

	// 分页查询用户列表
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> queryOperationList(final int beginIndex, final String order, final String sort) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "select * from iov_operation_log ORDER BY " + " " + sort + " " + order + " limit ?,20 ";
				return DbHelper.queryForList(connect, sql, beginIndex);
			}
		});
	}

	// 动态查询用户
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> searchOperationList(final int offset, final String name, final String type, final Date time1, final Date time2) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				if (!name.equals("")) {
					System.out.println("nassme " + name);
					sql = "select * from iov_operation_log where c_name=? and c_type=? and t_create_time BETWEEN  ? and ? limit ?,20 ";
					return DbHelper.queryForList(connect, sql, name, type, time1, time2, offset);
				} else {
					System.out.println("namddde " + name);
					sql = "select * from iov_operation_log where  c_type=? and t_create_time BETWEEN  ? and ?  limit ?,20 ";
					return DbHelper.queryForList(connect, sql, type, time1, time2, offset);
				}
			}
		});
	}

	// 动态查询所有的操作日志；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> searchOperationSum(final String name, final String type, final Date time1, final Date time2) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				if (!name.equals("")) {
					System.out.println("nassme " + name);
					sql = "select count(*) as number from iov_operation_log where c_name=? and c_type=? and t_create_time BETWEEN  ? and ?";
					return DbHelper.queryForList(connect, sql, name, type, time1, time2);
				} else {
					System.out.println("namddde " + name);
					sql = "select count(*) as number from iov_operation_log where  c_type=? and t_create_time BETWEEN  ? and ?";
					return DbHelper.queryForList(connect, sql, type, time1, time2);
				}
			}
		});
	}

	//批量导入imei号；
	// 批量操作 ；
	
	public Object insertClientBatch(final List<Map<String,Object>> list) throws Exception {
		return (Object) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection con) throws SQLException, Exception {
				String sql = null;
		     		new Object();
				//sql = "update  "+travel+" SET c_st_region=? ,c_ed_region=? where c_imei=?";
				sql="INSERT INTO iov_device_client (c_client_name,c_imei,c_group,c_car_number,c_remark) VALUES(?,?,?,?,?)";
				try {
					PreparedStatement ps = null;
					con.setAutoCommit(false);
					ps = con.prepareStatement(sql);
					for (int i = 0; i <list.size(); i++) {
					    ps.setString(1, String.valueOf(list.get(i).get("c_client_name")));
					    ps.setString(2, String.valueOf(list.get(i).get("c_imei")));
					    ps.setString(3, String.valueOf(list.get(i).get("c_group")));
					    ps.setString(4, String.valueOf(list.get(i).get("c_car_number")));
					    ps.setString(5, String.valueOf(list.get(i).get("c_remark")));
						ps.addBatch();
						System.out.println("--------");
					}
				int[] a=	ps.executeBatch();
					con.commit();
					con.close();
					System.out.println("--true---");
					return 1;
				} catch (Exception e) {
					System.out.println("--s1sss---");
					e.printStackTrace();
					con.rollback();
					return 0;
				}
				
				
			}
		});
	}
	
	public Object insertMobileBatch(final List<Map<String,Object>> list) throws Exception {
		return (Object) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection con) throws SQLException, Exception {
				String sql = null;
				//sql = "update  "+travel+" SET c_st_region=? ,c_ed_region=? where c_imei=?";
				sql="INSERT INTO iov_administrator_group_imei (c_group_id,c_imei) VALUES(?,?)";
				try {
					PreparedStatement ps = null;
					con.setAutoCommit(false);
					ps = con.prepareStatement(sql);
					for (int i = 0; i <list.size(); i++) {
					    ps.setString(1, String.valueOf(list.get(i).get("c_group_id")));
					    ps.setString(2, String.valueOf(list.get(i).get("c_imei")));
					   
						ps.addBatch();
						System.out.println("--------");
					}
				int[] a=	ps.executeBatch();
					con.commit();
					con.close();
					System.out.println("--true---");
					return a;
				} catch (Exception e) {
					System.out.println("--s1sss---");
					e.printStackTrace();
					con.rollback();
					return 0;
				}
				
				
			}
		});
	}
	
	
	
	
	
	
	
	
	
	
}
