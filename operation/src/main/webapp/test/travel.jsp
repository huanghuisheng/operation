
<%@page import="com.broadsense.iov.lbs.GpsProcess"%>
<%@page import="com.broadsense.iov.lbs.LbsService"%>
<%@page import="com.broadsense.iov.lbs.pojo.GPSLacBean"%>
<%@page import="com.broadsense.iov.base.data.entity.TravelEntity"%>
<%@page import="com.broadsense.iov.base.data.entity.LacEntity"%>
<%@page import="com.broadsense.iov.weixin.Response"%>
<%@page import="com.broadsense.iov.base.data.entity.MediaEntity"%>
<%@page import="com.broadsense.iov.weixin.base.entity.WeixinDevEntity"%>
<%@page import="com.broadsense.iov.weixin.base.entity.SubscriberEntity"%>
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
        if (StringUtils.equals(act, "show")) {
            show(request, response);
            return;
        }
        index(request, response);
    }

    public void index(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Date date = new Date();
        Date startDate = DateUtils.dateAdd(DateUtils.resetDate(date), Calendar.DATE, -3);
        request.setAttribute("st", startDate.getTime());
        request.setAttribute("ed", date.getTime());
        WeixinDevEntity weixinDev = (WeixinDevEntity) request.getAttribute(REQUEST_SUB_DEV);
        long time1 = System.currentTimeMillis();
        List<TravelEntity> resultList = queryTravel(weixinDev, startDate, date);
        long time2 = System.currentTimeMillis();
        fillAddress(resultList);
        long time3 = System.currentTimeMillis();
        long diff1 = (time2 - time1) / 1000;
        long diff2 = (time3 - time2) / 1000;

        LOGGER.debug("dev:{}/{} QueryTravel:{}s FillAddress:{}s", new Object[]{weixinDev.getModel(), weixinDev.getImei(), diff1, diff2});
        request.setAttribute("resultList", resultList);
        forward(request, response, "/WEB-INF/pages/view/yyskys/travel-list.jsp");
    }

    public void show(HttpServletRequest request, HttpServletResponse response) throws Exception {
        long st = ParamUtils.getLong(request, "st", 0L);
        long ed = ParamUtils.getLong(request, "ed", 0L);
        Date startDate = new Date(st);
        Date endDate = new Date(ed);
        final List<LacEntity> resultList = new ArrayList<LacEntity>();
        WeixinDevEntity dev = (WeixinDevEntity) request.getAttribute(REQUEST_SUB_DEV);
        List<LacEntity> list = DataFacade.getInstance().findTrackList(dev.getModel(), dev.getImei(), startDate, endDate);
        GpsProcess gpsProcess = new GpsProcess(null);
        for (LacEntity gps : list) {
            if (gpsProcess.filter(gps)) {
                resultList.add(gps);
            }
        }

        String stAddr = ParamUtils.getString(request, "sta", "");
        String edAddr = ParamUtils.getString(request, "eda", "");

        request.setAttribute("resultList", resultList);
        request.setAttribute("stTime", startDate);
        request.setAttribute("edTime", endDate);
        request.setAttribute("stAddr", stAddr);
        request.setAttribute("edAddr", edAddr);

        forward(request, response, "/WEB-INF/pages/view/yyskys/travel-show.jsp");
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

    public List<TravelEntity> queryTravel(WeixinDevEntity dev, Date startDate, Date endDate) throws Exception {
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
        List<LacEntity> list = DataFacade.getInstance().findTrackList(dev.getModel(), dev.getImei(), startDate, date);
        long time2 = System.currentTimeMillis();
        for (int idx = list.size() - 1; idx >= 0; idx--) {
            gpsProcess.process(list.get(idx));
        }

        final List<TravelEntity> resultList = filterNoFinishTravel(travelList);
        resultList.sort(new Comparator<TravelEntity>() {
            public int compare(TravelEntity o1, TravelEntity o2) {
                return o2.getStTime().compareTo(o1.getStTime());
            }
        });
        long time3 = System.currentTimeMillis();

        long diff1 = (time2 - time1) / 1000;
        long diff2 = (time3 - time2) / 1000;

        LOGGER.debug("dev:{}/{} QueryFromDb:{}s SplitTravel:{}s", new Object[]{dev.getModel(), dev.getImei(), diff1, diff2});
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