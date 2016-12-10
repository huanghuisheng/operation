
<%@page import="com.broadsense.iov.lbs.GpsProcess"%>
<%@page import="com.broadsense.iov.lbs.LbsService"%>
<%@page import="com.broadsense.iov.lbs.pojo.GPSLacBean"%>
<%@page import="com.broadsense.iov.base.data.entity.TravelEntity"%>
<%@page import="com.broadsense.iov.base.data.entity.LacEntity"%>
<%-- <%@page import="com.broadsense.iov.weixin.Response"%> --%>
<%@page import="com.broadsense.iov.base.data.entity.MediaEntity"%>
<%-- <%@page import="com.broadsense.iov.weixin.base.entity.WeixinDevEntity"%>
<%@page import="com.broadsense.iov.weixin.base.entity.SubscriberEntity"%> --%>
<%@page import="com.broadsense.iov.base.api.DataFacade"%>
<%@page import="org.slf4j.Logger"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.tonetime.commons.util.ParamUtils"%>
<%@page import="com.tonetime.commons.util.StringUtils"%>
<%@page import="com.tonetime.commons.util.HttpUtils"%>
<%@ page pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/lib.jsp" %>
<%!    public final static Logger LOGGER = LoggerFactory.getLogger("com.broadsense.iov.wx.controller.Media");

    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String act = ParamUtils.getString(request, "act", "");
  /*       if (StringUtils.equals(act, "show")) {
            show(request, response);
            return;
        } */
        index(request, response);
    }

    public void index(HttpServletRequest request, HttpServletResponse response) throws Exception {
  
        
        String imei = ParamUtils.getString(request, "imei", "");
        
        String model = ParamUtils.getString(request, "model", "");
        String strartTime1 = ParamUtils.getString(request, "strartTime", "");
        String endTime1 = ParamUtils.getString(request, "endTime", "");
   
        
        
        Date startDate = new Date(116,8,03);
        Date date = new Date(116,8,05);
        
/*         request.setAttribute("st", startDate.getTime());
        request.setAttribute("ed", date.getTime()); */
     
      
        List<TravelEntity> resultList = queryTravel(startDate,date,imei,model);
      
        List<List<LacEntity>> resultList1 =new ArrayList<List<LacEntity>>();
        
        for(int i=0 ;i<resultList.size();i++)
        {
          Date  strartTime=	 resultList.get(i).getStTime();        
          Date  endTime  =	 resultList.get(i).getEdTime();
          
          List<LacEntity> resultList2  = show(request,response,strartTime,endTime,imei,model);
          
          resultList1.add(resultList2);
          
    
          
        }
        
   
  String jsonString = JSON.toJSONString(resultList1);
        
        
        PrintWriter out = response.getWriter();
        
        out.println(jsonString);  

    }
/*     String strartTime,String endTime,String imei,String model */
    public List<LacEntity> show(HttpServletRequest request, HttpServletResponse response,Date strartTime,Date endTime, String imei,String model) throws Exception {

        final List<LacEntity> resultList = new ArrayList<LacEntity>();
     
        List<LacEntity> list = DataFacade.getInstance().findTrackList(model, imei, strartTime, endTime);
        
         GpsProcess gpsProcess = new GpsProcess(null);
        for (LacEntity gps : list) {
            if (gpsProcess.filter(gps)) {
                resultList.add(gps);
            }
        } 
       // JSONArray jsonarray = JSONArray.fromObject(resultList); 
        return list;
       // forward(request, response, "/WEB-INF/pages/view/yyskys/travel-show.jsp");
    }

    public void fillAddress(List<TravelEntity> list) {
        for (TravelEntity travel : list) {
            try {
                GPSLacBean region = LbsService.getInstance().getGPSTrack(travel.getStLng(), travel.getStLat(), LbsService.TYPE_GCJ02);
                if (region != null) {
                    travel.setStRegionCode(region.getRegionCode());
                    travel.setStAddr(region.getAddress());
                }
                region = LbsService.getInstance().getGPSTrack(travel.getEdlng(), travel.getEdLat(), LbsService.TYPE_GCJ02);
                if (region != null) {
                    travel.setEdRegionCode(region.getRegionCode());
                    travel.setEdAddr(region.getAddress());
                }
            } catch (ServiceException e) {
                LOGGER.error(e.getMessage(), e);
            }
        }
    }

    public List<TravelEntity> filterNoFinishTravel(List<TravelEntity> list) {
        final List<TravelEntity> resultList = new ArrayList<TravelEntity>();
        for (TravelEntity travel : list) {
            if (travel.getEdTime() != null) {
                resultList.add(travel);
            }
        }
        return resultList;
    }
    public List<TravelEntity> queryTravel( Date startDate, Date endDate,String imei,String model) throws Exception {
        final List<TravelEntity> travelList = new ArrayList<TravelEntity>();
        GpsProcess gpsProcess = new GpsProcess(new GpsProcess.OnTrackListener() {
            @Override
            public void onStart(LacEntity lac) {
                if (!travelList.isEmpty()) {
                    TravelEntity last = travelList.get(travelList.size() - 1);
                    if (last.getEdTime() == null) {
                        last.setEdTime(lac.getDataTime());
                        last.setEdlng(lac.getClng());
                        last.setEdLat(lac.getClat());
                    }
                }
                TravelEntity travel = new TravelEntity();
                travel.setModel(lac.getModel());
                travel.setImei(lac.getImei());
                travel.setStTime(lac.getDataTime());
                travel.setStLat(lac.getClat());
                travel.setStLng(lac.getClng());
                travelList.add(travel);
            }

            @Override
            public void onStop(LacEntity lac) {
                if (!travelList.isEmpty()) {
                    TravelEntity last = travelList.get(travelList.size() - 1);
                    if (last.getEdTime() == null) {
                        last.setEdTime(lac.getDataTime());
                        last.setEdlng(lac.getClng());
                        last.setEdLat(lac.getClat());
                    }
                }
            }
        });
        long time1 = System.currentTimeMillis();
       
        List<LacEntity> list = DataFacade.getInstance().findTrackList(model, imei, startDate, date);
        
        
        System.out.println("time000 is ----------"+list.size());

        long time2 = System.currentTimeMillis();
        for (int idx = list.size() - 1; idx >= 0; idx--) {
            gpsProcess.process(list.get(idx));
        }

        System.out.println("time111   is ----------"+travelList.size());
        
        
       /*  final List<TravelEntity> resultList = filterNoFinishTravel(travelList); */
      // travelList.add(travelList.get(1));
       
       final List<TravelEntity> resultList=travelList;
       

        System.out.println("time222   is ----------"+resultList.size());
        
        
        
        
         Collections.sort(resultList, new Comparator<TravelEntity>() {
            public int compare(TravelEntity o1, TravelEntity o2) {
                return o1.getStTime().compareTo(o2.getStTime());
            }
        });  
         

        return resultList;
    }
%>
<%
    try {
        execute(request, response);
    } catch (Exception e) {
        LOGGER.error(e.getMessage(), e);
        sendError(response, "");
    }
%>