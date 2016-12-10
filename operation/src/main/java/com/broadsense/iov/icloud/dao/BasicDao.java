package com.broadsense.iov.icloud.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.tonetime.commons.database.DataSourceBuilder;
import com.tonetime.commons.database.helper.DbHelper;
import com.tonetime.commons.database.helper.JdbcCallback;

@Repository
public class BasicDao {

	public static DataSourceBuilder builder = null;

	// Map<String, Object> map = new HashMap<String, Object>();

	public BasicDao() {
		builder = DataSourceBuilder.getInstance();
	}

	// 根据id查询；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> basicQueryById(final String tableName, final int id) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;

				sql = "select * from " + tableName + " where n_id= ?";
				return DbHelper.queryForList(connect, sql, id);
			}
		});
	}

	// 根据条件字符串查询；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> basicQueryByString(final String tableName, final String field, final String name) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "select * from " + tableName + " where " + field;
				System.out.println("sql is ----------" + sql);
				return DbHelper.queryForList(connect, sql, name);
			}
		});
	}

	// 根据map条件来查询 动态查询；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> basicQueryByFields(final String tableName, final Map<String, Object> fields) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				return queryForRet(connect, tableName, fields);
			}
		});
	}

	public List<Map<String, Object>> queryForRet(Connection connect, String tableName, Map<String, Object> fields) throws SQLException {
		if (fields.size() < 1) {
			return null;
		}
		StringBuffer sb = new StringBuffer("SELECT * from ");
		sb.append(tableName).append(" WHERE" + " ");
		Iterator<String> fds = fields.keySet().iterator();
		while (fds.hasNext()) {
			sb.append(fds.next() + "=?");
			if (fds.hasNext()) {
				sb.append(" AND ");
			}
		}
		sb.append(" ");
		// int index = 1;
		PreparedStatement prep = connect.prepareStatement(sb.toString());
		// if(params!=null){
		// for (Object param : params) {
		// prep.setObject(index++, param);
		// }
		// }
		fds = fields.keySet().iterator();
		int index = 1;
		while (fds.hasNext()) {
			Object v = fields.get(fds.next());
			prep.setObject(index++, v);
		}
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		ResultSet result = prep.executeQuery();
		ResultSetMetaData medata = result.getMetaData();
		int columnCount = medata.getColumnCount();
		while (result.next()) {
			Map<String, Object> map = new HashMap<String, Object>();
			for (index = 0; index < columnCount; index++) {
				String colName = medata.getColumnLabel(index + 1);
				map.put(colName, result.getObject(colName));
			}
			resultList.add(map);
		}
		result.close();
		prep.close();
		return resultList;
	}

	// -----------------------------------------------------------------------可写；
	// -----------------------------------------------------------------------getWriteableDataSource
	// -----------------------------------------------------------------------
	// ----------------------------------------------------------------------
	// ------------------------------------------------------------------------------从表查询统计结果；
	// -----------------------------------------
	// ---------------------------------------------------------------------------公共函数
	// 分页查询用户列表
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> queryUserList(final String department, final int beginIndex, final String order, final String sort, final Date time1, final Date time2, final String timeFlag)
			throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;

				if (department.equals("0")) {
					sql = "select * from iov_statistics_userlist where t_statistics_time =? ORDER BY " + " " + sort + " " + order + " limit ?,10 ";
					return DbHelper.queryForList(connect, sql, timeFlag, beginIndex);

				} else {
					sql = "select * from iov_statistics_userlist where t_statistics_time =? and c_department =?  ORDER BY " + " " + sort + " " + order + " limit ?,10 ";
					return DbHelper.queryForList(connect, sql, timeFlag, department, beginIndex);
				}

			}
		});
	}

	// 查询所有的用户列表数量；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> queryUserSum(final int groupId, final String timeFlag) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				if (groupId == 0) {
					sql = "select  count(*) as number from iov_statistics_userlist where t_statistics_time=?";
					return DbHelper.queryForList(connect, sql, timeFlag);
				} else {
					sql = "select  count(*) as number from iov_statistics_userlist where c_department=? and t_statistics_time=? ";
					return DbHelper.queryForList(connect, sql, groupId, timeFlag);
				}
			}
		});
	}

	// 查询所有的用户列表数量；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> queryUserSum1(final int groupId, final Date time1, final Date time2, final String timeFlag) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				if (groupId == 0) {
					sql = "select  count(*) as number from iov_statistics_userlist where t_statistics_time =? ";
					return DbHelper.queryForList(connect, sql, timeFlag);
				} else {
					sql = "select  count(*) as number from iov_statistics_userlist where  c_department=? and t_statistics_time =? ";
					return DbHelper.queryForList(connect, sql, groupId, timeFlag);
				}

			}
		});
	}

	// 查询所有的分组imei号列表数量；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> queryGroupImeiSum(final int groupid) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "select  count(*) as number from iov_administrator_group_imei where c_group_id=?";
				return DbHelper.queryForList(connect, sql, groupid);
			}
		});
	}

	// 分页查询二级用户账号
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> querySecondImeiList(final int groupid, final int offset) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "select * from iov_device_client  where  c_group=?   limit ?,10";
				return DbHelper.queryForList(connect, sql, groupid, offset);
			}
		});
	}

	// 查询二级用户账号imei号数量
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> querySecondImeiSum(final int groupid) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "select count(*) as number from iov_device_client  where  c_group=?";
				return DbHelper.queryForList(connect, sql, groupid);
			}
		});
	}

	// 分页查询用户列表
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> queryGroupImeiList(final int groupid, final int offset) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "select * from iov_administrator_group_imei  where  c_group_id=?   limit ?,10";
				return DbHelper.queryForList(connect, sql, groupid, offset);
			}
		});
	}

	// 分组模糊查询

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> queryFuzzyAllImeiList(final String imei) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "select * from iov_administrator_group_imei  where  c_imei  like? limit 0,10";
				return DbHelper.queryForList(connect, sql, imei);
			}
		});
	}

	// 分组模糊查询
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> queryFuzzyGroupImeiList(final String groupid, final String imei) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				System.out.println("ssss-------" + groupid);
				if (null == groupid) {
					sql = "select * from iov_administrator_group_imei  where  c_imei  like? limit 0,10";
					return DbHelper.queryForList(connect, sql, imei + "%");
				} else {
					sql = "select * from iov_administrator_group_imei  where  c_group_id=? and  c_imei  like? limit 0,10";
					return DbHelper.queryForList(connect, sql, groupid, imei + "%");
				}

			}
		});
	}

	// 二级用户imei模糊查询
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> querySecondFuzzyImeiList(final int groupid, final String imei) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "select * from iov_device_client  where  c_group=? and  c_imei  like? limit 0,10";
				return DbHelper.queryForList(connect, sql, groupid, imei);
			}
		});
	}

	// 插入数据
	public Object basicInsertData(final String tableName, final Map<String, Object> fields) throws Exception {
		return (Object) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				return DbHelper.insertForRet(connect, tableName, fields);
			}
		});
	}

	// 修改信息；

	public Object basicUpdate(final String tableName, final Map<String, Object> fields, final String condition) throws Exception {
		return (Object) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				return DbHelper.update(connect, tableName, fields, condition);
			}
		});
	}

	// 删除信息；

	public Object basicDeleteData(final String tableName, final int id) throws Exception {
		return (Object) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "DELETE FROM  " + tableName + " where n_id=?";
				return DbHelper.executeUpdate(connect, sql, id);
			}
		});
	}

	// 根据imei删除信息；
	public Object basicDeleteImeiData(final String tableName, final String imei) throws Exception {
		return (Object) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "DELETE FROM  " + tableName + " where c_imei=?";
				return DbHelper.executeUpdate(connect, sql, imei);
			}
		});
	}

	// 插入用户操作日志；
	// 插入数据
	public static Object operationLogInsertData(final String name, final String address, final String type, final String content, final Date create_time, final String group) throws Exception {
		return (Object) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				Map<String, Object> fields = new HashMap<String, Object>();
				fields.put("c_name", name);
				fields.put("c_address", address);
				fields.put("c_type", type);
				fields.put("c_content", content);
				fields.put("t_create_time", create_time);
				fields.put("c_group", group);
				String tableName = "iov_operation_log";
				return DbHelper.insertForRet(connect, tableName, fields);
			}
		});
	}

	// 插入备用机操作日志；
	public static Object spareLogInsertData(final String name, final String content, final Date create_time, final String flag, final String spareId) throws Exception {
		return (Object) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				Map<String, Object> fields = new HashMap<String, Object>();
				fields.put("c_name", name);
				fields.put("c_content", content);
				fields.put("c_flag", flag);
				fields.put("c_spare_id", spareId);
				fields.put("t_create_time", create_time);
				String tableName = "iov_spare_log";
				return DbHelper.insertForRet(connect, tableName, fields);
			}
		});
	}
	//批量插入操作日志；
	@SuppressWarnings("unchecked")
	public List<Object> spareLogInsertDataBatch(final List<Map<String,Object>> list) throws Exception {
		return (List<Object>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection con) throws SQLException, Exception {
				List<Object> listId=new ArrayList<Object>();
				String sql = null;
				//sql = "update  "+travel+" SET c_st_region=? ,c_ed_region=? where c_imei=?";
				sql="INSERT INTO iov_spare_log (c_name,c_content,t_create_time,c_flag,c_spare_id) VALUES(?,?,?,?,?)";
				try {
					PreparedStatement ps = null;
					con.setAutoCommit(false);
					//ps = con.prepareStatement(sql);
					ps=con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
					for (int i = 0; i <list.size(); i++) {
					    ps.setString(1, String.valueOf(list.get(i).get("c_name")));
					    ps.setString(2, String.valueOf(list.get(i).get("c_content")));
					    ps.setString(3, String.valueOf(list.get(i).get("t_create_time")));
					    ps.setString(4, String.valueOf(list.get(i).get("c_flag")));
					    ps.setString(5, String.valueOf(list.get(i).get("c_spare_id")));
						ps.addBatch();
						System.out.println("--------");
					}
			     	ps.executeBatch();
					con.commit();
					
					ResultSet rs = ps.getGeneratedKeys() ;
					while(rs.next()){
					 System.out.println("----id is-----"+ rs.getInt(1));
					 listId.add(rs.getInt(1));
					}
					System.out.println("--true---");
					con.close();
				    return listId;
				} catch (Exception e) {
					System.out.println("--s1sss---");
					e.printStackTrace();
					con.rollback();
					return null;
				}
				
			}
		});
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	// 获取用户拥有的imei号
	@SuppressWarnings("unchecked")
	public static List<Map<String, Object>> userGetMobileImei(final String type, final String department) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				if (type.equals("1")) {
					sql = "SELECT  c_imei from  iov_device_client";
					return DbHelper.queryForList(connect, sql);
				} else {
					sql = "SELECT  c_imei from  iov_device_client where c_group=?";
					return DbHelper.queryForList(connect, sql, department);
				}
			}
		});
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getBehaviour(final String flagTime, final String code, final String groupId) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				if (groupId.equals("0")) {
					if ("allcode".equals(code)) {
						sql = "SELECT  * from  iov_group_behaviour where c_time=?";
						return DbHelper.queryForList(connect, sql, flagTime);
					} else {
						sql = "SELECT  * from  iov_group_behaviour where c_time=? and c_region like ?";
						return DbHelper.queryForList(connect, sql, flagTime, code + '%');
					}
				} else {
					if ("allcode".equals(code)) {
						sql = "SELECT  * from  iov_group_behaviour where c_time=? and c_group =?";
						return DbHelper.queryForList(connect, sql, flagTime, groupId);
					} else {
						sql = "SELECT  * from  iov_group_behaviour where c_time=? and c_group =? and c_region like ?";
						return DbHelper.queryForList(connect, sql, flagTime, groupId, code + '%');
					}
				}

			}
		});
	}

	@SuppressWarnings("unchecked")
	public static List<Map<String, Object>> getDriverBcategory(final String code, final String groupId) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				if (groupId.equals("0")) {
					if (code.equals("allcode")) {
						sql = "SELECT  * from  iov_group_bcategory";
						return DbHelper.queryForList(connect, sql);
					} else {
						sql = "SELECT  * from  iov_group_bcategory  where c_region like ?";
						return DbHelper.queryForList(connect, sql, code + '%');
					}
				} else {
					if (code.equals("allcode")) {
						sql = "SELECT  * from  iov_group_bcategory where c_group=?";
						return DbHelper.queryForList(connect, sql, groupId);
					} else {
						sql = "SELECT  * from  iov_group_bcategory  where c_group=? and c_region like ?";
						return DbHelper.queryForList(connect, sql, groupId, code + '%');
					}
				}

			}
		});
	}

	@SuppressWarnings("unchecked")
	public  List<Map<String, Object>> getDriverRuleTime(final String code, final String groupId) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				if (groupId.equals("0")) {
					if (code.equals("allcode")) {
						sql = "SELECT  * from  iov_group_ruletime";
						return DbHelper.queryForList(connect, sql);
					} else {
						sql = "SELECT  * from  iov_group_ruletime  where c_region like?";
						return DbHelper.queryForList(connect, sql,code + "%");
					}
				} else {

					if (code.equals("allcode")) {
						sql = "SELECT  * from  iov_group_ruletime where c_group =?";
						return DbHelper.queryForList(connect, sql,groupId);
					} else {
						sql = "SELECT  * from  iov_group_ruletime  where  c_group =? and  c_region like?";
						return DbHelper.queryForList(connect, sql,groupId,code + "%");
					}
				}

			}
		});
	}

	@SuppressWarnings("unchecked")
	public static List<Map<String, Object>> getArea(final String group) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				if (group.equals("0")) {
					sql = "SELECT  * from  iov_group_area";
					return DbHelper.queryForList(connect, sql);
				} else {
					sql = "SELECT  * from  iov_group_area where c_group=?";
					return DbHelper.queryForList(connect, sql, group);
				}

			}
		});
	}

	// -----------------------------------------------------------------------可读；
	// 分省查激活imei
	@SuppressWarnings("unchecked")
	public static List<Map<String, Object>> userGetActiveMobileImei1(final String imei, final String code) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getReadableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				if (code.equals("allcode")) {
					sql = "SELECT  c_imei from  iov_device where c_imei=?";
					return DbHelper.queryForList(connect, sql, imei);
				} else {
					sql = "SELECT  c_imei from  iov_device where c_imei=? and c_region_code like ?";
					return DbHelper.queryForList(connect, sql, imei, code + '%');
				}
			}
		});
	}

	// 筛选获取已经激活imei号
	@SuppressWarnings("unchecked")
	public static List<Map<String, Object>> userGetActiveMobileImei(final String imei) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getReadableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "SELECT  c_imei from  iov_device where c_imei=?";
				return DbHelper.queryForList(connect, sql, imei);
			}
		});
	}

}
