package com.broadsense.iov.icloud.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.tonetime.commons.database.helper.DbHelper;
import com.tonetime.commons.database.helper.JdbcCallback;

@Repository("deviceDao")
public class DeviceDao extends BasicDao {
	// -----------------------------------------------------------------------可写；
	// -----------------------------------------------------------------------getWriteableDataSource
	// -----------------------------------------------------------------------
	// ----------------------------------------------------------------------
	// ----------------------------------------------------------------单个设备-地域规律
	// travel,imei, todayDate1, todayDate2
	// 单个设备的驾驶行为；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> singleGetImeiBehavior(final String travel, final String imei, final Date time1, final Date time2) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "SELECT  * FROM    " + travel + "   WHERE  c_imei= ? and t_ed_time BETWEEN   ?  and ?";
				return DbHelper.queryForList(connect, sql, imei, time1, time2);
			}
		});
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> singleDiverRuleArea(final String travel, final String imei, final String flag, final Date startTime, final Date endTime) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "select t_st_time ,t_ed_time  from  " + travel + "  where c_imei=?  and (c_st_region like  ? OR c_ed_region like  ? ) and t_ed_time  BETWEEN   ?  and ? ";
				return DbHelper.queryForList(connect, sql, imei, flag, flag, startTime, endTime);
			}
		});
	}
	// --------------------------------------------查询轨迹段和驾驶行为；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> singleDiverTravel(final String travel, final String imei, final Date time1, final Date time2) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "SELECT t_st_time ,t_ed_time,c_driver,n_distance,n_speed FROM  " + travel + " WHERE  c_imei=? and t_st_time  >=? and t_ed_time  <=?";
				return DbHelper.queryForList(connect, sql, imei, time1, time2);
			}
		});
	}
	// ------------------------------------------------------------------------单一个人的驾驶规律时间段
	// 获取个人 一段里 时间行驶 规律
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> singleDiverRuleTime(final String travel, final String imei, final int time1, final int time2, final Date startTime, final Date endTime) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "SELECT   c_imei FROM  " + travel + " WHERE  c_imei=? and ((DATE_FORMAT(t_st_time, '%H') = ?) or (DATE_FORMAT(t_ed_time, '%H') =?)) and t_ed_time  BETWEEN ? and ? ";
				return DbHelper.queryForList(connect, sql, imei, time2, time2, startTime, endTime);
			}
		});
	}
	// 单个设备信息显示；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> singleGetImeiInformation(final String imei) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				String time = "year";
				sql = "SELECT * from  iov_statistics_userlist  where c_imei=?  and t_statistics_time =?  ORDER BY  n_id ";
				return DbHelper.queryForList(connect, sql, imei, time);
			}
		});
	}

	
	
	
	
	
	// -----------------------------------------------------------------------可读；
	// -----------------------------------------------------------------------getReadableDataSource
	// -----------------------------------------------------------------------
	// ----------------------------------------------------------------------
	// 获取在线信息；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getlocal(final String imei, final Date startTime, final Date endTime) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getReadableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				//sql = "SELECT  n_lng,n_lat from iov_dev_ol where  c_imei =? AND t_online BETWEEN ? and ?";
				sql = "SELECT  n_lng,n_lat from iov_dev_ol where  c_imei =? AND ISNULL(t_offline) ORDER BY t_offline DESC limit 1";
				return DbHelper.queryForList(connect, sql, imei);
			}
		});
	}
	// 获取激活时间
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getCreateTime(final String imei) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getReadableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;

				sql = "select  c_imei ,t_create_time from iov_device  where c_imei=?";
				return DbHelper.queryForList(connect, sql, imei);
			}
		});
	}
	
	
	// --------------------------------查询设备轨迹坐标；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> trackUser(final String model, final String imei, final Date startTime, final Date endTime, final String flag) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getReadableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "select c_model as model,c_imei as imei ,n_lat as lat ,n_lng  as lng ,n_type as type,t_data_time as datatime from " + flag
						+ " where n_type =2 and c_imei=? and c_model=? and  t_data_time BETWEEN ? and ? order by t_data_time ";
				return DbHelper.queryForList(connect, sql, imei, model, startTime, endTime);
			}
		});
	}
	// 查询碰撞视频数量和路径；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> videoUserNumber(final String flag, final String model, final String imei, final Date startTime, final Date endTime) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getReadableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				String stopEvent = "stopEvent";
				sql = "select   n_id,c_model,c_imei ,n_lat ,n_lng ,c_res_path ,t_data_time from  " + flag
						+ " where c_token= ?  and c_model =?  and c_imei=? and t_data_time  BETWEEN   ? and ?  ORDER BY t_data_time DESC  ";
				return DbHelper.queryForList(connect, sql, stopEvent, model, imei, startTime, endTime);
			}
		});
	}
	
	
	
	
	
	
}
