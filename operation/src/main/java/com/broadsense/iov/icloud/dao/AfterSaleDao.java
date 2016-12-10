package com.broadsense.iov.icloud.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.tonetime.commons.database.helper.DbHelper;
import com.tonetime.commons.database.helper.JdbcCallback;

@Repository("afterSaleDao")
public class AfterSaleDao extends BasicDao {
	// 安装网点数据统计；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> afterSaleWebSiteList(final String region, final int offset, final String order, final String sort) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				if (region.equals("allcode")) {
					sql = "SELECT * FROM iov_spare_as_website   ORDER BY " + " " + sort + " " + order + " limit ? ,10";
					System.out.println("----------sql-----" + sql);
					return DbHelper.queryForList(connect, sql, offset);
				} else {
					sql = "SELECT * FROM iov_spare_as_website where c_region like ?  ORDER BY " + " " + sort + " " + order + " limit ?,10";
					return DbHelper.queryForList(connect, sql, region + "%", offset);
				}
			}
		});
	}

	// 获取单个安装网点的imei号剩余量
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> afterSaleWebSiteImeiSum(final String websiteId) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "select  count(*) as number from iov_spare_as_change where c_website_id =? and c_spare_state=0 and c_receive_state=1 ";
				return DbHelper.queryForList(connect, sql, websiteId);
			}
		});
	}

	// 获取安装网点的数量；
	// 查询所有交换信息总数；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> afterSaleWebSiteSum(final String region) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				if (region.equals("allcode")) {
					sql = "select  count(*) as number from iov_spare_as_website ";
					return DbHelper.queryForList(connect, sql);
				} else {
					sql = "select  count(*) as number from iov_spare_as_website where c_region like ? ";
					return DbHelper.queryForList(connect, sql, region + "%");
				}

			}
		});
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> afterSaleWebSiteImeiList(final String webSiteId) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "SELECT * FROM iov_spare_as_change where c_website_id = ? and c_spare_state =0";
				return DbHelper.queryForList(connect, sql, webSiteId);
			}
		});
	}

	// 查询所有发送信息总数；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> afterSaleSendSum(final String region) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				if (region.equals("allcode")) {
					sql = "select  count(*) as number from iov_spare_as_send";
					return DbHelper.queryForList(connect, sql);
				} else {
					sql = "select  count(*) as number from iov_spare_as_send where c_region like ?";
					return DbHelper.queryForList(connect, sql, region + "%");
				}

			}
		});
	}

	// 查询交换机信息总数；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> querySpareAsChangeSum(final String region) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				if (region.equals("allcode")) {
					sql = "select  count(*) as number from iov_spare_as_change where c_receive_state=?";
					return DbHelper.queryForList(connect, sql, "1");
				} else {
					sql = "select  count(*) as number from iov_spare_as_change where c_receive_state=? and c_region like ?";
					return DbHelper.queryForList(connect, sql, "1", region + "%");
				}

			}
		});
	}

	// 备用机换机统计信息
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> afterSaleChangList(final String region, final int offset, final String order, final String sort) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				if (region.equals("allcode")) {
					sql = "SELECT * FROM iov_spare_as_change  where c_receive_state =? " + " ORDER BY " + " " + sort + " " + order + " limit ?,10";
					return DbHelper.queryForList(connect, sql, "1", offset);
				} else {
					sql = "SELECT * FROM iov_spare_as_change where c_region like ? and c_receive_state=?" + " limit ?,10";
					return DbHelper.queryForList(connect, sql, region + "%", "1", offset);
				}
			}
		});
	}

	// 备用机换机统计-查询备用imei信息
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> searchAfterSaleChang(final String afterSaleImei, final String region) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;

				if (region.equals("allcode")) {
					sql = "SELECT * FROM iov_spare_as_change where c_spare_imei = ? and c_receive_state =1";
					return DbHelper.queryForList(connect, sql, afterSaleImei);
				} else {
					sql = "SELECT * FROM iov_spare_as_change where c_spare_imei = ? and c_region like ? and c_receive_state =1";
					return DbHelper.queryForList(connect, sql, afterSaleImei, region + "%");
				}

			}
		});
	}

	// 备用机换机统计-模糊查询备用imei信息
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> fuzzySearchAfterSaleChang(final String afterSaleImei) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "SELECT * FROM iov_spare_as_change where c_afterSale_imei like ?";
				return DbHelper.queryForList(connect, sql, afterSaleImei + "%");
			}
		});
	}

	// -------------------------------------------------------------------------发货统计
	// 显示发货信息；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> afterSaleSendList(final String region, final int offset, final String order, final String sort) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				if (region.equals("allcode")) {
					sql = "SELECT * FROM iov_spare_as_send    ORDER BY " + " " + sort + " " + order + " limit ? ,10";
					System.out.println("----------sql-----" + sql);
					return DbHelper.queryForList(connect, sql, offset);
				} else {
					sql = "SELECT * FROM iov_spare_as_send where c_region like ? ORDER BY " + " " + sort + " " + order + " limit ?,10";
					return DbHelper.queryForList(connect, sql, region + "%", offset);
				}
			}

		});
	}

	// ------------------------------------------------------------------------显示日志；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> afterSaleShowLog(final String flag, final String recordId) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				String flag1 = null;
				if (flag.equals("0")) {
					flag1 = "10";
				} else {
					flag1 = "11";
				}
				sql = "SELECT * FROM iov_spare_log where c_flag =? and c_spare_id =?";
				return DbHelper.queryForList(connect, sql, flag1, recordId);
			}
		});
	}

	//
	//-------------------------------------------------------备用机批量插入；
	@SuppressWarnings("unchecked")
	public List<Object> insertAsSpareBatch(final List<Map<String, Object>> list) throws Exception {
		return (List<Object>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection con) throws SQLException, Exception {
				List<Object> listId = new ArrayList<Object>();
				String sql = null;
				// sql =
				// "update  "+travel+" SET c_st_region=? ,c_ed_region=? where c_imei=?";
				sql = "INSERT INTO iov_spare_as_change (c_spare_imei,c_region,c_website_id,c_receive_state,c_model,c_send_id,c_spare_state) VALUES(?,?,?,?,?,?,?)";
				try {
					PreparedStatement ps = null;
					con.setAutoCommit(false);
					// ps = con.prepareStatement(sql);
					ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

					for (int i = 0; i < list.size(); i++) {
						ps.setString(1, String.valueOf(list.get(i).get("c_spare_imei")));
						ps.setString(2, String.valueOf(list.get(i).get("c_region")));
						ps.setString(3, String.valueOf(list.get(i).get("c_website_id")));
						ps.setString(4, String.valueOf(list.get(i).get("c_receive_state")));
						ps.setString(5, String.valueOf(list.get(i).get("c_model")));
						ps.setString(6, String.valueOf(list.get(i).get("c_send_id")));
						ps.setString(7, String.valueOf(list.get(i).get("c_spare_state")));
						ps.addBatch();
						System.out.println("--------");
					}
					ps.executeBatch();
					con.commit();

					ResultSet rs = ps.getGeneratedKeys();
					while (rs.next()) {
						System.out.println("----id is-----" + rs.getInt(1));
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

}
