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

@Repository("spareDao")
public class SpareDao extends BasicDao {
	// 备用机换机统计信息
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> spareChangList(final String region,final int offset, final String order,final String sort) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				if (region.equals("allcode")) {
					sql = "SELECT * FROM iov_spare_change  where c_receive_state =? "+" ORDER BY " + " " + sort + " " + order + " limit ?,10";
					return DbHelper.queryForList(connect, sql, "1",offset);
				} else {
					sql = "SELECT * FROM iov_spare_change where c_region like ? and c_receive_state=?"+ " limit ?,10";
					return DbHelper.queryForList(connect, sql, region + "%","1",offset);
				}
			}
		});
	}

	// 备用机换机统计-查询备用imei信息
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> searchSpareChang(final String spareImei,final String code) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				if(code.equals("allcode"))
				{
					sql = "SELECT * FROM iov_spare_change where c_spare_imei = ?";
					return DbHelper.queryForList(connect, sql, spareImei);	
				}else
				{
					sql = "SELECT * FROM iov_spare_change where c_spare_imei = ? and c_region like ? ";
					return DbHelper.queryForList(connect, sql, spareImei,code+"%");	
				}
				
			}
		});
	}
	// 备用机换机统计-模糊查询备用imei信息
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> fuzzySearchSpareChang(final String spareImei,final String region) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "SELECT * FROM iov_spare_change where c_spare_imei like ? and c_region=? and c_spare_state=? limit 10";
				return DbHelper.queryForList(connect, sql, spareImei + "%",region,"0");
			}
		});
	} 
	   
	   
	//-------------------------------------------------------------------------发货统计   
	//显示发货信息；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> spareSendList(final String region,final int beginIndex, final String order, final String sort) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				//select * from iov_operation_log ORDER BY " + " " + sort + " " + order + " limit ?,20 "
				String sql = null;
				if (region.equals("allcode")) {
					sql = "SELECT * FROM iov_spare_send ORDER BY " + " " + sort + " " + order + " limit ?,10";
					return DbHelper.queryForList(connect, sql,beginIndex);
				} else {
					sql = "SELECT * FROM iov_spare_send where c_region like ?"+ " limit ?,10";
					return DbHelper.queryForList(connect, sql, region + "%",beginIndex);
				}
			}
		});
	}
	//查询所有发货信息总数；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> querySpareSendSum(final String region) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				if(region.equals("allcode"))
				{
					sql = "select  count(*) as number from iov_spare_send";
					return DbHelper.queryForList(connect, sql);	
				}else
				{
					sql = "select  count(*) as number from iov_spare_send where c_region like ?";
					return DbHelper.queryForList(connect, sql,region+"%");	
				}
		
			}
		});
	}
	//查询所有交换信息总数；
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> querySpareChangeSum(final String region) throws Exception {
		return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				if(region.equals("allcode"))
				{
					sql = "select  count(*) as number from iov_spare_change where c_receive_state=?";
					return DbHelper.queryForList(connect, sql,"1");	
				}else
				{
					sql = "select  count(*) as number from iov_spare_change where c_receive_state=? and c_region like ?";
					return DbHelper.queryForList(connect, sql,"1",region+"%");	
				}
		
			}
		});
	}
	
	//------------------------------------------------------------------------显示日志；
		@SuppressWarnings("unchecked")
		public List<Map<String, Object>> spareShowLog(final String flag,final String recordId) throws Exception {
			return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
				public Object doInJdbc(Connection connect) throws SQLException, Exception {
					String sql = null;
					String flag1=null;
					if (("0").equals(flag)) {
						flag1="00";
					} else {
						flag1="01";
					}
					sql = "SELECT * FROM iov_spare_log where c_flag =? and c_spare_id =?";
					return DbHelper.queryForList(connect, sql,flag1,recordId);
				}
			});
		}
		
	//	SELECT COUNT(*) FROM iov_spare_change where c_install_state ="0" and c_region like "43%"
		//--------------------------------------------------------------------	//发货数量
		@SuppressWarnings("unchecked")
		public List<Map<String, Object>> spareShowSendList(final String code) throws Exception {
			return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
				public Object doInJdbc(Connection connect) throws SQLException, Exception {
					String sql = null;
					if(code.endsWith("allcode"))
					{
						sql = "SELECT  ifnull(sum(c_number),0) as number FROM iov_spare_send where c_receiver_state=1 ";
						return DbHelper.queryForList(connect, sql);	
					}else
					{
						sql = "SELECT   ifnull(sum(c_number),0) as number FROM iov_spare_send where  c_receiver_state=1 and c_region like ?";
						return DbHelper.queryForList(connect, sql,code+"%");		
					}
				}
			});
		}
		
		
		//	SELECT COUNT(*) FROM iov_spare_change where c_install_state ="0" and c_region like "43%"
		//--------------------------------------------------------------------	//发货数量
		@SuppressWarnings("unchecked")
		public List<Map<String, Object>> spareShowSendListTest(final String code) throws Exception {
			return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
				public Object doInJdbc(Connection connect) throws SQLException, Exception {
					String sql = null;
					if(code.endsWith("allcode"))
					{
						sql = "SELECT  c_number,c_region FROM iov_spare_send where c_receiver_state=1 ";
						return DbHelper.queryForList(connect, sql);	
					}else
					{
						sql = "SELECT  c_number,c_region FROM iov_spare_send where  c_receiver_state=1 and c_region like ?";
						return DbHelper.queryForList(connect, sql,code+"%");		
					}
				}
			});
		}
		
		//--------------------------------------------------------------------	//备用机发货数量
		@SuppressWarnings("unchecked")
		public List<Map<String, Object>> spareShowSendList1(final String code) throws Exception {
			return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
				public Object doInJdbc(Connection connect) throws SQLException, Exception {
					String sql = null;
					if(code.endsWith("allcode"))
					{
						sql = "SELECT  ifnull(sum(c_number),0) as number FROM iov_spare_send where c_receiver_state=1 and c_send_type=1";
						return DbHelper.queryForList(connect, sql);	
					}else
					{
						sql = "SELECT   ifnull(sum(c_number),0) as number FROM iov_spare_send where  c_receiver_state=1 and c_send_type=1 and c_region like ?";
						return DbHelper.queryForList(connect, sql,code+"%");		
					}
				}
			});
		}
		//--------------------------------------------------------------------	//备用机发货数量
		@SuppressWarnings("unchecked")
		public List<Map<String, Object>> spareShowSendList1Test(final String code) throws Exception {
			return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
				public Object doInJdbc(Connection connect) throws SQLException, Exception {
					String sql = null;
					if(code.endsWith("allcode"))
					{
						sql = "SELECT  c_number,c_region FROM iov_spare_send where c_receiver_state=1 and c_send_type=1";
						return DbHelper.queryForList(connect, sql);	
					}else
					{
						sql = "SELECT   c_number,c_region FROM iov_spare_send where  c_receiver_state=1 and c_send_type=1 and c_region like ?";
						return DbHelper.queryForList(connect, sql,code+"%");		
					}
				}
			});
		}
		
		
		
		//---------------------------------------------------------------------//已激活；
		@SuppressWarnings("unchecked")
		public List<Map<String, Object>> spareShowActiveList(final String code) throws Exception {
			return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
				public Object doInJdbc(Connection connect) throws SQLException, Exception {
					String sql = null;
					if(code.endsWith("allcode"))
					{
						sql = "SELECT COUNT(*) as number FROM iov_spare_change where c_active_state = ?";
						return DbHelper.queryForList(connect, sql,"1");	
					}else
					{
						sql = "SELECT COUNT(*)  as number FROM iov_spare_change where c_active_state =? and c_region like ?";
						return DbHelper.queryForList(connect, sql,"1",code+"%");		
					}
				}
			});
		}	
		
		//---------------------------------------------------------------------//已激活；
		@SuppressWarnings("unchecked")
		public List<Map<String, Object>> spareShowActiveListTest(final String code) throws Exception {
			return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
				public Object doInJdbc(Connection connect) throws SQLException, Exception {
					String sql = null;
					if(code.endsWith("allcode"))
					{
						sql = "SELECT c_region FROM iov_spare_change where c_active_state = ?";
						return DbHelper.queryForList(connect, sql,"1");	
					}else
					{
						sql = "SELECT c_region FROM iov_spare_change where c_active_state =? and c_region like ?";
						return DbHelper.queryForList(connect, sql,"1",code+"%");		
					}
				}
			});
		}
		
		//---------------------------------------------------------------------//已安装；
		@SuppressWarnings("unchecked")
		public List<Map<String, Object>> spareShowInstallList(final String code) throws Exception {
			return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
				public Object doInJdbc(Connection connect) throws SQLException, Exception {
					String sql = null;
					
					if(code.endsWith("allcode"))
					{
						sql = "SELECT COUNT(*) as number FROM iov_spare_change where c_install_state = ?";
						return DbHelper.queryForList(connect, sql,"1");	
					}else
					{
						sql = "SELECT COUNT(*) as number FROM iov_spare_change where c_install_state =? and c_region like ?";
						return DbHelper.queryForList(connect, sql,"1",code+"%");		
					}
				}
			});
		}	
		
		//---------------------------------------------------------------------//已安装；
		@SuppressWarnings("unchecked")
		public List<Map<String, Object>> spareShowInstallListTest(final String code) throws Exception {
			return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
				public Object doInJdbc(Connection connect) throws SQLException, Exception {
					String sql = null;
					
					if(code.endsWith("allcode"))
					{
						sql = "SELECT c_region  FROM iov_spare_change where c_install_state = ?";
						return DbHelper.queryForList(connect, sql,"1");	
					}else
					{
						sql = "SELECT c_region FROM iov_spare_change where c_install_state =? and c_region like ?";
						return DbHelper.queryForList(connect, sql,"1",code+"%");		
					}
				}
			});
		}
		
		
		//---------------------------------------------------------------------//已绑定；
		@SuppressWarnings("unchecked")
		public List<Map<String, Object>> spareShowBindeList(final String code) throws Exception {
			return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
				public Object doInJdbc(Connection connect) throws SQLException, Exception {
					String sql = null;
					if(code.endsWith("allcode"))
					{
						sql = "SELECT COUNT(*)  as number FROM iov_spare_change where c_binding_state = ?";
						return DbHelper.queryForList(connect, sql,"1");	
					}else
					{
						sql = "SELECT COUNT(*)  as number FROM iov_spare_change where c_binding_state =? and c_region like ?";
						return DbHelper.queryForList(connect, sql,"1",code+"%");		
					}
				}
			});
		}
		
		
		//---------------------------------------------------------------------//已绑定；
		@SuppressWarnings("unchecked")
		public List<Map<String, Object>> spareShowBindeListTest(final String code) throws Exception {
			return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
				public Object doInJdbc(Connection connect) throws SQLException, Exception {
					String sql = null;
					if(code.endsWith("allcode"))
					{
						sql = "SELECT c_region FROM iov_spare_change where c_binding_state = ?";
						return DbHelper.queryForList(connect, sql,"1");	
					}else
					{
						sql = "SELECT c_region FROM iov_spare_change where c_binding_state =? and c_region like ?";
						return DbHelper.queryForList(connect, sql,"1",code+"%");		
					}
				}
			});
		}
		
		
		
		
		
		
		
		
		
		//查询地图编码；
		   @SuppressWarnings("unchecked")
		public List<Map<String, Object>> code_regionList( final String flag) throws Exception {
	        return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
	            public Object doInJdbc(Connection connect) throws SQLException, Exception {
	         	   String sql=null;
	             // sql="select c_code, c_city from code_region where c_code like ? GROUP BY c_city ";
	         	  sql=" SELECT * FROM code_region where c_code like ? and  c_code  not in (SELECT c_code FROM code_region where c_code like ? ) GROUP BY c_city";
	              return DbHelper.queryForList(connect, sql,flag+'%',flag+"00"+"%");
	           }
	        });
	    } 	   
		   @SuppressWarnings("unchecked")
		public List<Map<String, Object>> code_regionList1( final String flag) throws Exception {
		        return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
		            public Object doInJdbc(Connection connect) throws SQLException, Exception {
		         	   String sql=null;
		         	   System.out.println("mmmssssmm"+flag);
		              sql="SELECT c_code, c_county  from  code_region where c_city=?";
		              return DbHelper.queryForList(connect, sql,flag);
		           }
		        });
		    } 
		
		   @SuppressWarnings("unchecked")
		public List<Map<String, Object>> code_regionList2( final String flag) throws Exception {
		        return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
		            public Object doInJdbc(Connection connect) throws SQLException, Exception {
		         	   String sql=null;
		              sql="SELECT * from  code_region where c_code=?";
		              return DbHelper.queryForList(connect, sql,flag);
		            }
		        });
		    } 
		   @SuppressWarnings("unchecked")
			public List<Map<String, Object>> code_regionList3( final String name) throws Exception {
			        return (List<Map<String, Object>>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			            public Object doInJdbc(Connection connect) throws SQLException, Exception {
			         	   String sql=null;
			              sql="SELECT * from code_region where c_province like ? GROUP BY c_province";
			              return DbHelper.queryForList(connect, sql,name+"%");
			         
			            }
			        });
			    } 
		
	// 更新交换表的收货状态；
	@SuppressWarnings("unchecked")
	// 更新新增或累积数据；
	public Object updateChangeReState(final String state, final String sendId) throws Exception {
		return (Object) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection connect) throws SQLException, Exception {
				String sql = null;
				sql = "update  iov_spare_change set c_receive_state=? where c_send_id=?";
				return DbHelper.executeUpdate(connect, sql, state, sendId);
			}
		});
	}
	
	//备用机批量插入；
	
	@SuppressWarnings("unchecked")
	public List<Object> insertSpareBatch(final List<Map<String,Object>> list) throws Exception {
		return (List<Object>) DbHelper.execute(builder.getDataSourceCluster().getWriteableDataSource(), new JdbcCallback() {
			public Object doInJdbc(Connection con) throws SQLException, Exception {
				List<Object> listId=new ArrayList<Object>();
				String sql = null;
				//sql = "update  "+travel+" SET c_st_region=? ,c_ed_region=? where c_imei=?";
				sql="INSERT INTO iov_spare_change (c_spare_imei,c_region,c_area,c_receive_state,c_model,c_send_id) VALUES(?,?,?,?,?,?)";
				try {
					PreparedStatement ps = null;
					con.setAutoCommit(false);
					//ps = con.prepareStatement(sql);
					ps=con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
					
					for (int i = 0; i <list.size(); i++) {
					    ps.setString(1, String.valueOf(list.get(i).get("c_spare_imei")));
					    ps.setString(2, String.valueOf(list.get(i).get("c_region")));
					    ps.setString(3, String.valueOf(list.get(i).get("c_area")));
					    ps.setString(4, String.valueOf(list.get(i).get("c_receive_state")));
					    ps.setString(5, String.valueOf(list.get(i).get("c_model")));
					    ps.setString(6, String.valueOf(list.get(i).get("c_send_id")));
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
			
			
			
			
			

	
}
